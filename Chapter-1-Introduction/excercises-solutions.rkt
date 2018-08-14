#lang racket
(require (planet dyoo/simply-scheme:2:2))

; 2.1  In each line of the following table we've left out one piece of information.
; Fill in the missing details.

; function	arg 1	arg 2	result
;  word	 now	 here
;  sentence 	 now	 here
;  first	 blackbird	 none
;  first	 (blackbird) 	 none
;  3	 4	 7
;  every		 (thank you girl) 	 (hank ou irl) 
;  member?	 e	 aardvark
;  member?	 the		 #t
;  keep	 vowel?	 (i will)
;  keep	 vowel?		 eieio[5]
;  last	 ()	 none	


(word 'now 'here) ; 'nowhere
(sentence 'now 'here) ; '(now here)
(first 'blackbird) ; 'b
(first '(blackbird)) ; 'blackbird
(member? 'e 'aaardvark) ; false

; 2.2   What is the domain of the vowel? function?
; Answer: string -> bool

; 2.3  One of the functions you can use is called appearances. Experiment with it, and then ; describe fully its domain and range, and what it does. (Make sure to try lots of cases. ; Hint: Think about its name.)

; Answer: Counts the number of appearances of the string in list
; string -> list -> int
(appearances 'a 'aaardvark) ; 4.
(appearances 'r 'aaardvark) ; 2. 

;2.4  One of the functions you can use is called item. Experiment with it, and then ; describe fully its domain and range, and what it does.

; Answer: Retrieve the ith item from the list
; int -> list -> string
(item 5 'aaardvark) ; 'd

;The following exercises ask for functions that meet certain criteria. For your convenience, here are the functions in this chapter: +, -, /, <=, <, =, >=, >, and, appearances, butfirst, butlast, cos, count, equal?, every, even?, expt, first, if, item, keep, last, max, member?, not, number?, number-of-arguments, odd?, or, quotient, random, remainder, round, sentence, sqrt, vowel?, and word.

;2.5   List the one-argument functions in this chapter for which the type of the return value is always different from the type of the argument.

; Answer: vowel?

;2.6   List the one-argument functions in this chapter for which the type of the return value is sometimes different from the type of the argument.

;2.7   Mathematicians sometimes use the term "operator" to mean a function of two arguments, both of the same type, that returns a result of the same type. Which of the functions you've seen in this chapter satisfy that definition?

; Answer: +, -, /, <=, <, =, >=, >, and, or, not

;2.8  An operator f is commutative if f(a,b)=f(b,a) for all possible arguments A and B. For example, + is commutative, but word isn't. Which of the operators from Exercise 2.7 are commutative?

;2.9  An operator f is associative if f(f(a,b),c)=f(a,f(f(b,c)) for all possible arguments A, B, and C. For example, * is associative, but not /. Which of the operators from Exercise 2.7 are associative?

