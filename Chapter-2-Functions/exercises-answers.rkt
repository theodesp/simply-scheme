#lang racket
(require (planet dyoo/simply-scheme:2:2))

;Boring Exercises
;3.1  Translate the arithmetic expressions (3+4)×5 and 3+(4×5) into Scheme expressions, and into plumbing diagrams.

(* (+ 3 4) 5)
(+ (* 4 5) 3)

;
;3.2  How many little people does Alonzo hire in evaluating each of the following expressions:
;
;(+ 3 (* 4 5) (- 10 4))

; Answer: 29

;(+ (* (- (/ 8 2) 1) 5) 2)
;
; Answer: 17


;(* (+ (- 3 (/ 4 2))
;      (sin (* 3 2))
;      (- 8 (sqrt 5)))
;   (- (/ 2 3)
;      4))

; Answer: -21.615055081004282


;3.3  Each of the expressions in the previous exercise is compound. How many subexpressions (not including subexpressions of subexpressions) does each one have?
;
;For example,
;
;(* (- 1 (+ 3 4)) 8)
;has three subexpressions; you wouldn't count (+ 3 4).
;
;3.4  Five little people are hired in evaluating the following expression:
;
;(+ (* 3 (- 4 7))
;   (- 8 (- 3 5)))
;Give each little person a name and list her specialty, the argument values she receives, her return value, and the name of the little person to whom she tells her result.
;3.5  Evaluate each of the following expressions using the result replacement technique:
;
;(sqrt (+ 6 (* 5 2)))
;
;(+ (+ (+ 1 2) 3) 4)
;3.6  Draw a plumbing diagram for each of the following expressions:
;
;(+ 3 4 5 6 7)
; 
;(+ (+ 3 4) (+ 5 6 7))
; 
;(+ (+ 3 (+ 4 5) 6) 7)
;3.7  What value is returned by (/ 1 3) in your version of Scheme? (Some Schemes return a decimal fraction like 0.33333, while others have exact fractional values like 1/3 built in.)
;
(/ 1 3)

;3.8  Which of the functions that you explored in Chapter 2 will accept variable numbers of arguments?
;
;Real Exercises
;3.9  The expression (+ 8 2) has the value 10. It is a compound expression made up of three atoms. For this problem, write five other Scheme expressions whose values are also the number ten:
;
;•	    	An atom
10
;•	    	Another compound expression made up of three atoms
(- 12 2)
;•	    	A compound expression made up of four atoms
(- (+ 6 6) 2) 
;•	    	A compound expression made up of an atom and two compound subexpressions
;•	    	Any other kind of expression

;4.1  Consider this procedure:
;
;(define (ho-hum x y)
;  (+ x (* 2 y)))
;Show the substitution that occurs when you evaluate
;
;(ho-hum 8 12)

; Answer
; (+ 8 (* 2 12)) -> (+8 24) -> 32

;4.2  Given the following procedure:
;
;(define (yawn x)
;  (+ 3 (* x 2)))
;list all the little people that are involved in evaluating
;
;(yawn (/ 8 2))

; Answer
; (+ 3 (* (/ 8 2) 2)) -> 3

;(Give their names, their specialties, their arguments, who hires them, and what they do with their answers.)
;
;4.3  Here are some procedure definitions. For each one, describe the function in English, show a sample invocation, and show the result of that invocation.
;
;(define (f x y) (- y x))
;
;; Answer: Substract second from first

;(define (identity x) x)

;; Answer: Return self
;
;(define (three x) 3)

;; Answer: Return constant
;
;(define (seven) 7)
;
; Answer: Return constant

;(define (magic n)
;  (- (/ (+ (+ (* 3 n)
;              13)
;           (- n 1))
;        4)
;     3))

;Real Exercises
;4.4  Each of the following procedure definitions has an error of some kind. Say what's wrong and why, and fix it:
;
;(define (sphere-volume r)
;  (* (/ 4 3) 3.141592654)
;  (* r r r))
;
; Answer: the first expression is ignored

;(define (next x)
;  (x + 1))
;
; Answer: wrong order of operator

;(define (square)
;  (* x x))
;

; Answer: missing parameter
;(define (triangle-area triangle)
;  (* 0.5 base height))
;

; Answer: missing parameter

;(define (sum-of-squares (square x) (square y))
;  (+ (square x) (square y)))

; Answer: compound parameter definition

;4.5  Write a procedure to convert a temperature from Fahrenheit to Celsius, and another to convert in the other direction. The two formulas are F=9⁄5C+32 and C=5⁄9(F-32).
;
;4.6  Define a procedure fourth that computes the fourth power of its argument. Do this two ways, first using the multiplication function, and then using square and not (directly) using multiplication.
(define (forth-power n)
  (* n n n n)
  )

(define (square n)
  (* n n)
  )

(define (forth-power2 n)
  (* (square n) (square n))
  )

(forth-power2 2)
;
;4.7  Write a procedure that computes the absolute value of its argument by finding the square root of the square of the argument.
;

(define (absolute-value n)
  (sqrt (sqrt n))
  )

(absolute-value 10)
;4.8  "Scientific notation" is a way to represent very small or very large numbers by combining a medium-sized number with a power of 10. For example, 5×107 represents the number 50000000, while 3.26×10-9 represents 0.00000000326 in scientific notation. Write a procedure scientific that takes two arguments, a number and an exponent of 10, and returns the corresponding value:
;
;> (scientific 7 3)
;7000
;exp
;> (scientific 42 -5)
;0.00042

(define scientific
  (lambda (number exp)
    (cond
      [(or (= exp 0) (= exp 1)) number]
      [(> exp 1) (scientific (* number 10) (- exp 1))]
      [(< exp 0) (scientific (/ number 10) (+ exp 1))]))
  )
(scientific 7 3)
;Some versions of Scheme represent fractions in a/b form, and some use scientific notation, so you might see 21/50000 or 4.2E-4 as the result of the last example instead of 0.00042, but these are the same value.
;
;(A harder problem for hotshots: Can you write procedures that go in the other direction? So you'd have
;
;> (sci-coefficient 7000)
;7
;
;> (sci-exponent 7000)
;3
;You might find the primitive procedures log and floor helpful.)
;
;4.9  Define a procedure discount that takes two arguments: an item's initial price and a percentage discount. It should return the new price:
;
;> (discount 10 5)
;9.50
;

;> (discount 29.90 50)
;14.95

(define discount
  (lambda (amount factor)
    (- amount (* amount (/ factor 100))))
  )
(discount 29.90 50)
;4.10  Write a procedure to compute the tip you should leave at a restaurant. It should take the total bill as its argument and return the amount of the tip. It should tip by 15%, but it should know to round up so that the total amount of money you leave (tip plus original bill) is a whole number of dollars. (Use the ceiling procedure to round up.)
;
;> (tip 19.98)
;3.02
;
;> (tip 29.23)
;4.77
;
;> (tip 7.54)
;1.46
