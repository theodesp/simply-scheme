#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))


(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (explode wd)
  (if (empty? wd)
      '()
      (se (first wd) (explode (bf wd)))))

(define (first-two wd)
  (word (first wd) (first (bf wd))))

(define (letter-pairs wd)
  (if (<= (count wd) 1)
      '()
      (se (first-two wd)
	  (letter-pairs (bf wd)))))
