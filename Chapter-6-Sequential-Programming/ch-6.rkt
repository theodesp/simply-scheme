#lang racket
(require (planet dyoo/simply-scheme:2:2))

(define (bottles n)
  (if (= n 0)
      '()
      (append (verse n)
	      (bottles (- n 1)))))
(define (verse n)
  (list (cons n '(bottles of beer on the wall))
	(cons n '(bottles of beer))
	'(if one of those bottles should happen to fall)
	(cons (- n 1) '(bottles of beer on the wall))
	'()))

(bottles 3)

(define (bottlez n)
  (if (= n 0)
      'burp
      (begin (verze n)
	     (bottlez (- n 1)))))

(define (verze n)
  (show (cons n '(bottles of beer on the wall)))
  (show (cons n '(bottles of beer)))
  (show '(if one of those bottles should happen to fall))
  (show (cons (- n 1) '(bottles of beer on the wall)))
  (show '()))

(bottlez 4)

(define (effect x)
  (show x)
  'done)

(define (value x)
  x)

(define (lots-of-effect x)
    (effect x)
    (effect x)
    (effect x))

(define (lots-of-value x)
    (value x)
    (value x)
    (value x))

(lots-of-effect '(oh! darling))
(lots-of-value '(oh! darling))

(define (show-addition x y)
  (display x)
  (display '+)
  (display y)
  (display '=)
  (show (+ x y)))

(begin (show-addition 3 4)
	 (show-addition 6 8)
	 'done)

(define (show-list lst)
  (if (null? lst)
      'done
      (begin (show (car lst))
	     (show-list (cdr lst)))))

(show-list '((dig a pony) (doctor robert) (for you blue)))

(for-each show '((mean mr mustard) (no reply) (tell me why)))

(define (echo)
  (display "What? ")
  (let ((expr (read)))
    (if (equal? expr 'stop)
	'okay
	(begin
	 (show expr)
	 (echo)))))


(define (print-position position)
  (print-row (subword position 1 3))
  (show "-+-+-")
  (print-row (subword position 4 6))
  (show "-+-+-")
  (print-row (subword position 7 9))
  (newline))

(define (print-row row)
  (maybe-display (first row))
  (display "|")
  (maybe-display (first (bf row)))
  (display "|")
  (maybe-display (last row))
  (newline))

(define (maybe-display letter)
  (if (not (equal? letter '_))
      (display letter)
      (display " ")))

(define (subword wd start end)
  ((repeated bf (- start 1))
   ((repeated bl (- (count wd) end))
    wd)))

(print-position '_x_oo__xx)

(define (music-critic)                       ;; second version
  (read-line)   ; See explanation below.
  (show "What's your favorite Beatles song?")
  (let ((song (read-line)))
    (show (se "I like" song "too."))))

(define (square-root-table nums)
  (if (null? nums)
      'done
      (begin (display (align (car nums) 7 1))
	     (show (align (sqrt (car nums)) 10 5))
	     (square-root-table (cdr nums)))))


(define (name-table names)
  (if (null? names)
      'done
      (begin (display (align (cadar names) 11))
	     (show (caar names))
	     (name-table (cdr names)))))

(define (ask-for-name)
  (show "Please type your first name, then your last name:")
  (let ((first-name (read)))
    (list first-name (read))))

(define (ask-question question)
  (show question)
  (let ((answer (read)))
    (cond ((equal? answer 'yes) #t)
	  ((equal? answer 'no) #f)
	  (else (show "Please answer yes or no.")
		(ask-question question)))))