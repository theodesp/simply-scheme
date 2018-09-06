;#lang racket
;(require (planet dyoo/simply-scheme:2:2))
;
;17.1 What will Scheme print in response to each of the following expressions? Try to figure it out in your head before
;you try it on the computer.
;> (car '(Rod Chris Colin Hugh Paul))
;> (cadr '(Rod Chris Colin Hugh Paul))
;> (cdr '(Rod Chris Colin Hugh Paul))
;> (car 'Rod)
;> (cons '(Rod Argent) '(Chris White))
;> (append '(Rod Argent) '(Chris White))
;> (list '(Rod Argent) '(Chris White))
;> (caadr '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
;Page 300
;> (assoc 'Colin '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
;> (assoc 'Argent '((Rod Argent) (Chris White)
; (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
;17.2 For each of the following examples, write a procedure of two arguments that, when applied to the sample
;arguments, returns the sample result. Your procedures may not include any quoted data
;
;> (f1 '(a b c) '(d e f))
;((B C D))
;> (f2 '(a b c) '(d e f))
;((B C) E)
;> (f3 '(a b c) '(d e f))
;(A B C A B C)
;> (f4 '(a b c) '(d e f))
;((A D) (B C E F))
;17.3 Describe the value returned by this invocation of map:
;> (map (lambda (x) (lambda (y) (+ x y))) '(1 2 3 4))
;Real Exercises
;17.4 Describe the result of calling the following procedure with a list as its argument. (See if you can figure it out
;before you try it.)
;(define (mystery lst)
; (mystery–helper lst '()))
;(define (mystery–helper lst other)
; (if (null? lst)
; other
; (mystery–helper (cdr lst) (cons (car lst) other))))
;Page 301
;17.5 Here's a procedure that takes two numbers as arguments and returns whichever number is larger:
;(define (max2 a b)
; (if (> b a) b a))
;Use max2 to implement max, a procedure that takes one or more numeric arguments and returns the largest of them.
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
;17.12 Write a procedure called flatten that takes as its argument a list, possibly including sublists, but whose
;ultimate building blocks are words (not Booleans or procedures). It should return a sentence containing all the words
;of the list, in the order in which they appear in the original:
;> (flatten '(((a b) c (d e)) (f g) ((((h))) (i j) k)))
;(A B C D E F G H I J K)
;17.13 Here is a procedure that counts the number of words anywhere within a structured list:
;(define (deep–count lst)
; (cond ((null? lst) 0)
; ((word? (car lst)) (+ 1 (deep–count (cdr lst))))
; (else (+ (deep–count (car lst))
; (deep–count (cdr lst))))))
;Although this procedure works, it's more complicated than necessary. Simplify it.
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

;18.1  What does
;
;((SAN FRANCISCO))
;mean in the printout of world-tree? Why two sets of parentheses?
;
;18.2  Suppose we change the definition of the tree constructor so that it uses list instead of cons:
;
;(define (make-node datum children)
;  (list datum children))
;How do we have to change the selectors so that everything still works?
;
;18.3  Write depth, a procedure that takes a tree as argument and returns the largest number of nodes connected through parent-child links. That is, a leaf node has depth 1; a tree in which all the children of the root node are leaves has depth 2. Our world tree has depth 4 (because the longest path from the root to a leaf is, for example, world, country, state, city).
;
;18.4  Write count-nodes, a procedure that takes a tree as argument and returns the total number of nodes in the tree. (Earlier we counted the number of leaf nodes.)
;
;18.5  Write prune, a procedure that takes a tree as argument and returns a copy of the tree, but with all the leaf nodes of the original tree removed. (If the argument to prune is a one-node tree, in which the root node has no children, then prune should return #f because the result of removing the root node wouldn't be a tree.)
;
;18.6  Write a program parse-scheme that parses a Scheme arithmetic expression into the same kind of tree that parse produces for infix expressions. Assume that all procedure invocations in the Scheme expression have two arguments.
;
;The resulting tree should be a valid argument to compute:
;
;> (compute (parse-scheme '(* (+ 4 3) 2)))
;14
;(You can solve this problem without the restriction to two-argument invocations if you rewrite compute so that it doesn't assume every branch node has two children.)