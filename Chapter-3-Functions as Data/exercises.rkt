#lang racket
(require (planet dyoo/simply-scheme:2:2))

;8.1  What does Scheme return as the value of each of the following expressions? Figure it out for yourself before you try it on the computer.
;
;> (every last '(algebra purple spaghetti tomato gnu))
;
;> (keep number? '(one two three four))
;
;> (accumulate * '(6 7 13 0 9 42 17))
;
;> (member? 'h (keep vowel? '(t h r o a t)))
;
;> (every square (keep even? '(87 4 7 12 0 5)))
;
;> (accumulate word (keep vowel? (every first '(and i love her))))
;
;> ((repeated square 0) 25)
;
;> (every (repeated bl 2) '(good day sunshine))
;8.2  Fill in the blanks in the following Scheme interactions:
;
;> (______ vowel? 'birthday)
;IA
;
;> (______ first '(golden slumbers))
;(G S)
;
;> (______ '(golden slumbers))
;GOLDEN
;
;> (______ ______ '(little child))
;(E D)
;
;> (______ ______ (______ ______ '(little child)))
;ED
;
;> (______ + '(2 3 4 5))
;(2 3 4 5)
;
;> (______ + '(2 3 4 5))
;14
;8.3  Describe each of the following functions in English. Make sure to include a description of the domain and range of each function. Be as precise as possible; for example, "the argument must be a function of one numeric argument" is better than "the argument must be a function."
;
;(define (f a)
;  (keep even? a))
;
;(define (g b)
;  (every b '(blue jay way)))
;
;(define (h c d)
;  (c (c d)))
;
;(define (i e)
;  (/ (accumulate + e) (count e)))
;
;accumulate
;
;sqrt
;
;repeated
;
;(repeated sqrt 3)
;
;(repeated even? 2)
;
;(repeated first 2)
;
;(repeated (repeated bf 3) 2)
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
;8.7  [14.5][9] Write a procedure letter-count that takes a sentence as its argument and returns the total number of letters in the sentence:
;
;> (letter-count '(fixing a hole))
;11
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
;What procedure can you use as the first argument to keep so that for any sentence used as the second argument, keep returns that sentence?
;
;What procedure can you use as the first argument to accumulate so that for any sentence used as the second argument, accumulate returns that sentence?
;
;8.10  Write a predicate true-for-all? that takes two arguments, a predicate procedure and a sentence. It should return #t if the predicate argument returns true for every word in the sentence.
;
;> (true-for-all? even? '(2 4 6 8))
;#T
;
;> (true-for-all? even? '(2 6 3 4))
;#F
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