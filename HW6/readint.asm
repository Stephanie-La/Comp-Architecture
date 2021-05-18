readint:
	lodd on:                
        stod 4093               

bgndig: call rbsywt:   		; using CSR memory locations         
        lodd 4092		; read in input at add. 4092
        subd numoff:		; subtract 48 to get number's ascii code
        push			; push read input on top of stack

nxtdig: call rbsywt:		; check if input is finished, can load input from address
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

endnum: 
	pop			; pop off stack and increment 
        retn