LOOP:	LODD PassCnt:			; num of fibs to do in PasCnt (5)			
	JZER DONE:			; jump to Done if Pass = 0
	SUBD c1:
	STOD PassCnt:			; store passes remaining
	LODD daddr:			; load a pointer to fib arg
	PSHI				; push AC/fib arg on stack
	ADDD c1:
	STOD daddr:			; increment, store ptr for next d0[n]
	CALL FIB:			; call fib (arg on stack)
	INSP 1				; clear stack on fib return
	PUSH				; return AC (fib(n)) on stack
	LODD faddr:			; load faddr to result array f[n]
	POPI				; pop result off stack into f[n]
	ADDD c1:			
	STOD faddr:			; increment, store pointer for next element f[n]
	JUMP LOOP:			; goto top of LOOP for next pass
FIB:	LODL 1				; fib function load 1st arg from stack
	JZER FIBZER:			; if fib arg == 0 goto FIBZER
	SUBD c1:			; decrement arg value in AC (arg - 1)
	JZER FIBONE:			; if fib arg == 0 go to FIBONE
	PUSH				; update stack with fib arg 
	CALL FIB:			; (fn1 = rfib(arg-1)) -> call FIB function (arg on stack)
	PUSH				; update stack with fib arg
	LODL 1				; fib function load 2nd arg from stack
	SUBD c1:			; decrement arg value in AC
	PUSH				; update stack with fib arg
	CALL FIB:			; (fn2 = rfib(arg-2)) -> call FIB function (arg on stack)
	INSP 1				; increment stack ptr by 1 space
	ADDL 0			 	; (fn1+fn2) -> AC + [stackpointer + 0] or  m[sp + 0]
	INSP 2				; increment stack ptr by 2 spaces
	RETN
FIBZER:	LODD c0:
	RETN				; AC = 0 for fib(0)
FIBONE: LODD c1:
	RETN				; AC = 1 for fib(1)
DONE:	HALT
.LOC 	100				; locate data beginning at 100
d0:	3				; array of args for fib function
	9
	18
	23
	25
f0:	0				; array of result locs for fib returns
	0
	0
	0
	0
daddr:	d0:				; start address of fib args 
faddr:	f0:				; start address of fib results
c0:	0				; constants
c1:	1
PassCnt: 5				; number of data elements to process
