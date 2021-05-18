; get input, convert into binary in data locations
; add them, then print out result

; pushes thing onto stack
; pop gets into AC, pop off stack

; start program
start: 	lodd on:		; load 8, the turn-on number
	stod 4095		; the above happens in add. 4095
	call xbsywt:		; load the message to prompt user
	loco str1:		; set AC to a pointer to beginning of str1

; output to get 2-char blocks to print out
nextw:  pshi			; push that pointer on the stack
        addd c1:		; add 1 to string ptr to point to next 2 characters in string
        stod pstr1:		; store into hold add. of locations in string as it moves
        pop			; takes first 2 letters and put into AC
        jzer crnl:		; jump if AC = 0  to carriage return newline, hit end of string
        stod 4094		; low byte will be transmitted to screen
        push			; push value back on stack, still in AC
        subd c255:		; subtract 255 to see if there is another character in upper 8 bits
        jneg crnl:		; jump if AC < 0 to carriage return newline
        call sb:		; call to shift bits so upper 8 bits are now the lower 8 bits, and is now ready for printing
        insp 1			; increment stack ptr bc I need to take arg off of stack pushed on earlier
        push			; push what is in AC (2 bytes swapped) to top of stack
        call xbsywt:		; check if there transmitter is done printing 
        pop			; pop arg off stack and out of AC
        stod 4094		; second character is transmitted to screen
        call xbsywt:		; check if there transmitter is done printing
        lodd pstr1:		; update the add. of location in string as it moves
        jump nextw: 		; loop back to top of nextw

; carriage return, new line
crnl:   lodd cr:		; lodd cr with ascii code 13
        stod 4094		; store cr which is what you want to print (beginning of line)
        call xbsywt:		; check if there transmitter is done printing
        lodd nl:		; lodd n1 with ascii code 10
        stod 4094		; store nl which is what you want to print
        call xbsywt:		; check if there transmitter is done printing
	lodd on:                ; mic1 program to print string
        stod 4093               ; and scan in a 1-5 digit number

; beginning digit
bgndig: call rbsywt:		; using CSR memory locations
	lodd 4092		; read in input at add. 4092
	subd numoff:		; subtract 48 to get number's ascii code
	push			; push read input on top of stack

; next digit
nxtdig:	call rbsywt:		; check if input is finished, can load input from address
	lodd 4092		; read in input at add. 4092
	stod nxtchr:		; store new char temporarily read in
	subd nl:		; subtract 10 
        jzer endnum:		; jump to endnum if AC = 0
	mult 10			; ten's place constructor
	lodd nxtchr:		; load the next character 
	subd numoff:		; subtract 48 to get number's ascii code/ binary number
	addl 0			; local instructions add 0 to top of stack ac + sp + x
	stol 0			; local instructions store 0 to top of stack sp + x = AC
	jump nxtdig:		; loop back to top of nextdig

; storing full input into location to grab second number
endnum: lodd numptr:		; lodd numpt which points to binum1
        popi			; pop indirect numptr off stack, sp + 1 
        addd c1:		; add direct AC + sp(sp = 1)
        stod numptr:		; store this into numptr
        lodd numcnt:		; load numcnt 
        jzer addnms:		; jump to addnms if AC = 0
        subd c1:		; subtract AC - 1 from string ptr
        stod numcnt:		; store this into numcnt
        jump start:		; jump to beginning

; add the 2 inputs together, goes to nextw2 and crnl2
addnms: lodd binum1:		; load first binary # onto stack
	stod sum:		; start loading sum into stack
	lodd binum2:		; load second binary # onto stack
	addd sum:		; add second number to the sum
	stod sum:		; the store it to the sum total
	jneg ovrflw:		; if neg, sum > total goto ovrflw
	loco str2:		; load in the sum string on stack
	call nextw2:		; trasnmit sum string to screen
	call cvtnum:		; convert number to ascii bytes
	lodd zero:		; return 0 for success/ no overflow 	
	halt	

;tranmitter check
xbsywt: lodd 4095		; "O" and "D" are on
        subd mask:		; subtract 1010 "10"
        jneg xbsywt:		; if AC < 0 jump to xbsywt for transmitter
        retn			; return to address that called xbsywt

; read bsywt
rbsywt: lodd 4093		; pull out input when ready
        subd mask:		; subtract 1010 "10"
        jneg rbsywt:		; if AC < 0 jump to rbsywt for transmitter
        retn			; return to address that called rbsywt

; shift the bits
sb:     loco 8			; load constant of 8, turn on transmitter
loop1:  jzer finish:		; jump to finish loop if AC = 0
        subd c1:		; subtract c1 from 
        stod lpcnt:		; store lpcnt at AC
        lodl 1			; load local 1 (sp + 1)
        jneg add1:		; jump to add1 if AC < 0
        addl 1			; add local 1 (AC + (sp + 1))
        stol 1			; store local 1 (sp + 1 = AC)
        lodd lpcnt:		; load lpcnt to keep track of loops
        jump loop1:		; jump back to loop1
add1:   addl 1			; add local 1 for offset (AC + (sp + x)) 
        addd c1:		; add c1 (AC + 1 + sp)
        stol 1			; store local 1 (sp + 1) 
        lodd lpcnt:		; load lpcnt 
        jump loop1:		; jump to loop1
finish: lodl 1			; lod local 1 (sp + 1)
        retn			; return to calling address

; done with program
done: 	retn

; overflow message and label, goes to nextw3 and crnl3
ovrflw: loco str3:		; load overflow string message
	call nextw3:		; transmit message to screen
	lodd ng1:		; load direct a -1 for overflow
	halt

; nextw2, nextw3, crnl2, crnl3 together, copies of the original nextw and crnl
nextw2:	pshi			; push that pointer on the stack
        addd c1:		; add 1 to string ptr to point to next 2 characters in string
        stod pstr1:		; store into hold add. of locations in string as it moves
        pop			; takes first 2 letters and put into AC
        jzer crnl2:		; jump if AC = 0  to carriage return newline, hit end of string
        stod 4094		; low byte will be transmitted to screen
        push			; push value back on stack, still in AC
        subd c255:		; subtract 255 to see if there is another character in upper 8 bits
        jneg crnl2:		; jump if AC < 0 to carriage return newline
        call sb:		; call to shift bits so upper 8 bits are now the lower 8 bits, and is now ready for printing
        insp 1			; increment stack ptr bc I need to take arg off of stack pushed on earlier
        push			; push what is in AC (2 bytes swapped) to top of stack
        call xbsywt:		; check if there transmitter is done printing 
        pop			; pop arg off stack and out of AC
        stod 4094		; second character is transmitted to screen
        call xbsywt:		; check if there transmitter is done printing
        lodd pstr1:		; update the add. of location in string as it moves
        jump nextw2: 		; loop back to top of nextw2

crnl2:  lodd cr:		; lodd cr with ascii code 13
        stod 4094		; store cr which is what you want to print (beginning of line)
        call xbsywt:		; check if there transmitter is done printing
        lodd nl:		; lodd n1 with ascii code 10
        stod 4094		; store nl which is what you want to print
        call xbsywt:		; check if there transmitter is done printing
	

nextw3: pshi			; push that pointer on the stack
        addd c1:		; add 1 to string ptr to point to next 2 characters in string
        stod pstr1:		; store into hold add. of locations in string as it moves
        pop			; takes first 2 letters and put into AC
        jzer crnl3:		; jump if AC = 0  to carriage return newline, hit end of string
        stod 4094		; low byte will be transmitted to screen
        push			; push value back on stack, still in AC
        subd c255:		; subtract 255 to see if there is another character in upper 8 bits
        jneg crnl3:		; jump if AC < 0 to carriage return newline
        call sb:		; call to shift bits so upper 8 bits are now the lower 8 bits, and is now ready for printing
        insp 1			; increment stack ptr bc I need to take arg off of stack pushed on earlier
        push			; push what is in AC (2 bytes swapped) to top of stack
        call xbsywt:		; check if there transmitter is done printing 
        pop			; pop arg off stack and out of AC
        stod 4094		; second character is transmitted to screen
        call xbsywt:		; check if there transmitter is done printing
        lodd pstr1:		; update the add. of location in string as it moves
        jump nextw2: 		; loop back to top of nextw

crnl3:  lodd cr:		; lodd cr with ascii code 13
        stod 4094		; store cr which is what you want to print (beginning of line)
        call xbsywt:		; check if there transmitter is done printing
        lodd nl:		; lodd n1 with ascii code 10
        stod 4094		; store nl which is what you want to print
        call xbsywt:		; THIS CAN CALL SOMETHING CHANCE XBSYWT
	
; convert result to ascii bytes
cvtnum:	lodd on:		; load 8, the turn-on number for transmitter 
	stod 4095		; the above happens in add. 4095
	lodd ng1:		; load -1 into AC
	push			; push onto stack
	lodd mask:		; load mask onto AC
	push			; push onto stack
	jump anwlp:		; jump to answer loop

; loop to retrieve answer onto stack
anwlp:	lodd ng1:		; load -1 so looping can stop later
	lodd sum:		; load direct sum into AC
	jzer pntsum:		; if AC = 0 jump to pntsum (print sum)
	lodd mask:		; load mask into AC
	push			; push mask onto AC
	lodd sum:		; load total sum into AC
	push			; push sum onto the stack
	div			; divide sum by 10 
	pop			; store this result into the AC, pop off stack
	stod sum:		; store new result into sum
	pop			; pop off stack into AC
	insp 2			; increment sp 2 to clear sum and mask off of stack
	addd numoff:		; convert binary back to ascii value by adding 48
	push			; push onto AC on stack	
	jump anwlp:		; loop back top and keep going


; print the sum out 
pntsum:	pop 			; pop sum into AC 
	jneg done:		; if AC < 0 then goto done
	stod 4094		; store into output address
	call xbsywt:		; check if transmitter is done printing
	jump pntsum:		; loop back to again to print next sum
	

; 4092 = input
; 4093 = receiver/ scan
; 4094 = printing/ output
; 4095 = transmitter turn on

numoff: 48
nxtchr: 0
numptr: binum1:
binum1: 0
binum2: 0
lpcnt:  0
mask:   10
on:	8
nl:     10
ng1:	-1
zero:	0
cr:     13
c1:     1
c10:    10
c255:   255
sum:    0
numcnt: 1
pstr1:  0
str1:   "Please enter a 1-5 digit number followed by enter"
str2:	"The sum of these integers is:"
str3:	"Overflow, no sum possible "