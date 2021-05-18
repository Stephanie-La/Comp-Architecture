********************************************************
Name: Stephanie La
Email: Stephanie_la@student.uml.edu

1. I think my degree of success is a 99-100%. I think I 
solved the assignment problem to the best of my abilities
with the 1 test case and 5 arguments provided and matched
the professor's output on the assignment page. There 
could be a minor error in the stack if given a different 
case, but it should work fine with any cases or test 
runs. I was able to get the same output with 115 lines
versus his example of 116 lines, but after talking to 
professor Moloney, he says as long as the outputs matches,
it should not matter how many lines it took to write the 
program.

2. Although professor Moloney had revealed a significant 
amount of code solution to the class, I was able to 
implement his code, and writing my own comments along it
to further comprehend what the recursive fib function was 
doing. I had to understand what each label was doing, and
how the ifib.asm example program varied from the rfib.asm 
that was written. I realized that there was an iteration 
loop written for ifib.asm that kept track of the number
of loops after the fib function would store a 0 or 1 in
the AC depending on the fib function input. The ITER 
label and loop count was removed and instead of storing 
old fib values within a tmp register, the FIB function
would get two arguments off the stack and then store a 0
or 1 in the AC depending on the fib function input of 0 
or 1. Then fn1 and fn2 would be assigned to call the 
fib function again rib(arg - 1) of itself, and return
a value (fn1 + fn2) back to the fib function again and
therefore it is recursive.


3. There were no problems encountered during this 
program that was left unresolved.
********************************************************

