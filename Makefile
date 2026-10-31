CC     = gcc
MPICC  = mpicc
CFLAGS = -O2 -Wall -std=gnu11

all: MonteCarloSequential MPIMonteCarlo

MonteCarloSequential: MonteCarloSequential.c montecarlo.h
	$(CC) $(CFLAGS) -o $@ $<

MPIMonteCarlo: MPIMonteCarlo.c montecarlo.h
	$(MPICC) $(CFLAGS) -o $@ $<

clean:
	rm -f MonteCarloSequential MPIMonteCarlo