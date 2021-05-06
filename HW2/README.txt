********************************************************
Name: Stephanie La
Email: stephanie_la@student.uml.edu

1. I think my degree of success is a 99%. I think I 
solved the assignment problem to the best of my abilities
and I could be off by rounding but I got the program
to check for an inifity exponent pattern.

2. How I approached this took a lot of time and 
brainstorming. I realized that I needed to import the 
whole chunk of bit_string from the previous assignment
so I could print out all the bits when it was displayed.
After doing so, I realized I didn't want to print out
bit strings for each structure instance, so I wrote a 
function to help print out all the bits for each 
instance. Then I went back and began analyzing each part
of the code and began to format the output. I made sure
I understood each part where mantissa and exponents 
were assigned to helper variables, then checked for 
normalization and pushed the hidden bit in if normalized.
Then I had to understand that that we had to shift the 
mantissa of the smaller value for a common exponent. 
After that, we had to right shift the bits and increase 
the exponent if there was more than 24 bits. To write 
code to check for the infinity exponent pattern, I had
to make sure that one or the other value was at 254 
already, because if one number is already at 254, then
automatically there would be overflow, similar to a 
9 + 1 situation. In that if statement, I then assigned
the result exponent to 255 and result mantissa to 0.

3. There were no problems encountered during 
this program that was left unresolved.
********************************************************

