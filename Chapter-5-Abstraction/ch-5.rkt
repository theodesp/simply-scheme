#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (order flavor)
 (if (member? flavor
 '(vanilla ginger strawberry lychee raspberry mocha))
 '(coming right up!)
 (se '(sorry we have no) flavor)))

(list (+ 2 3) 'squash (= 2 2) (list 4 5) remainder 'zucchini)

(cons 'for '(no one))

(append '(get back) '(the word))


(define (praise flavors)
 (if (null? flavors)
 '()
 (cons (se (car flavors) '(is delicious))
 (praise (cdr flavors)))))

(praise '(ginger (ultra chocolate) lychee (rum raisin)))

(define (translate wd)
 (lookup wd '((window fenetre) (book livre) (computer ordinateur)
 (house maison) (closed ferme) (pate pate) (liver foie)
 (faith foi) (weekend (fin de semaine))
 ((practical joke) attrape) (pal copain))))

(define (lookup wd dictionary)
 (cond ((null? dictionary) '(parlez–vous anglais?))
 ((equal? wd (car (car dictionary)))
 (car (cdr (car dictionary))))
 (else (lookup wd (cdr dictionary)))))

(translate 'recursion)

(map (lambda (x) (se x x)) '(rocky raccoon))
 (filter (lambda (nums) (= (car nums) (cadr nums))) '((2 3) (4 4) (5 6) (7 8) (9 9)))

(assoc 'george
 '((john lennon) (paul mccartney)
 (george harrison) (ringo starr)))

(define dictionary
 '((window fenetre) (book livre) (computer ordinateur)
 (house maison) (closed ferme) (pate pate) (liver foie)
 (faith foi) (weekend (fin de semaine))
 ((practical joke) attrape) (pal copain)))

(define (translate wd)
 (let ((record (assoc wd dictionary)))
 (if record
 (cadr record)
 '(parlez–vous anglais?))))

(define (increasing? number . rest–of–numbers)
 (cond ((null? rest–of–numbers) #t)
 ((> (car rest–of–numbers) number)
 (apply increasing? rest–of–numbers))
 (else #f)))

(define (appearances–in–book wd book)
 (reduce + (map (lambda (chapter) (appearances–in–chapter wd chapter))
 book)))

(define (appearances–in–chapter wd chapter)
 (reduce + (map (lambda (section) (appearances–in–section wd section))
 chapter)))

(define (appearances–in–section wd section)
 (reduce + (map (lambda (paragraph)
 (appearances–in–paragraph wd paragraph))
 section)))

(define (appearances–in–paragraph wd paragraph)
 (reduce + (map (lambda (sent) (appearances–in–sentence wd sent))
 paragraph)))

(define (appearances–in–sentence given–word sent)
 (length (filter (lambda (sent–word) (equal? sent–word given–word))
 sent)))


(define (deep–appearances wd structure)
 (if (word? structure)
 (if (equal? structure wd) 1 0)
 (reduce +
 (map (lambda (sublist) (deep–appearances wd sublist))
 structure))))

(define (deep–appearances wd structure)
 (cond ((equal? wd structure) 1) ; base case: desired word
 ((word? structure) 0) ; base case: other word
 ((null? structure) 0) ; base case: empty list
 (else (+ (deep–appearances wd (car structure))
 (deep–appearances wd (cdr structure))))))

(define (deep–pigl structure)
 (cond ((word? structure) (pigl structure))
 ((null? structure) '())
 (else (cons (deep–pigl (car structure))
 (deep–pigl (cdr structure))))))