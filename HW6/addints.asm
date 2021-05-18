addints: lodd binum1:		; load first binary # onto stack
	 stod sum:		; start loading sum into stack
	 lodd binum2:		; load second binary # onto stack
	 addd sum:		; add second number to the sum
	 stod sum:		; the store it to the sum total
	 jneg ovrflw:		; if neg, sum > total goto ovrflw
	 lodd sum:		; return 0 for success/ no overflow 	
	 retn

; overflow message and label
ovrflw: lodd ng1:		; load direct a -1 for overflow
	retn