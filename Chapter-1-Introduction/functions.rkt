#lang racket
(require (planet dyoo/simply-scheme:2:2))

; Functions
(remainder 12 -5); 2
(round 17.5) ; 18

(butfirst 'a) ; ""
(butlast  'aa) ; "a"
(count 1212) ; 4
(sentence '(when i get) 'home) ; '(when i get home)

(word 3.14 3.15) "3.143.15"
(every first '(the long and winding road)) ; '(t l a w r)
(keep (lambda (c) (not (member? c 'aeiuoy))) 'misanthropist)

