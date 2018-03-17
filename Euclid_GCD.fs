\ Requires gforth flavour local variables

\ Euclid's algorithm for the greatest common divisor
\ let d = gcd(a, b)
\ let a > b > 0, without loss of generality
\ write as a = qb + r
\ since r = a - qb, then if c is a common divisor of a and b, then it is
\ also a common divisor of b and r
\ since a = qb + r, then if c is a common divisor of b and r, then it is a
\ also a common divisor of a and b
\ hence a, b and b, r have common divisors and a common greatest divisor

: gcd ( a b -- d)
\ return the greatest common divisor of a and b
	swap over	( b a b)
	/MOD		( b r q)  		\ a = qb + r
	drop dup 0=	( b r flag)
	IF
		drop exit				\ d = b
	THEN		( b r)
	recurse			\ tail-recursion will be optimized to loop
;

: bezout ( a b -- u v d)
\ return the gcd, d, and Bezout multiples such that d = a.u + b.v
	over over < IF swap THEN  \ require a >= b
	1 0 0 1 { Un-2 Vn-2 Un-1 Vn-1 }		\ required priming for difference formula
	BEGIN			( a b)
		swap over	( b a b)
		/MOD		( b r q)	\ a = qb + r
		over 		( b r q flag)
	WHILE
		dup 				( b r q q )
		Un-1 * Un-2 swap - 	( b r q Un) \ Un = Un-2 - q * Un-1
		Un-1 to Un-2		( b r q Un) \ Un-2 <= Un-1
		to Un-1				( b r q)	\ Un-1 <= Un
		Vn-1 * Vn-2 swap - 	( b r Vn)
		Vn-1 to Vn-2		( b r Vn)
		to Vn-1				( b r)
	REPEAT
	drop drop 		( d)		\ d = b
	Un-1 Vn-1 rot	( u v d)
;
