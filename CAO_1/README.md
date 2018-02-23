

#H1 Assignment 1

Q&A:

**Q1:** Compare the global MIPS rating to the program-dependent MIPS ratings. Com-
ment on your findings.

**A1:** The Global MIPS rating of the computer is different from the program-dependent MIPS rating because the Global MIPS rating is calculated based on the average CPU cycles per instruction assuming each instruction is executed the same amount of times. Contrary, when calculating the program-dependent MIPS rating we do take the amount of instructions per instruction inside the program in consideration. 

**Q2:** The book (see §1.10 of [2]) clearifies that the MIPS rating is not a good perfor-
mance indicator. Does your simulation confirm this? Explain!

**A2:** The book mentions three problems with using MIPS as performance indicator.
1. MIPS Rating does not take into account the capabilities of a instruction.
2. MIPS Rating can be different between applications on the same computer
3. MIPS Rating can vary independently from performance.

From the simulation we can clearly see that the second problem applies. On each computer performs differently for each application. For example program A runs better on computer 2 then on computer 1 but program C runs better on computer 1 then on computer 2. Therefore it is hard to compare the computers with each other based on MIPS Rating. It really depends on what application you are running. 

---- computer 1 ----
Clock rate	: 1 [GHz]
CPI Arith	: 2 [cpi]
CPI Store	: 2 [cpi]
CPI Load	: 3 [cpi]
CPI Branch	: 4 [cpi]

Global MIPS Rating	: 363.636
MIPS Program A		: 478.723
MIPS Program B		: 363.636
MIPS Program C		: 350


---- computer 2 ----
Clock rate	: 1.2 [GHz]
CPI Arith	: 2 [cpi]
CPI Store	: 3 [cpi]
CPI Load	: 4 [cpi]
CPI Branch	: 3 [cpi]

Global MIPS Rating	: 400
MIPS Program A		: 556.701
MIPS Program B		: 380.952
MIPS Program C		: 339.394


---- computer 3 ----
Clock rate	: 2 [GHz]
CPI Arith	: 2 [cpi]
CPI Store	: 2 [cpi]
CPI Load	: 4 [cpi]
CPI Branch	: 6 [cpi]

Global MIPS Rating	: 571.429
MIPS Program A		: 918.367
MIPS Program B		: 571.429
MIPS Program C		: 538.462
