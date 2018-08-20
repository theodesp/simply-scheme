#lang racket
(require (planet dyoo/simply-scheme:2:2))

;8.1  What does Scheme return as the value of each of the following expressions? Figure it out for yourself before you try it on the computer.
;
;> (every last '(algebra purple spaghetti tomato gnu))
;
; Answer: the last char of each word as a sentence

;> (keep number? '(one two three four))

; Answer: an empty sentence
;
;> (accumulate * '(6 7 13 0 9 42 17))
;
; Answer: 0

;> (member? 'h (keep vowel? '(t h r o a t)))
;
; False

;> (every square (keep even? '(87 4 7 12 0 5)))
;

; Answer: Square of even numbers '(16 144 0) 

;> (accumulate word (keep vowel? (every first '(and i love her))))
;
;> ((repeated square 0) 25)

; Answer: 1
;
;> (every (repeated bl 2) '(good day sunshine))

; Answer: '(go d sunshi)

;8.2  Fill in the blanks in the following Scheme interactions:
;
;> (______ vowel? 'birthday)
;IA

; Answer: keep
;

;> (______ first '(golden slumbers))
;(G S)

; Answer: every
;
;> (______ '(golden slumbers))
;GOLDEN
;
; Answer: first

;> (______ ______ '(little child))
;(E D)

; Answer: every last
;
;> (______ ______ (______ ______ '(little child)))
;ED
;
; Answer: accumulate word every last

;> (______ + '(2 3 4 5))
;(2 3 4 5)
;
; Answer: every

;> (______ + '(2 3 4 5))

; Answer: accumulate
;14
;8.3  Describe each of the following functions in English. Make sure to include a description of the domain and range of each function. Be as precise as possible; for example, "the argument must be a function of one numeric argument" is better than "the argument must be a function."
;
;(define (f a)
;  (keep even? a))
;
; Answer: Filters out even numbers from a input parameter. Input myst be a sequence

;(define (g b)
;  (every b '(blue jay way)))
;
; Answer: Applies b to a specified sequence. Input must be a function of 1 argument

;(define (h c d)
;  (c (c d)))
;
; Answer: Applies c to (c d). Input must be a function of 1 argument that accepts a function

;(define (i e)
;  (/ (accumulate + e) (count e)))
;
; Answer: Applies accumulate +  to e. Input must be a sequence.

;Real Exercises
;Note: Writing helper procedures may be useful in solving some of these problems. If you read Part IV before this, do not use recursion in solving these problems; use higher order functions instead.
;
;8.4  Write a procedure choose-beatles that takes a predicate function as its argument and returns a sentence of just those Beatles (John, Paul, George, and Ringo) that satisfy the predicate. For example:
;
;(define (ends-vowel? wd) (vowel? (last wd)))
;
;(define (even-count? wd) (even? (count wd)))
;
;> (choose-beatles ends-vowel?)
;(GEORGE RINGO)
;
;> (choose-beatles even-count?)
;(JOHN PAUL GEORGE)

(define (choose-beatles f)
  (keep f '(John Paul George Ringo))
  )

(choose-beatles ends-vowel?)

;8.5  Write a procedure transform-beatles that takes a procedure as an argument, applies it to each of the Beatles, and returns the results in a sentence:
;
;(define (amazify name)
;  (word 'the-amazing- name))
;> (transform-beatles amazify)
;(THE-AMAZING-JOHN THE-AMAZING-PAUL THE-AMAZING-GEORGE
; THE-AMAZING-RINGO)
;
;> (transform-beatles butfirst)
;(OHN AUL EORGE INGO)

(define (transform-beatles f)
  (every f '(John Paul George Ringo))
  )

(transform-beatles amazify)

;8.6  When you're talking to someone over a noisy radio connection, you sometimes have to spell out a word in order to get the other person to understand it. But names of letters aren't that easy to understand either, so there's a standard code in which each letter is represented by a particular word that starts with the letter. For example, instead of "B" you say "bravo."
;
;Write a procedure words that takes a word as its argument and returns a sentence of the names of the letters in the word:
;
;> (words 'cab)
;(CHARLIE ALPHA BRAVO)
;(You may make up your own names for the letters or look up the standard ones if you want.)
;
;Hint: Start by writing a helper procedure that figures out the name for a single letter.
;

(define (words input)
 (every ch->word input)
  )

(define (ch->word ch)
  (define voc '(alpha bravo ceres delta epsilon floga graylog halo))
  (item (+ (index-of (every first voc) ch) 1) voc)
  )

(words 'haeb)

;8.7  [14.5][9] Write a procedure letter-count that takes a sentence as its argument and returns the total number of letters in the sentence:
;
;> (letter-count '(fixing a hole))
;11

(define (letter-count input)
  (accumulate + (every count input))
  )

(letter-count '(fixing a hole))

;8.8  [12.5] Write an exaggerate procedure which exaggerates sentences:
;
;> (exaggerate '(i ate 3 potstickers))
;(I ATE 6 POTSTICKERS)
;
;> (exaggerate '(the chow fun is good here))
;(THE CHOW FUN IS GREAT HERE)
;It should double all the numbers in the sentence, and it should replace "good" with "great," "bad" with "terrible," and anything else you can think of.
;
;8.9  What procedure can you use as the first argument to every so that for any sentence used as the second argument, every returns that sentence?
;
; Answer: identity function

;What procedure can you use as the first argument to keep so that for any sentence used as the second argument, keep returns that sentence?
;
; Answer: identity function

;What procedure can you use as the first argument to accumulate so that for any sentence used as the second argument, accumulate returns that sentence?

; Answer: identity function
;
;8.10  Write a predicate true-for-all? that takes two arguments, a predicate procedure and a sentence. It should return #t if the predicate argument returns true for every word in the sentence.
;
;> (true-for-all? even? '(2 4 6 8))
;#T
;
;> (true-for-all? even? '(2 6 3 4))
;#F

(define (true-for-all? pred input)
  (equal? (keep pred input) input)
  )

(true-for-all? even? '(2 4 6 8))
(true-for-all? even? '(2 6 3 4))

;8.11  [12.6] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding grade point average:
;
;> (gpa '(A A+ B+ B))
;3.67
;Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns −.33, 0, or .33, nt: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns -.33, 0, or .33, depending on whether the grade has a minus, a plus, or neither.
;
;> (count-ums
;   '(today um we are going to um talk about functional um programming))
;3
;8.13  [11.3] Write a procedure phone-unspell that takes a spelled version of a phone number, such as POPCORN, and returns the real phone number, in this case 7672676. You will need to write a helper procedure that uses an 8-way cond expression to translate a single letter into a digit.
;
;8.14  Write the procedure subword that takes three arguments: a word, a starting position number, and an ending position number. It should return the subword containing only the letters between the specified positions:
;
;> (subword 'polythene 5 8)
;THEN

(define( subword wd start end)
  (substring (word->string wd) (- start 1) end)
  )
  

(subword 'polythene 5 8)

;9.1  What will Scheme print? Figure it out yourself before you try it on the computer.
;
;> (lambda (x) (+ (* x 3) 4))
;
;> ((lambda (x) (+ (* x 3) 4)) 10)
;
;> (every (lambda (wd) (word (last wd) (bl wd)))
;         '(any time at all))
;
;> ((lambda (x) (+ x 3)) 10 15)
;9.2  Rewrite the following definitions so as to make the implicit lambda explicit.
;
;(define (second stuff)
;  (first (bf stuff)))
;
;(define (make-adder num)
;  (lambda (x) (+ num x)))
;9.3  What does this procedure do?
;
;(define (let-it-be sent)
;  (accumulate (lambda (x y) y) sent))
;Real Exercises
;9.4  The following program doesn't work. Why not? Fix it.
;
;(define (who sent)
;  (every describe '(pete roger john keith)))
;
;(define (describe person)
;  (se person sent))
;It's supposed to work like this:
;
;> (who '(sells out))
;(pete sells out roger sells out john sells out keith sells out)
;In each of the following exercises, write the procedure in terms of lambda and higher-order functions. Do not use named helper procedures. If you've read Part IV, don't use recursion, either.
;
;9.5  Write prepend-every:
;
;> (prepend-every 's '(he aid he aid))
;(SHE SAID SHE SAID)
;
;> (prepend-every 'anti '(dote pasto gone body))
;(ANTIDOTE ANTIPASTO ANTIGONE ANTIBODY)
;9.6  Write a procedure sentence-version that takes a function f as its argument and returns a function g. f should take a single word as argument. g should take a sentence as argument and return the sentence formed by applying f to each word of that argument.
;
;> ((sentence-version first) '(if i fell))
;(I I F)
;
;> ((sentence-version square) '(8 2 4 6))
;(64 4 16 36)
;9.7  Write a procedure called letterwords that takes as its arguments a letter and a sentence. It returns a sentence containing only those words from the argument sentence that contain the argument letter:
;
;> (letterwords 'o '(got to get you into my life))
;(GOT TO YOU INTO)
;9.8  Suppose we're writing a program to play hangman. In this game one player has to guess a secret word chosen by the other player, one letter at a time. You're going to write just one small part of this program: a procedure that takes as arguments the secret word and the letters guessed so far, returning the word in which the guessing progress is displayed by including all the guessed letters along with underscores for the not-yet-guessed ones:
;
;> (hang 'potsticker 'etaoi)
;_OT_TI__E_
;Hint: You'll find it helpful to use the following procedure that determines how to display a single letter:
;
;(define (hang-letter letter guesses)
;  (if (member? letter guesses)
;      letter
;      '_))
;9.9  Write a procedure common-words that takes two sentences as arguments and returns a sentence containing only those words that appear both in the first sentence and in the second sentence.
;
;9.10  In Chapter 2 we used a function called appearances that returns the number of times its first argument appears as a member of its second argument. Implement appearances.
;
;9.11  Write a procedure unabbrev that takes two sentences as arguments. It should return a sentence that's the same as the first sentence, except that any numbers in the original sentence should be replaced with words from the second sentence. A number 2 in the first sentence should be replaced with the second word of the second sentence, a 6 with the sixth word, and so on.
;
;> (unabbrev '(john 1 wayne fred 4) '(bill hank kermit joey))
;(JOHN BILL WAYNE FRED JOEY)
;
;> (unabbrev '(i 3 4 tell 2) '(do you want to know a secret?))
;(I WANT TO TELL YOU)
;9.12  Write a procedure first-last whose argument will be a sentence. It should return a sentence containing only those words in the argument sentence whose first and last letters are the same:
;
;> (first-last '(california ohio nebraska alabama alaska massachusetts))
;(OHIO ALABAMA ALASKA)
;9.13  Write a procedure compose that takes two functions f and g as arguments. It should return a new function, the composition of its input functions, which computes f(g(x)) when passed the argument x.
;
;> ((compose sqrt abs) -25)
;5
;
;> (define second (compose first bf))
;
;> (second '(higher order function))
;ORDER
;9.14  Write a procedure substitute that takes three arguments, two words and a sentence. It should return a version of the sentence, but with every instance of the second word replaced with the first word:
;
;> (substitute 'maybe 'yeah '(she loves you yeah yeah yeah))
;(SHE LOVES YOU MAYBE MAYBE MAYBE)
;9.15  Many functions are applicable only to arguments in a certain domain and result in error messages if given arguments outside that domain. For example, sqrt may require a nonnegative argument in a version of Scheme that doesn't include complex numbers. (In any version of Scheme, sqrt will complain if its argument isn't a number at all!) Once a program gets an error message, it's impossible for that program to continue the computation.
;
;Write a procedure type-check that takes as arguments a one-argument procedure f and a one-argument predicate procedure pred. Type-check should return a one-argument procedure that first applies pred to its argument; if that result is true, the procedure should return the value computed by applying f to the argument; if pred returns false, the new procedure should also return #f:
;
;> (define safe-sqrt (type-check sqrt number?))
;
;> (safe-sqrt 16)
;4
;
;> (safe-sqrt 'sarsaparilla)
;#F
;9.16  In the language APL, most arithmetic functions can be applied either to a number, with the usual result, or to a vector—the APL name for a sentence of numbers—in which case the result is a new vector in which each element is the result of applying the function to the corresponding element of the argument. For example, the function sqrt applied to 16 returns 4 as in Scheme, but sqrt can also be applied to a sentence such as (16 49) and it returns (4 7).
;
;Write a procedure aplize that takes as its argument a one-argument procedure whose domain is numbers or words. It should return an APLized procedure that also accepts sentences:
;
;> (define apl-sqrt (aplize sqrt))
;
;> (apl-sqrt 36)
;6
;
;> (apl-sqrt '(1 100 25 16))
;(1 10 5 4)
;9.17  Write keep in terms of every and accumulate.