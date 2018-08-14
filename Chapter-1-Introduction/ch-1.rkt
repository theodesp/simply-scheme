#lang racket
(require (planet dyoo/simply-scheme:2:2))

; Expressions
6

(+ 3 7) ; 10

(+ 1 2 3 4 5) ; 15

(word 'comp 'uter)

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

(define (acronym phrase)
  (accumulate word (every first (keep real-word? phrase))))

(define (real-word? wd)
  (not (member? wd '(a the an in of and for to with))))

(acronym '(united states of america))

; Pig latin
(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay) ; Add ay if not starts with aeiou
      (pigl (word (butfirst wd) (first wd))))) ; Else move at back and repeat

(define (rotate wd)
    (word (butfirst wd) (first wd)))

(define (choices menu)
  (if (null? menu)
      '(())
      (let ((smaller (choices (cdr menu))))
	(reduce append
		(map (lambda (item) (prepend-every item smaller))
		     (car menu))))))

(define (prepend-every item lst)
  (map (lambda (choice) (se item choice)) lst))

(define (combinations size set)
  (cond ((= size 0) '(()))
	((empty? set) '())
	(else (append (prepend-every (first set)
				     (combinations (- size 1)
						   (butfirst set)))
		      (combinations size (butfirst set))))))

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

; Errors
; (+ 2 a)
; Exit

; (exit)


