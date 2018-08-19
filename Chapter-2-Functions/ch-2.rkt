#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (add-s name)
  (word name 's))

(add-s "run")

(define (third-person verb)
  (sentence 'she (add-s verb)))

(third-person "sing")

(define (square x)
  (* x x))

(square 7)

(define (f a b)
  (+ (* 3 a) b))

(f 5 8)

(define (average a b)
  (/ (+ a b) 2))

(average (average 2 3) (average 4 5))

;;; Words and Sentences

(quote square)

(first 'something)
(last 'something)
(butfirst 'something)
(butlast '(eight days a week))

(define (second thing)
  (first (butfirst thing)))

(second '(like dreamers do))

(item 4 'benefit)

; Constructors
(word 'ses 'qui 'pe 'da 'lian 'ism)
(sentence 'carry 'that 'weight)

; True/False
(define (greet name)
  (if (equal? (first name) 'professor)
      (se '(i hope i am not bothering you) 'professor (last name))
      (se '(good to see you) (first name))))

(greet '(matt wright))
(member? 'mick '(dave dee dozy beaky mick and tich))
(before? 'zorn 'coleman)
(empty? '())
(number? 'three)
(boolean? #f)
(word? 'flying)
(sentence? 'wait)

(define (vowel? letter)
  (member? letter 'aeiou))

(define (positive? number)
  (> number 0))

(define (abs num)
  (if (< num 0)
      (- num)
      num))

(define (divisible? big little)
  (= (remainder big little) 0))

(define (plural wd)
  (word wd 's))

(plural 'fly)

(define (plural2 wd)
  (if (equal? (last wd) 'y)
      (word (bl wd) 'ies)
      (word wd 's)))

(define (num-divisible-by-4? x)
  (and (number? x) (divisible? x 4)))

(num-divisible-by-4? 16)

(define (integer-quotient big little)
  (if (divisible? big little)
      (/ big little)
      #f))

(integer-quotient 27 3)

(define (roman-value letter)
  (cond ((equal? letter 'i) 1)
        ((equal? letter 'v) 5)
        ((equal? letter 'x) 10)
        ((equal? letter 'l) 50)
        ((equal? letter 'c) 100)
        ((equal? letter 'd) 500)
        ((equal? letter 'm) 1000)
        (else 'huh?)))

(define (truefalse value)
  (cond (value 'true)
	(else 'false)))

(truefalse (= 2 (+ 1 1)))

(define (roots a b c)
  (se (/ (+ (- b) (sqrt (- (* b b) (* 4 a c))))
         (* 2 a))
      (/ (- (- b) (sqrt (- (* b b) (* 4 a c))))
         (* 2 a))))

(define (rootss a b c)
  (roots1 a b c (sqrt (- (* b b) (* 4 a c)))))

(define (roots1 a b c discriminant)
  (se (/ (+ (- b) discriminant) (* 2 a))
      (/ (- (- b) discriminant) (* 2 a))))

(define (rootsz a b c)
  (let ((discriminant (sqrt (- (* b b) (* 4 a c)))))
    (se (/ (+ (- b) discriminant) (* 2 a))
        (/ (- (- b) discriminant) (* 2 a)))))

(define (rootsa a b c)
  (let ((discriminant (sqrt (- (* b b) (* 4 a c))))
        (minus-b (- b))
        (two-a (* 2 a)))
    (se (/ (+ minus-b discriminant) two-a)
        (/ (- minus-b discriminant) two-a))))

