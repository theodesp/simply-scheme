#lang racket
(require (planet dyoo/simply-scheme:2:2))

;11.1  Write downup4 using only the word and sentence primitive procedures.
;

(define (downup4 wd)
  (se wd (downup3 (bl wd)) wd))

(define (downup3 wd)
  (se wd
      (bl wd)
      (first wd)
      (bl wd)
      wd))

(downup4 'rast)

;11.2  [8.12][4] When you teach a class, people will get distracted if you say "um" too many times. Write a count-ums that counts the number of times "um" appears in a sentence:
;
;> (count-ums
;   '(today um we are going to um talk about the combining um method))
;3
;Here are some special-case count-ums procedures for sentences of particular lengths:
;
;(define (count-ums0 sent)
;  0)
;
;(define (count-ums1 sent)
;  (if (equal? 'um (first sent))
;      1
;      0))
;
;(define (count-ums2 sent)
;  (if (equal? 'um (first sent))
;      (+ 1 (count-ums1 (bf sent)))
;      (count-ums1 (bf sent))))
;
;(define (count-ums3 sent)
;  (if (equal? 'um (first sent))
;      (+ 1 (count-ums2 (bf sent)))
;      (count-ums2 (bf sent))))
;Write count-ums recursively.
;

(define (1+ x) (+ x 1))

(define (count-ums phrase)
  (if (empty? phrase)
      0
      (if (equal? (first phrase) "um")
          (1+ (count-ums (bf phrase)))
          (count-ums (bf phrase)))))

(count-ums
'(today um we are going to um talk about the combining um method))

;11.3  [8.13] Write a procedure phone-unspell that takes a spelled version of a phone number, such as POPCORN, and returns the real phone number, in this case 7672676. You will need a helper procedure that translates a single letter into a digit:
;
;(define (unspell-letter letter)
;  (cond ((member? letter 'abc) 2)
;	((member? letter 'def) 3)
;	((member? letter 'ghi) 4)
;	((member? letter 'jkl) 5)
;	((member? letter 'mno) 6)
;	((member? letter 'prs) 7)
;	((member? letter 'tuv) 8)
;	((member? letter 'wxy) 9)
;	(else 0)))
;Here are some some special-case phone-unspell procedures:
;
;(define (phone-unspell1 wd)
;  (unspell-letter wd))
;
;(define (phone-unspell2 wd)
;  (word (unspell-letter (first wd))
;	(unspell-letter (first (bf wd)))))
;
;(define (phone-unspell3 wd)
;  (word (unspell-letter (first wd))
;	(unspell-letter (first (bf wd)))
;	(unspell-letter (first (bf (bf wd))))))
;Write phone-unspell recursively.
;

(define (phone-unspell sent)
  (if (empty? sent)
      ""
      (word (unspell-letter (first sent)) (phone-unspell (bf sent)))))

(phone-unspell 'popcorn)

;Real Exercises
;Use recursion to solve these problems, not higher order functions (Chapter 8)!
;
;11.4  Who first said "use what you have to get what you need"?
;

; Answer: The authors of this book


;11.5  Write a procedure initials that takes a sentence as its argument and returns a sentence of the first letters in each of the sentence's words:
;
;> (initials '(if i needed someone))
;(I I N S)
;11.6  Write a procedure countdown that works like this:
;
;> (countdown 10)
;(10 9 8 7 6 5 4 3 2 1 BLASTOFF!)
;
;> (countdown 3)
;(3 2 1 BLASTOFF!)

(define (countdown end)
  (if (= end 0)
      (se 'BLASTOFF!)
      (se end (countdown (- end 1)))))

(countdown 10)

;11.7  Write a procedure copies that takes a number and a word as arguments and returns a sentence containing that many copies of the given word:
;
;> (copies 8 'spam)
;(SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM)

(define (copies howmany item)
  (if (= howmany 0)
      '()
      (se item (copies (- howmany 1) item))))

(copies 8 'spam)

;12.1  Here is a definition of a procedure that returns the sum of the numbers in its argument sentence:
;
;(define (addup nums)
;  (if (empty? (bf nums))
;      (first nums)
;      (+ (first nums) (addup (bf nums)))))
;Although this works, it could be simplified by changing the base case. Do that.

(define (addup nums)
  (if (empty? nums)
      0
      (+ (first nums) (addup (bf nums)))))

(addup '123)

;
;12.2  Fix the bug in the following definition:
;
;(define (acronym sent)                       ;; wrong
;  (if (= (count sent) 1)
;      (first sent)
;      (word (first (first sent))
;	    (acronym (bf sent)))))

(define (acronym sent)                       ;; wrong
  (if (= (count sent) 1)
      (first (first sent))
      (word (first (first sent))
	    (acronym (bf sent)))))

(acronym '(REDUCE IS KEllly))

;12.3  Can we reduce the factorial base case argument from 0 to -1? If so, show the resulting procedure. If not, why not?
;
; Answer : Nope
;12.4  Here's the definition of a function f:
;
;math display
;Implement f as a Scheme procedure. What does f do?
;
;Real Exercises
;Solve all of the following problems with recursive procedures. If you've read Part III, do not use any higher-order functions such as every, keep, or accumulate.
;
;12.5  [8.8] Write an exaggerate procedure which exaggerates sentences:
;
;> (exaggerate '(i ate 3 potstickers))
;(I ATE 6 POTSTICKERS)
;
;> (exaggerate '(the chow fun is good here))
;(THE CHOW FUN IS GREAT HERE)
;It should double all the numbers in the sentence, and it should replace "good" with "great," "bad" with "terrible," and anything else you can think of.
;

(define (exaggerate-word wd)
  (cond ((number? wd) (* wd 2))
        ((member? wd '(good nice bad terrible)) 'great)
        (else wd)
        ))

(define (exaggerate sent)
  (if (empty? sent)
      '()
      (se (exaggerate-word (first sent)) (exaggerate (bf sent)))
      ))

(exaggerate '(the chow fun is good here))
(exaggerate '(i ate 3 potstickers))

;12.6  [8.11] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding grade point average:
;
;> (gpa '(A A+ B+ B))
;3.67
;Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns -.33, 0, or .33, depending on whether the Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns -.33, 0, or .33, depending on whether the grade has a minus, a plus, or neither.zero one two three four five six seven eight nine)))

;12.8  Write a procedure numbers that takes a sentence as its argument and returns another sentence containing only the numbers in the argument:
;
;> (numbers '(76 trombones and 110 cornets))
;(76 110)

(define (filter-number wd)
  (cond ((number? wd) wd)
        (else '())
        ))

(define (numbers sent)
  (if (empty? sent)
      '()
      (se (filter-number (first sent)) (numbers (bf sent)))
      ))

(numbers '(76 trombones and 110 cornets))

;12.9  Write a procedure real-words that takes a sentence as argument and returns all the "real" words of the sentence, using the same rule as the real-word? procedure from Chapter 1.
;
;12.10  Write a procedure remove that takes a word and a sentence as arguments and returns the same sentence, but with all copies of the given word removed:
;
;> (remove 'the '(the song love of the loved by the beatles))
;(SONG LOVE OF LOVED BY BEATLES)

(define (filter-word a b)
 (if (equal? a b) '()
     a))

(define (remove sent toRemove)
  (if (empty? sent)
      '()
      (se (filter-word (first sent) toRemove) (remove (bf sent) toRemove))
      ))

(remove '(76 trombones and 110 cornets) 'trombones )

;12.11  Write the procedure count, which returns the number of words in a sentence or the number of letters in a word.

;
;12.12  Write a procedure arabic which converts Roman numerals into Arabic numerals:
;
;> (arabic 'MCMLXXI)
;1971
;
;> (arabic 'MLXVI)
;1066
;You will probably find the roman-value procedure from Chapter 6 helpful. Don't forget that a letter can reduce the overall value if the letter that comes after it has a larger value, such as the C in MCM.
;
;12.13  Write a new version of the describe-time procedure from Exercise . Instead of returning a decimal number, it should behave like this:
;
;> (describe-time 22222)
;(6 HOURS 10 MINUTES 22 SECONDS)
;
;> (describe-time 4967189641)
;(1 CENTURIES 57 YEARS 20 WEEKS 6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)
;Can you make the program smart about saying 1 CENTURY instead of 1 CENTURIES?
;

