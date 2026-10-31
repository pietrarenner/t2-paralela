/*
 * Uma tarefa é sortear n pontos (x, y) no quadrado [0,1] x [0,1] e contar
 * quantos caem dentro do quarto de circulo x^2 + y^2 <= 1
 *
 * a semente da tarefa é o proprio indice da tarefa, e rand_r guarda o estado 
 * na variavel 'seed' em vez de num estado global
 */

#ifndef MONTECARLO_H
#define MONTECARLO_H

#include <stdlib.h>

// processa a tarefa de indice 'task' com n pontos e devolve quantos pontos cairam dentro do circulo
static inline int compute_task(int task, int n) {
    unsigned int seed = (unsigned int) task + 1;
    int count = 0;
    for (int i = 0; i < n; i++) {
        double x = (double) rand_r(&seed) / RAND_MAX;
        double y = (double) rand_r(&seed) / RAND_MAX;
        if (x * x + y * y <= 1.0)
            count++;
    }
    return count;
}


// total    = soma das contagens (dá a estimativa de pi)
// checksum = soma de (i+1) * counts[i]
    // bate com a sequencial se cada resultado voltou para a sua posicao de origem no saco
static inline void checksums(int num_tasks, const int *counts, long long *total, long long *checksum) {
    *total = 0;
    *checksum = 0;
    for (int i = 0; i < num_tasks; i++) {
        *total += counts[i];
        *checksum += (long long) (i + 1) * counts[i];
    }
}

#endif
