FLAGS = -Wall -Werror -Wextra -std=c11 -g
CC = gcc
FUNCTIONS = factorial.c

all: clean factorial.a factorial

factorial.o: $(FUNCTIONS) factorial.h
	$(CC) $(FLAGS) -c $(FUNCTIONS)

factorial.a: factorial.o
	ar rcs factorial.a *.o
	ranlib factorial.a
	rm -rf *.o

factorial:
	$(CC) $(FLAGS) main.c factorial.a

assembly:
	$(CC) -S -o factorial0.s factorial.c -O0 
	$(CC) -S -o factorial1.s factorial.c -O1 
	$(CC) -S -o factorial2.s factorial.c -O2 
	$(CC) -S -o factorial3.s factorial.c -O3 
	$(CC) -S -o factorialS.s factorial.c -Os 

clean:
	rm -rf *.o *.a *.out