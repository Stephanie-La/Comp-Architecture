****************************************************************************
Name: Stephanie La
Email: Stephanie_la@student.uml.edu

1. I think my degree of success is 90-95% because I put a lot of time and 
energy working on this assignment to really fully understand it and comment it 
to the best of my abilities. I did not have enough time to implement a 
quotient sign check, but the division/ DIV operator should work fine. 
Tokendefs.h is a complementary header file the professor wanted us to include
to shorten the reference of tokens as he said in his lectures.

2. Although professor Moloney had revealed a significant 
amount of code solution to the class, I was able to 
implement his code, and comprehend what each file was needed for.
My goal was to make a working assembler. I first had to understand that I
needed the .ll files and .mc and .c files to compile and output a working
program masm_mr that would understand how to handle NAND, MULT, and DIV 
commands. After making adjustments to each file, I modified the .mc file,
and included the MULT operator and the DIV operator. DIV was tricky since 
there was no subtraction operation. I first had to first read in the two 
arguments, then store them in mbr, then check if the divisor was zero,
so it would be checked as a zero and writen back onto the stack. Then, 
I checked to see if both the dividend and the the divisor was also were 
negative, I kept track of them and then checked to see if the divisor was 
bigger than the dividend, I would jump. I did checks to make sure the
division process would work on eligibile numbers. I then invert the value
and add 1 to it when it's positive in order for the divisor to be negative
since there is no division operation. I then wrote a loop to loop through
the divison until it hit 1 or 0 and would be written back onto the stack.
I resused registers a and c to save the dividend and quotient to 
resuse it in the loop. b would be used as my divisor register.
I kept a counter to increment the amount of times it would loop through. 
Then, I would end up writing remainders and quotients into the stack to keep
track of each dividend and checked the quotient and remainder towards the end
of the code. 

3.There were no problems encountered during this 
program that was left unresolved.
****************************************************************************
