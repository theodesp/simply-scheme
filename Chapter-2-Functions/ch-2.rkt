#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (add-s name)
  (word name 's))

(add-s "run")

(define (third-person verb)
  (sentence 'she (add-s verb)))

(third-person "sing")