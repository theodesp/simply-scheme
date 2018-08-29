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

(define (reverse wd)
  (if (= (count wd) 1)
      wd
      (word (last wd)
	    (reverse (bl wd)))))

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(define (evens sent)                         ;; best version
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent))
	  (evens (bf (bf sent))))))

(define (double wd) (word wd wd))
(trace double)

(double (double (double 'yum)))
(untrace double)

(define (every–nth n sent)
 (every–nth–helper n n sent))
(define (every–nth–helper interval remaining sent)
 (cond ((empty? sent) '())
 ((= remaining 1)
 (se (first sent)
 (every–nth–helper interval interval (bf sent))))
 (else (every–nth–helper interval (– remaining 1) (bf sent)))))

(define (remove–once wd sent)
 (cond ((empty? sent) '())
 ((equal? wd (first sent)) (bf sent))
 (else (se (first sent) (remove–once wd (bf sent))))))

(define (earliest–word sent)
 (earliest–helper (first sent) (bf sent)))
(define (earliest–helper so–far rest)
 (cond ((empty? rest) so–far)
 ((before? so–far (first rest))
 (earliest–helper so–far (bf rest)))
 (else (earliest–helper (first rest) (bf rest)))))*

(define (from–binary bits)
 (if (empty? bits)
 0
 (+ (* (from–binary (b1 bits)) 2)
 (last bits))))

(define (mergesort sent)
 (if (<= (count sent) 1)
 sent
 (merge (mergesort (one–half sent))
 (mergesort (other–half sent)))))

(define (merge left right)
 (cond ((empty? left) right)
 ((empty? right) left)
 ((before? (first left) (first right))
 (se (first left) (merge (bf left) right)))
 (else (se (first right) (merge left (bf right))))))

(define (one–half sent)
 (if (<= (count sent) 1)
 sent
 (se (first sent) (one–half (bf (bf sent))))))

(define (other–half sent)
 (if (<= (count sent) 1)
 '()
 (se (first (bf sent)) (other–half (bf (bf sent))))))


(define (prepend–every letter sent)
 (if (empty? sent)
 '()
 (se (word letter (first sent))
 (prepend–every letter (bf sent)))))

(define (subsets wd)
 (if (empty? wd)
 (se " ")
 (let ((smaller (subsets (bf wd))))
 (se smaller
 (prepend–every (first wd) smaller)))))
