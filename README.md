# T2 – Mestre/escravo com MPI: Monte Carlo para pi

Estimativa de pi por Monte Carlo no modelo mestre/escravo, para o cluster
Atlântica do LAD. Baseado em:
[JasonPollman/MPI-Monte-Carlo](https://github.com/JasonPollman/MPI-Monte-Carlo).
Os arquivos originais estão preservados em `original/`.

## Modelagem (`MPIMonteCarlo.c`)

- **Tarefa** (`montecarlo.h`, `compute_task`): sortear `n` pontos com
  `rand_r(&seed)`, em que `seed` é o índice da tarefa, e contar quantos caem no
  quarto de círculo. O resultado não depende de qual escravo processou a
  tarefa.
- **Saco:** tarefas `0 .. num_tasks-1`. O mestre guarda `next` (a próxima a
  distribuir) e o vetor `counts[]`.
- **Granularidade:** cada mensagem leva um lote `{first, size}` com
  `size = grain` tarefas seguidas. O último lote pode ser menor.
- **Tags**: `TAG_KILL` (0), `TAG_REQUEST` (100), `TAG_WORK`
  (200), `TAG_RESULT` (300), `TAG_COMPUTATIONS` (400) e `TAG_NAME` (500).
  As duas últimas são estatísticas, enviadas fora da região medida.
- **Iniciativa do escravo:** cada resultado também vale como pedido.
- **Ordem de chegada:** `MPI_Recv` com `MPI_ANY_SOURCE`.
- **Ordem do saco:** `first` vai e volta com o lote, e o mestre grava em
  `counts[first + k]`. O checksum `Σ (i+1)·counts[i]` só bate com o
  da versão sequencial se a ordem foi mantida.
- **Término:** saco vazio → `TAG_KILL` e o escravo sai do laço.

## Compilar

```bash
make
```

## Rodar no cluster

Os parâmetros ficam em `scripts/params.sh`.

```bash
make && mkdir -p results/raw
```

Para rodar o código sequencial:

```bash
sbatch scripts/seq.sbatch
```

Para rodar para escalabilidade forte:

```bash
sbatch scripts/strong.sbatch
```

Para rodar para escalabilidade fraca:

```bash
sbatch scripts/weak.sbatch
```

Para fazer o teste de granularidade:

```bash
sbatch scripts/gran.sbatch
```
