writeint:
	lodd on:		; load 8, the turn-on number for transmitter
	stod 4095		; the above happens in add. 4095

cvnum: 	lodd ng1:		; load -1 so looping can stop later
	lodd sum:		; load direct sum into AC
	jzer ptsum:		; if AC = 0 jump to ptsum (print sum)
	lodd mask:		; load mask into AC
	push			; push mask onto AC
	lodd sum:		; load total sum into AC
	push
	div			; divide sum by 10
	pop			; store this result into the AC, pop off stack
	stod sum:		; store new result into sum
	pop			; pop remainder off stack into ac, increment
	insp 2			; increment sp 2 to clear sum and mask off of stack
	addd numoff:		; convert binary back to ascii value by adding 48
	push			; push onto stack
	jump cvnum:		; loop back top and keep going

ptsum:  pop			; pop sum into ac
	jneg done:		; if AC < 0, goto done	
	stod 4094		; store into output address
	call xbsywt:		; check if transmitter is done printing
	jump ptsum:
done:
	loco 0
        retn	