CC = g++
CFLAGS =
OBJ = main.o
DEPS =
LIBS =
EXE = main

all: main

main: $(OBJ)
		$(CC) $(OBJ) -o $(EXE) $(LIBS)

main.o: main.c
		$(CC) -c $(CFLAGS) main.c -o main.o

clean:
		rm *.o $(EXE)

