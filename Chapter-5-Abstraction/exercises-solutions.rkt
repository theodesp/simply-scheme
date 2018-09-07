#lang racket
(require (planet dyoo/simply-scheme:2:2))
;
;17.1 What will Scheme print in response to each of the following expressions? Try to figure it out in your head before
;you try it on the computer.
;> (car '(Rod Chris Colin Hugh Paul))

; Answer: Rod

;> (cadr '(Rod Chris Colin Hugh Paul))

; Answer: Chris

;> (cdr '(Rod Chris Colin Hugh Paul))

; Answer: '(Chris Colin Hugh Paul)

;> (car 'Rod)

; Throw error

;> (cons '(Rod Argent) '(Chris White))

; Answer: '((Rod Argent) Chris White)

;> (append '(Rod Argent) '(Chris White))

; Answer: '(Rod Argent Chris White)


;> (list '(Rod Argent) '(Chris White))

; Answer: '((Rod Argent) (Chris White))

;> (caadr '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))

; Answer: 'Chris

;Page 300
;> (assoc 'Colin '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))

; Answer: '(Colin Blunstone)

;> (assoc 'Argent '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))

; Answer: #f

;17.2 For each of the following examples, write a procedure of two arguments that, when applied to the sample
;arguments, returns the sample result. Your procedures may not include any quoted data
;
;> (f1 '(a b c) '(d e f))
;((B C D))

(define (f1 lst1 lst2)
  (cons (append (cdr lst1) (list (car lst2))) '()))

(f1 '(a b c) '(d e f))

;> (f2 '(a b c) '(d e f))
;((B C) E)

(define (f2 lst1 lst2)
   (cons (cdr lst1)
         (list (cadr lst2))))

(f2 '(a b c) '(d e f))

;> (f3 '(a b c) '(d e f))
;(A B C A B C)

(define (f3 lst1 lst2)
   (append lst1 lst1))

(f3 '(a b c) '(d e f))

;> (f4 '(a b c) '(d e f))
;((A D) (B C E F))

(define (f4 lst1 lst2)
   (cons (list (car lst1) (car lst2))
         (list (append (cdr lst1)  (cdr lst2)))))

(f4 '(a b c) '(d e f))

;17.3 Describe the value returned by this invocation of map:
;> (map (lambda (x) (lambda (y) (+ x y))) '(1 2 3 4))


; Answer: A list of procedures that accept 1 parameter and when invoked it will
; print the accociated number + y in that list

;Real Exercises
;17.4 Describe the result of calling the following procedure with a list as its argument. (See if you can figure it out
;before you try it.)
;(define (mystery lst)
; (mystery–helper lst '()))
;(define (mystery–helper lst other)
; (if (null? lst)
; other
; (mystery–helper (cdr lst) (cons (car lst) other))))

; Answer: Reverses a list

;Page 301
;17.5 Here's a procedure that takes two numbers as arguments and returns whichever number is larger:
;(define (max2 a b)
; (if (> b a) b a))
;Use max2 to implement max, a procedure that takes one or more numeric arguments and returns the largest of them.

(define (max2 a b)
  (if (> b a) b a))

(define (max args)
  (cond ((empty? args) '())
        ((empty? (cdr args)) (car args))
        (else (max2 (car args) (max (cdr args))))))

(max '(1 2 30 2 7 19))

;17.6 Implement append using car, cdr, and cons. (Note: The built-in append can take any number of
;arguments. First write a version that accepts only two arguments. Then, optionally, try to write a version that takes any
;number.)


;17.7 Append may remind you of sentence. They're similar, except that append works only with lists as
;arguments, whereas sentence will accept words as well as lists. Implement sentence using append. (Note: The
;built-in sentence can take any number of arguments. First write a version that accepts only two arguments. Then,
;optionally, try to write a version that takes any number. Also, you don't have to worry about the error checking that the
;real sentence does.)


;17.8 Write member.
;17.9 Write list–ref.

(define (list–ref lst i)
  (cond ((empty? lst) '())
        ((or (> i (length lst)) (< (length lst) i)) '())
        ((and (= i 0) (> (length lst) 1)) (car lst))
        (else (list–ref (cdr lst) (- i 1)))))

(list–ref '(back in the ussr) 2)

;17.10 Write length.
;17.11 Write before–in–list?, which takes a list and two elements of the list. It should return #t if the second
;argument appears in the list argument before the third argument:
;
;> (before–in–list? '(back in the ussr) 'in 'ussr)
;#T
;> (before–in–list? '(back in the ussr) 'the 'back)
;#F
;The procedure should also return #f if either of the supposed elements doesn't appear at all.
;Page 302

(define (before–in–list? lst a b)
  (cond ((empty? lst) #f)
        ((empty? (cdr lst)) #f)
        ((and (equal? (car lst) a) (member? b (cdr lst))) #t)
        (else (before–in–list? (cdr lst) a b))))

(before–in–list? '(back in the ussr) 'in 'ussr)
(before–in–list? '(back in the ussr) 'the 'back)

;17.12 Write a procedure called flatten that takes as its argument a list, possibly including sublists, but whose
;ultimate building blocks are words (not Booleans or procedures). It should return a sentence containing all the words
;of the list, in the order in which they appear in the original:
;> (flatten '(((a b) c (d e)) (f g) ((((h))) (i j) k)))
;(A B C D E F G H I J K)

(define (flatten lst)
  (cond ((not (list? lst)) (list lst))
        ((empty? lst) '())
        ((empty? (cdr lst)) (flatten (car lst)))
        (else (append (flatten (car lst))
                      (flatten (cdr lst))))))

(flatten '(((a b) c (d e)) (f g) ((((h))) (i j) k)))

;17.13 Here is a procedure that counts the number of words anywhere within a structured list:
;(define (deep–count lst)
; (cond ((null? lst) 0)
; ((word? (car lst)) (+ 1 (deep–count (cdr lst))))
; (else (+ (deep–count (car lst))
; (deep–count (cdr lst))))))
;Although this procedure works, it's more complicated than necessary. Simplify it.

(define (deep–count lst)
  (cond ((null? lst) 0)
        ((word? (car lst)) (+ 1 (deep–count (cdr lst))))
        (reduce + (map (lambda (sublist) (deep–count sublist)) lst))))

(deep–count '(1 2 1))

;17.14 Write a procedure branch that takes as arguments a list of numbers and a nested list structure. It should be the
;list-of-lists equivalent of item, like this:
;> (branch '(3) '((a b) (c d) (e f) (g h)))
;(E F)
;> (branch '(3 2) '((a b) (c d) (e f) (g h)))
;F
;> (branch '(2 3 1 2) '((a b) ((c d) (e f) ((g h) (i j)) k) (l m)))
;H
;In the last example above, the second element of the list is
;((C D) (E F) ((G H) (I J)) K)
;The third element of that smaller list is ((G H) (I J)); the first element of that is (G H); and the second element
;of that is just H.

(define (branch lst container)
  (cond
    ((empty? lst) '())
    ((empty? container) '())
    ((and (= (length lst) 1) (list-ref container (- (car lst) 1))))
    ((= (length (cdr lst)) 1) (list-ref (list-ref container (- (car lst) 1)) (- (cadr lst) 1)))
    (else (branch (cdr lst) (list-ref container (- (car lst) 1))))))

(branch '(3) '((a b) (c d) (e f) (g h)))
(branch '(3 2) '((a b) (c d) (e f) (g h)))
(branch '(2 3 1 2) '((a b) ((c d) (e f) ((g h) (i j)) k) (l m)))

;17.15 Modify the pattern matcher to represent the known–values database as a list of two-element lists, as we
;suggested at the beginning of this chapter.
;
;17.16 Write a predicate valid–infix? that takes a list as argument and returns #t if and only if the list is a
;legitimate infix arithmetic expression (alternating operands and operators, with parentheses—that is, sublists—allowed
;for grouping).
;> (valid–infix? '(4 + 3 * (5 – 2)))
;#T
;> (valid–infix? '(4 + 3 * (5 2)))
;#F

(define (operator? wd)
  (member? wd '*-+/))

(define (valid–infix? expr)
  (cond ((empty? expr) #t)
        ((= (length expr) 1) #t)
        ((list? (car expr)) (and (valid–infix? (car expr))
                                 (valid–infix? (cdr expr))))
        ((list? (cadr expr)) (and (valid–infix? (cadr expr))
                                  (valid–infix? (cddr expr))))
        ((and (= (length expr) 3)
              (list? (caddr expr))) (valid–infix? (caddr expr)))
        ((and (number? (car expr))
              (operator? (cadr expr))
              (number? (caddr expr))
              (valid–infix? (cddr expr))))
         (else #f)))

(valid–infix? '(3 * (5 - 2)))
(valid–infix? '(4 + 3 * (5 2)))

;18.1  What does
;
;((SAN FRANCISCO))
;mean in the printout of world-tree? Why two sets of parentheses?
;
; Answer: It means that the child leaf is a list when we defined it

;18.2  Suppose we change the definition of the tree constructor so that it uses list instead of cons:
;
;(define (make-node datum children)
;  (list datum children))

;How do we have to change the selectors so that everything still works?
;
;Answer you will have to use cadr  in children node

;18.3  Write depth, a procedure that takes a tree as argument and returns the largest number of nodes connected through parent-child links. That is, a leaf node has depth 1; a tree in which all the children of the root node are leaves has depth 2. Our world tree has depth 4 (because the longest path from the root to a leaf is, for example, world, country, state, city).
;

(define (make-node datum children)
  (cons datum children))

(define (datum node)
  (car node))

(define (children node)
  (cdr node))


;18.4  Write count-nodes, a procedure that takes a tree as argument and returns the total number of nodes in the tree. (Earlier we counted the number of leaf nodes.)
;

(define (leaf? node)
  (empty? (cdr node)))

(define (node? node)
  (not (leaf? node)))

(define (count-nodes tree)
  (if (node? tree)
      1
      (count-nodes-in-forest (children tree))))

(define (count-nodes-in-forest forest)
  (if (null? forest)
      0
      (+ (count-nodes (car forest))
         (count-nodes-in-forest (cdr forest)))))

;18.5  Write prune, a procedure that takes a tree as argument and returns a copy of the tree, but with all the leaf nodes of the original tree removed. (If the argument to prune is a one-node tree, in which the root node has no children, then prune should return #f because the result of removing the root node wouldn't be a tree.)

(define (prune tree)
  (if (node? tree)
      (make-node (datum tree) (prune-leafs-in-forest (children tree)))
      (prune-leafs-in-forest (children tree))))

(define (prune-leafs-in-forest forest)
  (if (null? forest)
      '()
      (make-node (prune (car forest))
                 (prune-leafs-in-forest (children forest)))))
          
(prune  '(world (italy (venezia) (riomaggiore) (firenze) (roma))))

;
;18.6  Write a program parse-scheme that parses a Scheme arithmetic expression into the same kind of tree that parse produces for infix expressions. Assume that all procedure invocations in the Scheme expression have two arguments.
;
;The resulting tree should be a valid argument to compute:
;
;> (compute (parse-scheme '(* (+ 4 3) 2)))
;14

(define (parse-scheme expr)
  (parse-helper expr '() '()))
;(You can solve this problem without the restriction to two-argument invocations if you rewrite compute so that it doesn't assume every branch node has two children.)

(define (compute tree)
  (if (number? (datum tree))
      (datum tree)
      (foldl (function-named-by (datum tree)) 0 (map car (children tree)))))

;19.1  What happens if you say the following?
;
;(every cdr '((john lennon) (paul mccartney)
;	     (george harrison) (ringo starr)))

; Answer: Will pick up the surname of each list item

;How is this different from using map, and why? How about cadr instead of cdr?
;

; Answer: Map will map each as a list item


;Real Exercises
;19.2  Write keep. Don't forget that keep has to return a sentence if its second argument is a sentence, and a word if its second argument is a word.
;
;(Hint: it might be useful to write a combine procedure that uses either word or sentence depending on the types of its arguments.)
;

(define (keep fn lst)
  (cond ((empty? lst) lst)
        (else (if (eq? (fn (first lst)) #t)
            (combine lst (keep fn (bf lst)))
            (keep fn (bf lst))))))

(define (combine lst rest)
  (if (word? lst)
      (word (first lst) rest)
      (se (first lst) rest)))

(keep odd? '12345)

;19.3  Write the three-argument version of accumulate that we described.
;
;> (three-arg-accumulate + 0 '(4 5 6))
;15
;
;> (three-arg-accumulate + 0 '())
;0
;
;> (three-arg-accumulate cons '() '(a b c d e))
;(A B C D E)

(define (three-arg-accumulate fn curr lst)
  (cond ((empty? lst) curr)
        (else (fn (first lst) (three-arg-accumulate fn curr (cdr lst))))))

(three-arg-accumulate + 0 '(4 5 6))
(three-arg-accumulate cons '() '(a b c d e))


;19.4  Our accumulate combines elements from right to left. That is,
;
;(accumulate - '(2 3 4 5))
;computes 2-(3-(4-5)). Write left-accumulate, which will compute ((2-3)-4)-5 instead. (The result will be the same for an operation such as +, for which grouping order doesn't matter, but will be computes 2-(3-(4-5)). Write left-accumulate, which will compute ((2-3)-4)-5 instead. (The result will be the same for an operation such as +, for which grouping order doesn't matter, but will be different for -.)ts. The predicate must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for any two adjacent words in the sentence:
;
;> (true-for-any-pair? equal? '(a b c b a))
;#F
;
;> (true-for-any-pair? equal? '(a b c c d))
;#T
;
;> (true-for-any-pair? < '(20 16 5 8 6))      ;; 5 is less than 8
;#T

(define (true-for-any-pair? fn lst)
  (cond ((empty? (cdr lst)) #t)
        (else (or (true-for-all-pairs? fn (list (car lst) (cadr lst))) (true-for-any-pair? fn (cdr lst))))))


(true-for-all-pairs? equal? '(a b c d ))
(true-for-any-pair? < '(20 16 5 8 6))

;19.7  Write a procedure true-for-all-pairs? that takes a predicate and a sentence as arguments. The predicate must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for every two adjacent words in the sentence:
;
;> (true-for-all-pairs? equal? '(a b c c d))
;#F
;
;> (true-for-all-pairs? equal? '(a a a a a))
;#T
;
;> (true-for-all-pairs? < '(20 16 5 8 6))
;#F
;
;> (true-for-all-pairs? < '(3 7 19 22 43))
;#T

(define (true-for-all-pairs? fn lst)
  (cond ((empty? (cdr lst)) #t)
        (else (and (fn (car lst) (cadr lst)) (true-for-all-pairs? fn (cdr lst))))))

(true-for-all-pairs? equal? '(a b c c d))
(true-for-all-pairs? equal? '(a a a a a))
(true-for-all-pairs? < '(20 16 5 8 6))
(true-for-all-pairs? < '(3 7 19 22 43))

;19.8  Rewrite true-for-all-pairs? (Exercise 19.7) using true-for-any-pair? (Exercise 19.6) as a helper procedure. Don't use recursion in solving this problem (except for the recursion you've already used to write true-for-any-pair?). Hint: You'll find the not procedure helpful.
;


;19.9  Rewrite either of the sort procedures from Chapter 15 to take two arguments, a list and a predicate. It should sort the elements of that list according to the given predicate:
;
;> (sort '(4 23 7 5 16 3) <)
;(3 4 5 7 16 23)
;
;> (sort '(4 23 7 5 16 3) >)
;(23 16 7 5 4 3)
;
;> (sort '(john paul george ringo) before?)
;(GEORGE JOHN PAUL RINGO)
;19.10  Write tree-map, analogous to our deep-map, but for trees, using the datum and children selectors.
;

(define (tree-map fn tree)
  (cond ((leaf? tree) (map fn tree))
        (else (append (list (fn (car tree))) (tree-map-in-forest fn (children tree))))))

(define (tree-map-in-forest fn forest)
  (if (null? forest)
      '()
      (append (tree-map fn (car forest)) (tree-map-in-forest fn (cdr forest)))))

(define (cities name-list)
  (map leaf name-list))

(define (leaf datum)
  (make-node datum '()))


(tree-map count '(world (italy (venezia) (riomaggiore) (firenze) (roma))))

;19.11  Write repeated. (This is a hard exercise!)

(define (repeated fn number)
   (if (= number 0)
       (lambda (x) x)
       (lambda (x) ((repeated fn (- number 1)) (fn x)))))

(define (sq x) (* x x))

(define 2-repeated (repeated sq 2))

(2-repeated 2)
;
;19.12  Write tree-reduce. You may assume that the combiner argument can be invoked with no arguments.
;
;> (tree-reduce
;   +
;   (make-node 3 (list (make-node 4 '())
;		      (make-node 7 '())
;		      (make-node 2 (list (make-node 3 '())
;					 (make-node 8 '()))))))
;27
;19.13  Write deep-reduce, similar to tree-reduce, but for structured lists:
;
;> (deep-reduce word '(r ((a (m b) (l)) (e (r)))))
;RAMBLER


(define (deep-reduce fn lst)
  (cond ((empty? lst) "")
        ((list? lst) (fn (car lst) (deep-reduce-in-list fn (cdr lst))))
        (else (fn (first lst) (deep-reduce-in-list fn (bf lst))))))

(define (deep-reduce-in-list fn lst)
  (if (empty? lst)
      ""
      (fn (deep-reduce fn (car lst)) (deep-reduce-in-list fn (cdr lst)))))

(deep-reduce word '(a (m b) (l) (e (r))))