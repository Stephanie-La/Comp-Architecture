***************************************************************
Name: Stephanie La
Email: Stephanie_la@student.uml.edu

1. I think my degree of success is 93-97% because
I was able to get the correct answer from the 
arithmetic operation. However it would
also print out a garbage value followed by a prompt 
again. I tried so hard to get rid of both the extra
prompt and the garbage but wasn't able to and ran out
of time. However, when I put in the numbers that were
supposed to give overflow, it gave the overflow message
accurately (in the output file)!
Any help to solve this problem would be 
greatly appreciated.

2. First, I had to take my previous a5 homework and 
split it up into a couple of parts. Linker.c and Makefile
was provided by Professor Moloney. Xbsywt, rbsywt,
addints, data, and main were easy to split, but 
splitting readint, writeint, writestrm were a bit 
tricky. I eventually began to group chunks of code
that was used to iterate/read strings and intetgers and 
eventually began to group them into its respective
asm files into necessary functions and changed them
so there would be some instructions like halt removed
since it wasn't part of a complete asm file. I tried
rearranging the object files in the command ./linker 
main.obj readint.obj writeint.obj writestr.obj 
addints.obj xbsywt.obj rbsywt.obj data.obj> program.exe
because I kept getting te extra prompt. I felt like 
it would read/ write the integer and then fall through 
with addint and then it would return an incomplete 
addition operation, leading it to my problem I had.
I had to make sure each label and each piece of data was 
included in the data.asm file to account for. I then
wrote the commands to build each object file and then
the linker, and then the object file, then the executable.

3. There were no problems encountered during this 
program that was left unmentioned. All problems were
described in number 1.
***************************************************************


