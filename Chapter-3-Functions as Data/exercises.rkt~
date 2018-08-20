#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (make-conjugator prefix ending)
  (lambda (verb) (sentence prefix (word verb ending))))

(define third-person (make-conjugator 'she 's))

(define third-person-plural-past (make-conjugator 'they 'ed))

(define second-person-future-perfect
    (make-conjugator '(you will have) 'ed))

(third-person 'program)
(third-person-plural-past 'play)
(second-person-future-perfect 'laugh)

;Higher-Order Functions
(define (first-letters sent)
  (every first sent))

(first-letters '(here comes the sun))
(every last '(while my guitar gently weeps))

(define (plural noun)
  (if (equal? (last noun) 'y)
      (word (bl noun) 'ies)
      (word noun 's)))

(every plural '(beatle turtle holly kink zombie))

(define (g wd)
    (se (word 'with wd) 'you))

(every g '(in out))

(keep even? '(1 2 3 4 5))

(accumulate + '(6 3 4 -5 7 8 9))

(define (add-numbers sent)
  (accumulate + (keep number? sent)))

(add-numbers '(4 calling birds 3 french hens 2 turtle doves))


((repeated bf 3) '(she came in through the bathroom window))

(define (any-numbers? sent)
  (not (empty? (keep number? sent))))

(define (spell-digit digit)
  (item (+ 1 digit)
	'(zero one two three four five six seven eight nine)))

(every spell-digit 1971)
