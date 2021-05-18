; output to get 2-char blocks to print out
writestr:  pshi			; push that pointer on the stack
           addd c1:		; add 1 to string ptr to point to next 2 characters in string
           stod pstr1:		; store into hold add. of locations in string as it moves
           pop			; takes first 2 letters and put into AC
           jzer crnl:		; jump if AC = 0  to carriage return newline, hit end of string
           stod 4094		; low byte will be transmitted to screen
           push			; push value back on stack, still in AC
           subd c255:		; subtract 255 to see if there is another character in upper 8 bits
           jneg crnl:		; jump if AC < 0 to carriage return newline
           call sb:		; call to shift bits so upper 8 bits are now the lower 8 bits, and is now ready for printing
           insp 1		; increment stack ptr bc I need to take arg off of stack pushed on earlier
           push			; push what is in AC (2 bytes swapped) to top of stack
           call xbsywt:		; check if there transmitter is done printing 
           pop			; pop arg off stack and out of AC
           stod 4094		; second character is transmitted to screen
           call xbsywt:		; check if there transmitter is done printing
           lodd pstr1:		; update the add. of location in string as it moves
           jump writestr: 	; loop back to top of nextw

; carriage return, new line
crnl:   lodd cr:		; lodd cr with ascii code 13
        stod 4094		; store cr which is what you want to print (beginning of line)
        call xbsywt:		; check if there transmitter is done printing
        lodd nl:		; lodd n1 with ascii code 10
        stod 4094		; store nl which is what you want to print
        call xbsywt:		; check if there transmitter is done printing
	retn

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
