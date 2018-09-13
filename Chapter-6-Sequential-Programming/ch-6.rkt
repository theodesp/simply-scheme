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


;;; The functions program

(define (functions)
  ;; (read-line)
  (show "Welcome to the FUNCTIONS program.")
  (functions-loop))

(define (functions-loop)
  (let ((fn-name (get-fn)))
    (if (equal? fn-name 'exit)
	"Thanks for using FUNCTIONS!"
	(let ((args (get-args (arg-count fn-name))))
	  (if (not (in-domain? args fn-name))
	     (show "Argument(s) not in domain.")
	     (show-answer (apply (scheme-function fn-name) args)))
	  (functions-loop)))))

(define (get-fn)
  (display "Function: ")
  (let ((line (read-line)))
    (cond ((empty? line)
	   (show "Please type a function!")
	   (get-fn))
	  ((not (= (count line) 1))
	   (show "You typed more than one thing!  Try again.")
	   (get-fn))
	  ((not (valid-fn-name? (first line)))
	   (show "Sorry, that's not a function.")
	   (get-fn))
	  (else (first line)))))

(define (get-arg curr n)
  (if (= n 1)
      (display "Argument:")
      (show (se (item curr '("First" "Second", "Third")) "Argument:")))
       (let ((line (read-line)))
         (cond ((empty? line)
	   (show "Please type an argument!")
	   (get-arg curr n))
	  ((and (equal? "(" (first (first line)))
		(equal? ")" (last (last line))))
	   (let ((sent (remove-first-paren (remove-last-paren line))))
	     (if (any-parens? sent)
		 (begin
		  (show "Sentences can't have parentheses inside.")
		  (get-arg curr n))
		 (map booleanize sent))))
	  ((any-parens? line)
	   (show "Bad parentheses")
	   (get-arg curr n))
	  ((empty? (bf line)) (booleanize (first line)))
	  (else (show "You typed more than one argument!  Try again.")
		(get-arg curr n)))))
   
     
  

(define (get-args curr n)
  (cond ((= n 0) '())
        ((= n 1) get-arg 1 n)
        (cons (get-arg curr n) (get-args (+ curr 1) (- n 1)))))

(define (any-parens? line)
  (let ((letters (accumulate word line)))
    (or (member? "(" letters)
	(member? ")" letters))))

(define (remove-first-paren line)
  (if (equal? (first line) "(")
      (bf line)
      (se (bf (first line)) (bf line))))

(define (remove-last-paren line)
  (if (equal? (last line) ")")
      (bl line)
      (se (bl line) (bl (last line)))))

(define (booleanize x)
  (cond ((equal? x "#t") #t)
	((equal? x "#f") #f)
	(else x)))

(define (show-answer answer)
  (newline)
  (display "The result is: ")
  (if (not answer)
      (show "#F")
      (show answer))
  (newline))

(define (scheme-function fn-name)
  (cadr (assoc fn-name *the-functions*)))

(define (arg-count fn-name)
  (caddr (assoc fn-name *the-functions*)))

(define (type-predicate fn-name)
  (cadddr (assoc fn-name *the-functions*)))

(define (in-domain? args fn-name)
  (apply (type-predicate fn-name) args))

(define (fn-entry fn-name)
  (assoc fn-name *the-functions*))

;; Type predicates

(define (word-or-sent? x)
  (or (word? x) (sentence? x)))

(define (not-empty? x)
  (and (word-or-sent? x) (not (empty? x))))

(define (two-numbers? x y)
  (and (number? x) (number? y)))

(define (two-reals? x y)
  (and (real? x) (real? y)))

(define (two-integers? x y)
  (and (integer? x) (integer? y)))

(define (can-divide? x y)
  (and (number? x) (number? y) (not (= y 0))))

(define (dividable-integers? x y)
  (and (two-integers? x y) (not (= y 0))))

(define (trig-range? x)
  (and (number? x) (<= (abs x) 1)))

(define (hof-types-ok? fn-name stuff range-predicate)
  (and (valid-fn-name? fn-name)
       (= 1 (arg-count fn-name))
       (word-or-sent? stuff)
       (empty? (keep (lambda (element)
		       (not ((type-predicate fn-name) element)))
		     stuff))
       (null? (filter (lambda (element)
			(not (range-predicate element)))
		      (map (scheme-function fn-name)
			   (every (lambda (x) x) stuff))))))

(define (member-types-ok? small big)
  (and (word? small)
       (or (sentence? big) (and (word? big) (= (count small) 1)))))


;; Names of functions as functions

(define (named-every fn-name list)
  (every (scheme-function fn-name) list))

(define (named-keep fn-name list)
  (keep (scheme-function fn-name) list))

(define (valid-fn-name? name)
  (assoc name *the-functions*))

;; The list itself
          
(define *the-functions*
  (list (list '* * 2 two-numbers?)
	(list '+ + 2 two-numbers?)
	(list '- - 2 two-numbers?)
	(list '/ / 2 can-divide?)
	(list '< < 2 two-reals?)
	(list '<= <= 2 two-reals?)
	(list '= = 2 two-numbers?)
	(list '> > 2 two-reals?)
	(list '>= >= 2 two-reals?)
	(list 'abs abs 1 real?)
	(list 'acos acos 1 trig-range?)
	(list 'and (lambda (x y) (and x y)) 2 
	      (lambda (x y) (and (boolean? x) (boolean? y))))
	(list 'appearances appearances 2 member-types-ok?)
	(list 'asin asin 1 trig-range?)
	(list 'atan atan 1 number?)
	(list 'bf bf 1 not-empty?)
	(list 'bl bl 1 not-empty?)
	(list 'butfirst butfirst 1 not-empty?)
	(list 'butlast butlast 1 not-empty?)
	(list 'ceiling ceiling 1 real?)
	(list 'cos cos 1 number?)
	(list 'count count 1 word-or-sent?)
	(list 'equal? equal? 2 (lambda (x y) #t))
	(list 'even? even? 1 integer?)
	(list 'every named-every 2
	      (lambda (fn stuff)
		(hof-types-ok? fn stuff word-or-sent?)))
	(list 'exit '() 0 '())
	   ; in case user applies number-of-arguments to exit
	(list 'exp exp 1 number?)

	(list 'expt expt 2
	      (lambda (x y)
		(and (number? x) (number? y)
		     (or (not (real? x)) (>= x 0) (integer? y)))))
	(list 'first first 1 not-empty?)
	(list 'floor floor 1 real?)
	(list 'gcd gcd 2 two-integers?)
	(list 'if (lambda (pred yes no) (if pred yes no)) 3
	      (lambda (pred yes no) (boolean? pred)))
	(list 'item item 2
	      (lambda (n stuff)
		(and (integer? n) (> n 0)
		     (word-or-sent? stuff) (<= n (count stuff)))))
	(list 'keep named-keep 2
	      (lambda (fn stuff)
		(hof-types-ok? fn stuff boolean?)))
	(list 'last last 1 not-empty?)
	(list 'lcm lcm 2 two-integers?)
	(list 'log log 1 (lambda (x) (and (number? x) (not (= x 0)))))
	(list 'max max 2 two-reals?)
	(list 'member? member? 2 member-types-ok?)
	(list 'min min 2 two-reals?)
	(list 'modulo modulo 2 dividable-integers?)
	(list 'not not 1 boolean?)
	(list 'number-of-arguments arg-count 1 valid-fn-name?)
	(list 'odd? odd? 1 integer?)
	(list 'or (lambda (x y) (or x y)) 2
	      (lambda (x y) (and (boolean? x) (boolean? y))))
	(list 'quotient quotient 2 dividable-integers?)
	(list 'random random 1 (lambda (x) (and (integer? x) (> x 0))))
	(list 'remainder remainder 2 dividable-integers?)
	(list 'round round 1 real?)
	(list 'se se 2
	      (lambda (x y) (and (word-or-sent? x) (word-or-sent? y))))
	(list 'sentence sentence 2
	      (lambda (x y) (and (word-or-sent? x) (word-or-sent? y))))
	(list 'sentence? sentence? 1 (lambda (x) #t))
	(list 'sin sin 1 number?)
	(list 'sqrt sqrt 1 (lambda (x) (and (real? x) (>= x 0))))
	(list 'tan tan 1 number?)
	(list 'truncate truncate 1 real?)
	(list 'vowel? (lambda (x) (member? x '(a e i o u))) 1
	      (lambda (x) #t))
	(list 'word word 2 (lambda (x y) (and (word? x) (word? y))))
	(list 'word? word? 1 (lambda (x) #t))))



(define (get-song n)
  (let ((port (open-input-file "songs2")))
    (skip-songs (- n 1) port)
    (let ((answer (read-line port)))
      (close-input-port port)
      answer)))

(define (skip-songs n port)
  (if (= n 0)
      'done
      (begin (read-line port)
	     (skip-songs (- n 1) port))))


(define (print-file name)
  (let ((port (open-input-file name)))
    (print-file-helper port)
    (close-input-port port)
    'done))


(define (file-map fn inname outname)
  (let ((inport (open-input-file inname))
	(outport (open-output-file outname)))
    (file-map-helper fn inport outport)
    (close-input-port inport)
    (close-output-port outport)
    'done))

(define (file-map-helper fn inport outport)
  (let ((line (read-line inport)))
    (if (eof-object? line)
	'done
	(begin (show-line (fn line) outport)
	       (file-map-helper fn inport outport)))))

(define (process-grades line)
  (se (first line)
      "total:"
      (accumulate + (bf line))
      "average:"
      (/ (accumulate + (bf line))
	 (count (bf line)))))


(define (justify line width)
  (if (< (count line) 2)
      line
      (se (pad line
	       (- (count line) 1)
	       (extra-spaces width (char-count line))))))

(define (char-count line)
  (+ (accumulate + (every count line))      ; letters within words
     (- (count line) 1)))                   ; plus spaces between words

(define (extra-spaces width chars)
  (if (> chars width)
      0                                     ; none if already too wide
      (- width chars)))

(define (pad line chances needed)
  (if (= chances 0)                         ; only one word in line
      (first line)
      (let ((extra (quotient needed chances)))
	(word (first line)
	      (spaces (+ extra 1))
	      (pad (bf line) (- chances 1) (- needed extra))))))

(define (spaces n)
  (if (= n 0)
      ""
      (word " " (spaces (- n 1)))))


(define (print-file-helper port)
  (let ((stuff (read-string port)))
    (if (eof-object? stuff)
	'done
	(begin (show stuff)
	       (print-file-helper port)))))



(define (filemerge file1 file2 outfile)
  (let ((p1 (open-input-file file1))
	(p2 (open-input-file file2))
	(outp (open-output-file outfile)))
    (filemerge-helper p1 p2 outp (read-string p1) (read-string p2))
    (close-output-port outp)
    (close-input-port p1)
    (close-input-port p2)
    'done))

(define (filemerge-helper p1 p2 outp line1 line2)
  (cond ((eof-object? line1) (merge-copy line2 p2 outp))
	((eof-object? line2) (merge-copy line1 p1 outp))
	((before? line1 line2)
	 (show line1 outp)
	 (filemerge-helper p1 p2 outp (read-string p1) line2))
	(else (show line2 outp)
	      (filemerge-helper p1 p2 outp line1 (read-string p2)))))

(define (merge-copy line inp outp)
  (if (eof-object? line)
      #f
      (begin (show line outp)
	     (merge-copy (read-string inp) inp outp))))

(define v (make-vector 5))
(vector-set! v 0 'shoe)
(vector-set! v 3 'bread)
(vector-set! v 2 '(savoy truffle))
(vector-ref v 3)

(define *lap-vector* (make-vector 100))

(define (initialize-lap-vector index)
  (if (< index 0)
      'done
      (begin (vector-set! *lap-vector* index 0)
	     (initialize-lap-vector (- index 1)))))

(define (lap car-number)
  (vector-set! *lap-vector*
	       car-number
	       (+ (vector-ref *lap-vector* car-number) 1))
  (vector-ref *lap-vector* car-number))

(define (card-list)
  (reduce append
	  (map (lambda (suit) (map (lambda (rank) (word suit rank))
				   '(a 2 3 4 5 6 7 8 9 10 j q k)))
	       '(h s d c))))

(define (make-deck)
  (shuffle! (list->vector (card-list)) 51))

(define (shuffle! deck index)
  (if (< index 0)
      deck
      (begin (vector-swap! deck index (random (+ index 1)))
	     (shuffle! deck (- index 1)))))

(define (vector-swap! vector index1 index2)
  (let ((temp (vector-ref vector index1)))
    (vector-set! vector index1 (vector-ref vector index2))
    (vector-set! vector index2 temp)))

(define (list->vector lst)
  (l->v-helper (make-vector (length lst)) lst 0))

(define (l->v-helper vec lst index)
  (if (= index (vector-length vec))
      vec
      (begin (vector-set! vec index (car lst))
	     (l->v-helper vec (cdr lst) (+ index 1)))))

(define (list-square numbers)
  (if (null? numbers)
      '()
      (cons (square (car numbers))
	    (list-square (cdr numbers)))))

(define (vector-square numbers)
  (vec-sq-helper (make-vector (vector-length numbers))
		 numbers
		 (- (vector-length numbers) 1)))

(define (vec-sq-helper new old index)
  (if (< index 0)
      new
      (begin (vector-set! new index (square (vector-ref old index)))
	     (vec-sq-helper new old (- index 1)))))
