#!/bin/bash
#SBATCH -J t2-gran
#SBATCH -N 2
#SBATCH --exclusive
#SBATCH -t 01:00:00
#SBATCH -o results/raw/%x-%j.out
#SBATCH --nodelist=atlantica[03-04]
source scripts/params.sh
echo "# nodes=$SLURM_JOB_NODELIST cpus_per_node=$SLURM_CPUS_ON_NODE"
for g in $GRAINS; do
    for r in $(seq $REPS); do run_mpi 32 $TASKS $g; done
done
