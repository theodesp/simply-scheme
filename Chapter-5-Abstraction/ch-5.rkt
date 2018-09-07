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


(define (leaf datum)
  (make-node datum '()))

(define (leaf? node)
  (null? (children node)))

(define (cities name-list)
  (map leaf name-list))

(define (count-leaves tree)
  (if (leaf? tree)
      1
      (count-leaves-in-forest (children tree))))

(define (count-leaves-in-forest forest)
  (if (null? forest)
      0
      (+ (count-leaves (car forest))
         (count-leaves-in-forest (cdr forest)))))

(define (count-leaf tree)
  (if (leaf? tree)
      1
      (count-leaf (child tree))))


(define (in-tree? place tree)
  (or (equal? place (datum tree))
      (in-forest? place (children tree))))

(define (in-forest? place forest)
  (if (null? forest)
      #f
      (or (in-tree? place (car forest))
	  (in-forest? place (cdr forest)))))

(define (locate city tree)
  (if (equal? city (datum tree))
      (list city)
      (let ((subpath (locate-in-forest city (children tree))))
        (if subpath
            (cons (datum tree) subpath)
            #f))))

(define (locate-in-forest city forest)
  (if (null? forest)
      #f
      (or (locate city (car forest))
	  (locate-in-forest city (cdr forest)))))

(define (make-node datum children)
  (cons datum children))

(define (datum node)
  (car node))

(define (children node)
  (cdr node))

(define world-tree
  (make-node
   'world
   (list (make-node
          'italy
          (cities '(venezia riomaggiore firenze roma)))
         (make-node
          '(united states)
          (list (make-node
                 'california
                 (cities '(berkeley (san francisco) gilroy)))
                (make-node
                 'massachusetts
                 (cities '(cambridge amherst sudbury)))
                (make-node 'ohio (cities '(kent)))))
         (make-node 'zimbabwe (cities '(harare hwange)))
         (make-node 'china
		    (cities '(beijing shanghai guangzhou suzhou)))
         (make-node
          '(great britain)
          (list 
           (make-node 'england (cities '(liverpool)))
           (make-node 'scotland
		      (cities '(edinburgh glasgow (gretna green))))
           (make-node 'wales (cities '(abergavenny)))))
         (make-node
          'australia
          (list
           (make-node 'victoria (cities '(melbourne)))
           (make-node '(new south wales) (cities '(sydney)))
           (make-node 'queensland
		      (cities '(cairns (port douglas))))))
         (make-node 'honduras (cities '(tegucigalpa))))))


(define (parse expr)
  (parse-helper expr '() '()))

(define (parse-helper expr operators operands)
  (cond ((null? expr)
	 (if (null? operators)
	     (car operands)
	     (handle-op '() operators operands)))
	((number? (car expr))
	 (parse-helper (cdr expr)
		       operators
		       (cons (make-node (car expr) '()) operands)))
	((list? (car expr))
	 (parse-helper (cdr expr)
		       operators
		       (cons (parse (car expr)) operands)))
	(else (if (or (null? operators)
		      (> (precedence (car expr))
			 (precedence (car operators))))
		  (parse-helper (cdr expr)
				(cons (car expr) operators)
				operands)
		  (handle-op expr operators operands)))))

(define (precedence oper)
  (if (member? oper '(+ -)) 1 2))

(define (compute tree)
  (if (number? (datum tree))
      (datum tree)
      ((function-named-by (datum tree))
         (compute (car (children tree)))
         (compute (cadr (children tree))))))


(define (handle-op expr operators operands)
  (parse-helper expr
		(cdr operators)
		(cons (make-node (car operators)
				 (list (cadr operands) (car operands)))
		      (cddr operands))))

(define (function-named-by oper)
  (cond ((equal? oper '+) +)
	((equal? oper '-) -)
	((equal? oper '*) *)
	((equal? oper '/) /)
	(else (error "no such operator as" oper))))


(define (area shape r) (* shape r r))
(define square 1)
(define circle pi)
(define sphere (* 4 pi))
(define hexagon (* (sqrt 3) 1.5))

(define (accumulate combiner stuff)
  (cond ((not (empty? stuff)) (real-accumulate combiner stuff))
        ((member combiner (list + * word se append))
         (combiner))
        (else (error
               "Can't accumulate empty input with that combiner"))))

(define (real-accumulate combiner stuff)
  (if (empty? (bf stuff))
      (first stuff)
      (combiner (first stuff) (real-accumulate combiner (bf stuff)))))