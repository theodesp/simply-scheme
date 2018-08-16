#lang racket
(require (planet dyoo/simply-scheme:2:2))

; Expressions
6

(+ 3 7) ; 10

(+ 1 2 3 4 5) ; 15

(woed 'comp 'uter)

(first (string->list "Hello world")) ; H

(map (lambda (item)
       (first (string->list item)))
     '("hello" "world")
     ) ; (h w)

(list->string (map (lambda (item)
                     (first (string->list item)))
                   '("hello" "world")
                   )
              ) ; "hw"


; Errors
; (+ 2 a)
; Exit

; (exit)


