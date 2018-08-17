#lang racket
(require (planet dyoo/simply-scheme:2:2))

;Boring Exercises
;3.1  Translate the arithmetic expressions (3+4)×5 and 3+(4×5) into Scheme expressions, and into plumbing diagrams.
;
;3.2  How many little people does Alonzo hire in evaluating each of the following expressions:
;
;(+ 3 (* 4 5) (- 10 4))
; 
;(+ (* (- (/ 8 2) 1) 5) 2)
; 
;(* (+ (- 3 (/ 4 2))
;      (sin (* 3 2))
;      (- 8 (sqrt 5)))
;   (- (/ 2 3)
;      4))
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
;3.8  Which of the functions that you explored in Chapter 2 will accept variable numbers of arguments?
;
;Real Exercises
;3.9  The expression (+ 8 2) has the value 10. It is a compound expression made up of three atoms. For this problem, write five other Scheme expressions whose values are also the number ten:
;
;•	    	An atom
;•	    	Another compound expression made up of three atoms
;•	    	A compound expression made up of four atoms
;•	    	A compound expression made up of an atom and two compound subexpressions
;•	    	Any other kind of expression


;4.1  Consider this procedure:
;
;(define (ho-hum x y)
;  (+ x (* 2 y)))
;Show the substitution that occurs when you evaluate
;
;(ho-hum 8 12)
;4.2  Given the following procedure:
;
;(define (yawn x)
;  (+ 3 (* x 2)))
;list all the little people that are involved in evaluating
;
;(yawn (/ 8 2))
;(Give their names, their specialties, their arguments, who hires them, and what they do with their answers.)
;
;4.3  Here are some procedure definitions. For each one, describe the function in English, show a sample invocation, and show the result of that invocation.
;
;(define (f x y) (- y x))
;
;(define (identity x) x)
;
;(define (three x) 3)
;
;(define (seven) 7)
;
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
;(define (next x)
;  (x + 1))
;
;(define (square)
;  (* x x))
;
;(define (triangle-area triangle)
;  (* 0.5 base height))
;
;(define (sum-of-squares (square x) (square y))
;  (+ (square x) (square y)))
;4.5  Write a procedure to convert a temperature from Fahrenheit to Celsius, and another to convert in the other direction. The two formulas are F=9⁄5C+32 and C=5⁄9(F-32).
;
;4.6  Define a procedure fourth that computes the fourth power of its argument. Do this two ways, first using the multiplication function, and then using square and not (directly) using multiplication.
;
;4.7  Write a procedure that computes the absolute value of its argument by finding the square root of the square of the argument.
;
;4.8  "Scientific notation" is a way to represent very small or very large numbers by combining a medium-sized number with a power of 10. For example, 5×107 represents the number 50000000, while 3.26×10-9 represents 0.00000000326 in scientific notation. Write a procedure scientific that takes two arguments, a number and an exponent of 10, and returns the corresponding value:
;
;> (scientific 7 3)
;7000
;
;> (scientific 42 -5)
;0.00042
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


;5.1  What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)
;
;(sentence 'I '(me mine))
;
;(sentence '() '(is empty))
;
;(word '23 '45)
;
;(se '23 '45)
;
;(bf 'a)
;
;(bf '(aye))
;
;(count (first '(maggie mae)))
;
;(se "" '() "" '())
;
;(count (se "" '() "" '()))
;5.2  For each of the following examples, write a procedure of two arguments that, when applied to the sample arguments, returns the sample result. Your procedures may not include any quoted data.
;
;> (f1 '(a b c) '(d e f))
;(B C D E)
;
;> (f2 '(a b c) '(d e f))
;(B C D E AF)
;
;> (f3 '(a b c) '(d e f))
;(A B C A B C)
;
;> (f4 '(a b c) '(d e f))
;BE
;5.3  Explain the difference in meaning between (first 'mezzanine) and (first '(mezzanine)).
;
;5.4  Explain the difference between the two expressions (first (square 7)) and (first '(square 7)).
;
;5.5  Explain the difference between (word 'a 'b 'c) and (se 'a 'b 'c).
;
;5.6  Explain the difference between (bf 'zabadak) and (butfirst 'zabadak).
;
;5.7  Explain the difference between (bf 'x) and (butfirst '(x)).
;
;5.8  Which of the following are legal Scheme sentences?
;
;(here, there and everywhere)
;(help!)
;(all i've got to do)
;(you know my name (look up the number))
;5.9  Figure out what values each of the following will return before you try them on the computer:
;
;(se (word (bl (bl (first '(make a))))
;          (bf (bf (last '(baseball mitt)))))
;    (word (first 'with) (bl (bl (bl (bl 'rigidly))))
;          (first 'held) (first (bf 'stitches))))
;
;(se (word (bl (bl 'bring)) 'a (last 'clean))
;    (word (bl (last '(baseball hat))) (last 'for) (bl (bl 'very))
;	  (last (first '(sunny days)))))
;5.10  What kinds of argument can you give butfirst so that it returns a word? A sentence?
;
;5.11  What kinds of argument can you give last so that it returns a word? A sentence?
;
;5.12  Which of the functions first, last, butfirst, and butlast can return an empty word? For what arguments? What about returning an empty sentence?
;
;Real Exercises
;5.13  What does ' 'banana stand for?
;
;What is (first ' 'banana) and why?
;
;5.14  Write a procedure third that selects the third letter of a word (or the third word of a sentence).
;
;5.15   Write a procedure first-two that takes a word as its argument, returning a two-letter word containing the first two letters of the argument.
;
;> (first-two 'ambulatory)
;AM
;5.16  Write a procedure two-first that takes two words as arguments, returning a two-letter word containing the first letters of the two arguments.
;
;> (two-first 'brian 'epstein)
;BE
;Now write a procedure two-first-sent that takes a two-word sentence as argument, returning a two-letter word containing the first letters of the two words.
;
;> (two-first-sent '(brian epstein))
;BE
;5.17  Write a procedure knight that takes a person's name as its argument and returns the name with "Sir" in front of it.
;
;> (knight '(david wessel))
;(SIR DAVID WESSEL)
;5.18  Try the following and explain the result:
;
;(define (ends word)
;  (word (first word) (last word)))
;
;> (ends 'john)
;5.19  Write a procedure insert-and that takes a sentence of items and returns a new sentence with an "and" in the right place:
;
;> (insert-and '(john bill wayne fred joey))
;(JOHN BILL WAYNE FRED AND JOEY)
;5.20  Define a procedure to find somebody's middle names:
;
;> (middle-names '(james paul mccartney))
;(PAUL)
;
;> (middle-names '(john ronald raoul tolkien))
;(RONALD RAOUL)
;
;> (middle-names '(bugs bunny))
;()
;
;> (middle-names '(peter blair denis bernard noone))
;(BLAIR DENIS BERNARD)
;5.21  Write a procedure query that turns a statement into a question by swapping the first two words and adding a question mark to the last word:
;
;> (query '(you are experienced))
;(ARE YOU EXPERIENCED?)
;
;> (query '(i should have known better))
;(SHOULD I HAVE KNOWN BETTER?)

;6.1  What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)
;
;(cond ((= 3 4) '(this boy))
;      ((< 2 5) '(nowhere man))
;      (else '(two of us)))
;
;(cond (empty? 3)
;      (square 7)
;      (else 9))
;
;(define (third-person-singular verb)
;  (cond ((equal? verb 'be) 'is)
;        ((equal? (last verb) 'o) (word verb 'es))
;        (else (word verb 's))))
;
;(third-person-singular 'go)
;6.2  What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)
;
;(or #f #f #f #t)
;
;(and #f #f #f #t)
;
;(or (= 2 3) (= 4 3))
;
;(not #f)
;
;(or (not (= 2 3)) (= 4 3))
;
;(or (and (= 2 3) (= 3 3)) (and (< 2 3) (< 3 4)))
;6.3  Rewrite the following procedure using a cond instead of the ifs:
;
;(define (sign number)
;  (if (< number 0)
;      'negative
;      (if (= number 0)
;	  'zero
;	  'positive)))
;6.4  Rewrite the following procedure using an if instead of the cond:
;
;(define (utensil meal)
;  (cond ((equal? meal 'chinese) 'chopsticks)
;	(else 'fork)))
;Real Exercises
;Note: Writing helper procedures may be useful in solving some of these problems.
;
;6.5  Write a procedure european-time to convert a time from American AM/PM notation into European 24-hour notation. Also write american-time, which does the opposite:
;
;> (european-time '(8 am))
;8
;
;> (european-time '(4 pm))
;16
;
;> (american-time 21)
;(9 PM)
;
;> (american-time 12)
;(12 PM)
;
;> (european-time '(12 am))
;24
;Getting noon and midnight right is tricky.
;
;6.6  Write a predicate teen? that returns true if its argument is between 13 and 19.
;
;6.7  Write a procedure type-of that takes anything as its argument and returns one of the words word, sentence, number, or boolean:
;
;> (type-of '(getting better))
;SENTENCE
;
;> (type-of 'revolution)
;WORD
;
;> (type-of (= 3 3))
;BOOLEAN
;(Even though numbers are words, your procedure should return number if its argument is a number.)
;
;Feel free to check for more specific types, such as "positive integer," if you are so inclined.
;
;6.8  Write a procedure indef-article that works like this:
;
;> (indef-article 'beatle)
;(A BEATLE)
;
;> (indef-article 'album)
;(AN ALBUM)
;Don't worry about silent initial consonants like the h in hour.
;
;6.9  Sometimes you must choose the singular or the plural of a word: 1 book but 2 books. Write a procedure thismany that takes two arguments, a number and a singular noun, and combines them appropriately:
;
;> (thismany 1 'partridge)
;(1 PARTRIDGE)
;
;> (thismany 3 'french-hen)
;(3 FRENCH-HENS)
;6.10  Write a procedure sort2 that takes as its argument a sentence containing two numbers. It should return a sentence containing the same two numbers, but in ascending order:
;
;> (sort2 '(5 7))
;(5 7)
;
;> (sort2 '(7 5))
;(5 7)
;6.11  Write a predicate valid-date? that takes three numbers as arguments, representing a month, a day of the month, and a year. Your procedure should return #t if the numbers represent a valid date (e.g., it isn't the 31st of September). February has 29 days if the year is divisible by 4, except that if the year is divisible by 100 it must also be divisible by 400.
;
;> (valid-date? 10 4 1949)
;#T
;
;> (valid-date? 20 4 1776)
;#F
;
;> (valid-date? 5 0 1992)
;#F
;
;> (valid-date? 2 29 1900)
;#F
;
;> (valid-date? 2 29 2000)
;#T
;6.12  Make plural handle correctly words that end in y but have a vowel before the y, such as boy. Then teach it about words that end in x (box). What other special cases can you find?
;
;
;6.13  Write a better greet procedure that understands as many different kinds of names as you can think of:
;
;> (greet '(john lennon))
;(HELLO JOHN)
;
;> (greet '(dr marie curie))
;(HELLO DR CURIE)
;
;> (greet '(dr martin luther king jr))
;(HELLO DR KING)
;
;> (greet '(queen elizabeth))
;(HELLO YOUR MAJESTY)
;
;> (greet '(david livingstone))
;(DR LIVINGSTONE I PRESUME?)
;6.14  Write a procedure describe-time that takes a number of seconds as its argument and returns a more useful description of that amount of time:
;
;> (describe-time 45)
;(45 SECONDS)
;
;> (describe-time 930)
;(15.5 MINUTES)
;
;> (describe-time 30000000000)
;(9.506426344208686 CENTURIES)
