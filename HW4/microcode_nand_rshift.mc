0:mar := pc; rd; 				{ main loop  }
1:pc := 1 + pc; rd; 				{ increment pc }
2:ir := mbr; if n then goto 28; 		{ save, decode mbr }
3:tir := lshift(ir + ir); if n then goto 19; 	
4:tir := lshift(tir); if n then goto 11; 	{ 000x or 001x? }
5:alu := tir; if n then goto 9; 		{ 0000 or 0001? }
6:mar := ir; rd; 				{ 0000 = LODD }
7:rd; 						
8:ac := mbr; goto 0; 				
9:mar := ir; mbr := ac; wr; 			{ 0001 = STOD }
10:wr; goto 0; 					
11:alu := tir; if n then goto 15; 		{ 0010 or 0011? }
12:mar := ir; rd; 				{ 0010 = ADDD }
13:rd; 						
14:ac := ac + mbr; goto 0; 			
15:mar := ir; rd; 				{ 0011 = SUBD }
16:ac := 1 + ac; rd; 				{ Note: x - y = x + 1 + not y }
17:a := inv(mbr); 				
18:ac := a + ac; goto 0; 			
19:tir := lshift(tir); if n then goto 25; 	{ 010x or 011x? }
20:alu := tir; if n then goto 23; 		{ 0100 or 0101? }
21:alu := ac; if n then goto 0; 		{ 0100 = JPOS }
22:pc := band(ir, amask); goto 0; 		{ perform the jump }
23:alu := ac; if z then goto 22; 		{ 0101 = JZER }
24:goto 0;					{ jump failed }
25:alu := tir; if n then goto 27; 		{ 0110 or 0111? }
26:pc := band(ir, amask); goto 0; 		{ 0110 = JUMP }
27:ac := band(ir, amask); goto 0; 		{ 0111 = LOCO }
28:tir := lshift(ir + ir); if n then goto 40; 	{ 10xx or 11xx? }
29:tir := lshift(tir); if n then goto 35; 	{ 100x or 101x? }
30:alu := tir; if n then goto 33; 		{ 1000 or 1001? }
31:a := sp + ir; 				{ 1000 = LODL }
32:mar := a; rd; goto 7; 			
33:a := sp + ir; 				{ 1001 = STOL }
34:mar := a; mbr := ac; wr; goto 10; 		
35:alu := tir; if n then goto 38; 		{ 1010 or 1011? }
36:a := sp + ir; 				{ 1010 = ADDL }
37:mar := a; rd; goto 13; 			
38:a := sp + ir; 				{ 1011 = SUBL }
39:mar := a; rd; goto 16; 			
40:tir := lshift(tir); if n then goto 46; 	{ 110x or 111x? }
41:alu := tir; if n then goto 44; 		{ 1100 or 1101? }
42:alu := ac; if n then goto 22; 		{ 1100 = JNEG }
43:goto 0; 					
44:alu := ac; if z then goto 0; 		{ 1101 = JNZE }
45:pc := band(ir, amask); goto 0; 		
46:tir := lshift(tir); if n then goto 50; 	
47:sp := sp + (-1); 				{ 1110 = CALL }
48:mar := sp; mbr := pc; wr; 			
49:pc := band(ir, amask); wr; goto 0; 		
50:tir := lshift(tir); if n then goto 65; 	{ 1111, examine addr }
51:tir := lshift(tir); if n then goto 59; 	
52:alu := tir; if n then goto 56; 		
53:mar := ac; rd; 				{ 1111000 = PSHI }
54:sp := sp + (-1); rd; 			
55:mar := sp; wr; goto 10; 			
56:mar := sp; sp := sp + 1; rd; 		{ 1111001 = POPI }
57:rd; 						
58:mar := ac; wr; goto 10; 			
59:alu := tir; if n then goto 62; 		
60:sp := sp + (-1); 				{ 1111010 = PUSH }
61:mar := sp; mbr := ac; wr; goto 10; 		
62:mar := sp; sp := sp + 1; rd; 		{ 1111011 = POP }
63:rd; 						
64:ac := mbr; goto 0; 				
65:tir := lshift(tir); if n then goto 73; 	
66:alu := tir; if n then goto 70; 		
67:mar := sp; sp := sp + 1; rd; 		{ 1111100 = RETN }
68:rd; 						
69:pc := mbr; goto 0; 				
70:a := ac; 					{ 1111101 = SWAP }
71:ac := sp; 					
72:sp := a; goto 0; 				
73:alu := tir; if n then goto 76; 		
74:a := band(ir, smask); 			{ 1111110 = INSP }
75:sp := sp + a; goto 0; 			
76:tir := tir + tir; if n then goto 80;		
77:a := band(ir, smask); 			{ 11111110 = DESP }
78:a := inv(a); 				
79:a := a + 1; goto 75; 			
80:tir := tir + tir; if n then goto 179;	{ 1111 1111 1x = DIV,HALT }
81:alu := tir + tir; if n then goto 103;        { 1111 1111 01 = RSHIFT }
82:a := lshift(1);				{ 1111 1111 00 = MULT }
83:a := lshift(a + 1);
84:a := lshift(a + 1);
85:a := lshift(a + 1);
86:a := lshift(a + 1);
87:a := a + 1;
88:b := band(ir, a);				{ build 6 bit mask and put multiplier in b }
89:mar := sp; rd;				
90:rd;
91:a := mbr;				{ get multiplicand (Mcnd) and put in a }
92:c := (-1);				{ set c to -1, if it's still -1 at the end result is neg }
93:d := 0;				{ zero d, use as accumulating counter }
94:alu := a; if n then goto 97; 	{ if Mcnd is negative goto 97}
95:c := c + 1; goto 97			{ if Mcnd is pos + 1 to c (c == 0) goto 97 }
96:alu := c; if z then goto 100;	{ if Mcnd is pos, this is OF, goto 100 }
97:b := b + (-1); if n then goto 101 	{ dec loop counter b, if done goto 101 }
98:d := d + a; if n then goto 96;	{ add multiplicand to counter, OF goto 96 }	
99:alu := c; if z then goto 97;		{ if MCnd is pos keep adding, goto 97 } 
100:ac := (-1); goto 0;			{ OF error here, set AC = -1, return }
101:mar := sp; ac := 0;			{ success AC = 0, replace Mcnd with sum on stack }
102:mbr := d; wr; goto 10;		{ put sum into MBR and write, goto 10 to finish }
103:a := lshift(1);			{ 1111 1111 01 = RSHIFT }
104:a := lshift(a + 1);
105:a := lshift(a + 1);
106:a := a + 1;
107:b := band(ir, a);
108:b := b + (-1); if n then goto 110;
109:ac := rshift(ac); goto 108;
110:goto 0;
111:alu := tir + tir; if n then goto 177; { 1111 1111 1x = HALT }
112:mar := sp;				{ 1111 1111 10 = DIV }
113:rd;					{ read in first arg aka dividend }
114:rd;
115:a := mbr;				{ dividend is stored in mbr }
116:sp := sp + 1; 			{ divisor is now at sp + 1 }
117:mar := sp;				{ updae mar to have new address }
118:rd;					{ read second arg aka divisor }
119:rd;
120:b := mbr;				{ divisor stored in mbr }
121:sp := sp + (-1);			{ go back to dividend }
122:alu := b; if z then goto 155;	{ checks alu if divisor is zero, goto 155 }
123:alu := a; if n then goto 176; 	{ if negative, goto 176 }
124:alu := b; if n then goto 127;	{ if negative, goto 127 }
125:b := inv(b);			{ invert value }
126:b := b + 1;				{ add 1 because of 2's complement }
127:c := a + b; if n then goto 165;	{ if divisor > dividend goto 165 }
128:d := 1; 				{ d = quotient / counter, valid subtraction }
129:a := c + b; if n then goto 144;	{ second round of subtraction, if neg goto 144 }
130:d := d + 1;				{ increment d++ }
131:c := a + b; if n then goto 133; 
132:d := d + 1; goto 129; 
133:sp := sp + (-1);			{ go to remainder in stack }
134:mar := sp;				{ write sp to mar }
135:mbr := a;				{ remainder in a goes into mbr }
136:wr;					{ write back into stack }
137:wr;
138:sp := sp +(-1);
139:mar := sp;
140:mbr := d;				{quotient d goes into mbr }
141:wr; 
142:wr;
143:ac := 0; goto 0;			{ end by going back to 0 }
144:sp := sp + (-1);			{ go to remainder in stack }
145:mar := sp;				{ write sp to mar }
146:mbr := c;				{ remainder in c goes into mbr }
147:wr;					{ write back into stack }
148:wr;
149:sp := sp + (-1);
150:mar := sp;
151:mbr := d;				{quotient d goes into mbr }
152:wr; 
153:wr;
154:ac := 0; goto 0;			{ end by going back to 0 }
155:sp := sp + (-1);			{ go to remainder in stack }
156:mar := sp;				{ write sp to mar }
157:mbr := (-1);			{ remainder is -1 goes into mbr }
158:wr;					{ write back into stack }
159:wr;
160:sp := sp + (-1);
161:mar := sp;
162:mbr := 0;				{quotient 0 goes into mbr }
163:wr; 
164:wr; ac := -1; goto 0;		{ ac = -1, go back to 0}
165:sp := sp + (-1);			{ go to remainder in stack }
166:mar := sp;				{ write sp to mar }
167:mbr := a;				{ remainder in a goes into mbr }
168:wr;					{ write back into stack }
169:wr;
170:sp := sp + (-1);
171:mar := sp;
172:mbr := 0;				{quotient 0 goes into mbr, divisor is bigger }
173:wr; 
174:wr;
175:ac := 0; goto 0;			{ end by going back to 0 }
176:a := inv(a);
177:a := a + 1; goto 125;
178:rd; wr;				{ 1111 1111 1x = HALT }
