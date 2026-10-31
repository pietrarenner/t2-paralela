# Parametros comuns a todos os jobs (incluido pelos scripts .sbatch).
POINTS=20000       # pontos por tarefa = custo de uma tarefa
TASKS=180000       # tarefas da entrada de referencia
GRAIN=10           # granularidade escolhida
GRAINS="1 2 5 10 20 50 100 500 2000 5000"   # varredura do gran.sbatch: de bem menor a bem maior
REPS=10
PROCS="2 4 8 16 32 64"

run_mpi() {   # run_mpi <P> <tasks> <grain>
    local per_node=$(($1 / 2)) extra=""
    [ "$per_node" -gt "${SLURM_CPUS_ON_NODE:-32}" ] && extra="--overcommit"
    srun -N 2 -n "$1" --ntasks-per-node=$per_node $extra \
         ./MPIMonteCarlo "$2" "$POINTS" "$3"
}
