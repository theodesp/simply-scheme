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