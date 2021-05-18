**************************************************************************
Name: Stephanie La
Email: stephanie_la@student.uml.edu

1. I think my degree of success is 93-99%. I was able to
print out the two numbers I needed to add together, the 
strings to display messages or prompt the user to input
something, and the sum of the two numbers. However, a weird
garbage symbol would show up before the sum on top, as 
displayed in my output. I maybe have extra junk values 
stored in the sum, but I wasn't able to find and fix the 
error. I may have printed out the garbage value by accident
as well. I am proud that I took the time to comment, 
understand, and implement the rest of the code to it's 
working ability. 
It would be greatly appreciated if you would be able to
give me advice or a hint to help me locate where the 
problem is, it would be greatly appreciated!

2. First I had to go through and comment out every single 
line of the program to fully understand what each label was
supposed to be doing. I had to fully understand that start, 
nextw, and crnl were all written to wait and receive input 
from a string and once given input, each digit would be 
read and stored into memory locations and will convert each
of the input from ascii values to binary integers. Then 
after that number was read in, it would grab the second 
number and started reading and scanning each digit in from
the second input. xbsywt and rbsywt were functions designed
for the transmitter and to wait and read in input. 
I started writing Addnums by loading the two numbers and then
storing their sum and checking for overflow before proceeding.
I then called the display message and then called cvtnum to 
convert the binary numbers back to ascii bytes, and then the 
sum would be passed to the answer label, where the sum digits
would be pushed onto the stack one by one. After dividing the 
sum and storing the remainder, I added back 48 to get back the
ascii value. I eventually would print out the sum in a string
to the screen and loop until it was done printing.
I also wrote a overflow function to display the error message.
One thing I had encountered was I had the sum printing an infinite
loop of garbage values, and I realized I had to make extra copies of 
labels nextw and crnl so when a result was stored, it would not go back
to the beginning of the code to look for input again. I took out lines
lodd on and stod 4093 so they would not be looking for any values to scan 
in.

3. There were no problems encountered during this 
program that was left unresolved.

**************************************************************************
