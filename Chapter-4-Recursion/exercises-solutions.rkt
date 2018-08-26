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
