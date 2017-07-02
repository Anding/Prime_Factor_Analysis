: constant-array ( n -- cn, return the nth constant, cn, in the array.  The first item is item zero)
	create does> swap cells +  @ 
;

constant-array prime-number  ( n -- pn, return the nth prime up to the 100th prime)
	1 , 2 , 3 , 5 , 7 , 11 , 13 , 17 , 19 , 23 , 29 , 
	31 , 37 , 41 , 43 , 47 , 53 , 59 , 61 , 67 , 71 ,
	73 , 79 , 83 , 89 , 97 , 101 , 103 , 107 , 109 , 113 , 
	127 , 131 , 137 , 139 , 149 , 151 , 157 , 163 , 167 , 173 , 
	179 , 181 , 191 , 193 , 197 , 199 , 211 , 223 , 227 , 229 , 
	233 , 239 , 241 , 251 , 257 , 263 , 269 , 271 , 277 , 281 ,
	283 , 293 , 307 , 311 , 313 , 317 , 331 , 337 , 347 , 349 , 
	353 , 359 , 367 , 373 , 379 , 383 , 389 , 397 , 401 , 409 ,
	419 , 421 , 431 , 433 , 439 , 443 , 449 , 457 , 461 , 463 , 
	467 , 479 , 487 , 491 , 499 , 503 , 509 , 521 , 523 , 541 ,

: is-factor ( n p -- n' flag, check if p is a factor of n. If so return n'=n/p and true, else n'=n and false)
		over swap	( n n p)
		/MOD		( n rem quo)
		swap IF	( n quo)	\ not a factor
			drop	
			false
		ELSE		( n quo)	\ is a factor
			nip
			true
		THEN
;

: prime-factors { n | index prime -- }
	\ print the prime factors of n
	1 -> index
	CR
	BEGIN
		index prime-number -> prime
		n prime is-factor swap -> n
		dup IF prime . THEN
		not IF index 1+ -> index THEN
		n 1 = 
	UNTIL
	CR
;


: factor-analysis { n1 n2 | index prime HCF LCM -- HCF LCM } 
	\ return the HCF and LCM of n1 and n2
	1 -> index 
	1 -> HCF 
	1 -> LCM
	BEGIN
		index prime-number -> prime
		n1 prime is-factor swap -> n1 		( flag)
		n2 prime is-factor swap -> n2 		( flag flag)
		over over and IF HCF prime * -> HCF THEN	( flag flag)
		or dup IF LCM prime * -> LCM THEN		( flagORflag)
		not IF index 1+ -> index THEN
		n1 1 = n2 1 = AND
	UNTIL
	HCF LCM
;
