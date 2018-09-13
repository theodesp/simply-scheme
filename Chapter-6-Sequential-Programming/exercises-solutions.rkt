#lang racket
(require (planet dyoo/simply-scheme:2:2))

;20.1  What happens when we evaluate the following expression? What is printed, and what is the return value? Try to figure it out in your head before you try it on the computer.
;
;(cond ((= 2 3) (show '(lady madonna)) '(i call your name))
;      ((< 2 3) (show '(the night before)) '(hello little girl))
;      (else '(p.s. i love you)))

; Answer: Will print
; (the night before)
; '(hello little girl)

;20.2  What does newline return in your version of Scheme?
;

; Answer: an empty line


;20.3  Define show in terms of newline and display.
;
;20.4  Write a program that carries on a conversation like the following example. What the user types is in boldface.
;
;> (converse)
;Hello, I'm the computer.  What's your name? Brian Harvey
;Hi, Brian.  How are you? I'm fine.
;Glad to hear it.

(define (converse)
  (read-line)
  (show "Hello, I'm the computer.  What's your name?")
  (let ((name (read-line)))
    (show (se "Hi," name ". How are you?"))
    (let ((status (read-line)))
      (show "Glad to hear it"))))

(converse)

;20.5  Our name-table procedure uses a fixed width for the column containing the last names of the people in the argument list. Suppose that instead of liking British-invasion music you are into late romantic Russian composers:
;
;> (name-table '((piotr tchaikovsky) (nicolay rimsky-korsakov)
;		(sergei rachmaninov) (modest musorgsky)))
;Alternatively, perhaps you like jazz:
;
;> (name-table '((bill evans) (paul motian) (scott lefaro)))
;Modify name-table so that it figures out the longest last name in its argument list, adds two for spaces, and uses that number as the width of the first column.
;

(define (name-table names)
  (if (null? names)
      'done
      (begin (display (align (cadar names) (+ 2 (count (cadar names)))))
	     (show (caar names))
	     (name-table (cdr names)))))

;20.6  The procedure ask-user isn't robust. What happens if you type something that isn't a number, or isn't between 1 and 9? Modify it to check that what the user types is a number between 1 and 9. If not, it should print a message and ask the user to try again.
;

(define (ask-for-name)
  (show "Please enter a number between 1-9:")
  (let ((num (read)))
    (if (or (< num 1) (> num 9))
        (begin (show "Wrong!")
               (ask-for-name))
        (show "OK!"))))
            

;20.7  Another problem with ask-user is that it allows a user to request a square that isn't free. If the user does this, what happens? Fix ask-user to ensure that this can't happen.
;
;20.8  At the end of the game, if the computer wins or ties, you never find out which square it chose for its final move. Modify the program to correct this. (Notice that this exercise requires you to make play-ttt-helper non-functional.)
;
;20.9  The way we invoke the game program isn't very user-friendly. Write a procedure game that asks you whether you wish to play x or o, then starts a game. (By definition, x plays first.) Then write a procedure games that allows you to keep playing repeatedly. It can ask "do you want to play again?" after each game. (Make sure that the outcome of each game is still reported, and that the user can choose whether to play x or o before each game.)

;21.1  The get-args procedure has a let that creates the variable first, and then that variable is used only once inside the body of the let. Why doesn't it just say the following?
;
;(define (get-args n)
;  (if (= n 0)
;      '()
;      (cons (get-arg) (get-args (- n 1)))))

;21.2  The domain-checking function for equal? is
;
;(lambda (x y) #t)
;This seems silly it's a function of two arguments that ignores both arguments and always returns #t. Since we know ahead of time that the answer is #t, why won't it work to have equal?'s entry in the a-list be
;
;(list 'equal? equal? 2 #t)

; Answer: That will break compatibility as we will have to check the type is not a function

;21.3  Every time we want to know something about a function that the user typed in, such as its number of arguments or its domain-checking predicate, we have to do an assoc in *the-functions*. That's inefficient. Instead, rewrite the program so that get-fn returns a function's entry from the a-list, instead of just its name. Then rename the variable fn-name to fn-entry in the functions-loop procedure, and rewrite the selectors scheme-procedure, arg-count, and so on, so that they don't invoke assoc.

(define (fn-entry fn-name)
  (assoc fn-name *the-functions*)

;21.4  Currently, the program always gives the message "argument(s) not in domain" when you try to apply a function to bad arguments. Modify the program so that each record in *the-functions* also contains a specific out-of-domain message like "both arguments must be numbers," then modify functions to look up and print this error message along with "argument(s) not in domain."
;
;21.5  Modify the program so that it prompts for the arguments this way:
;
;Function: if
;First Argument: #t
;Second Argument: paperback
;Third Argument: writer
;
;The result is: PAPERBACK
;but if there's only one argument, the program shouldn't say First:
;
;Function: sqrt
;Argument: 36
;
;The result is 6
;21.6  The assoc procedure might return #f instead of an a-list record. How come it's okay for arg-count to take the caddr of assoc's return value if (caddr #f) is an error?
;
;21.7  Why is the domain-checking predicate for the word? function
;
;(lambda (x) #t)
;instead of the following procedure?
;
;(lambda (x) (word? x))

; Answer : So it can check if its a word actually
  
;21.8  What is the value of the following Scheme expression?

; Answer: Nothing it just prints to screen
;
;(functions)
;21.9  We said in the recursion chapters that every recursive procedure has to have a base case and a recursive case, and that the recursive case has to somehow reduce the size of the problem, getting closer to the base case. How does the recursive call in get-fn reduce the size of the problem?

; Answer: By exiting after it accepts a valid line



;22.1  Write a concatenate procedure that takes two arguments: a list of names of input files, and one name for an output file. The procedure should copy all of the input files, in order, into the output file.

  (define (concatenate lfnames output)
  (if (empty? lfnames)
      'done
      (let ((inport (open-input-file (car lfnames)))
            (outport (open-output-file output)))
            (append-file-helper inport outport)
            (close-input-port inport)
            (close-output-port outport)
            (concatenate (cdr lfnames output)))))

(define (append-file-helper inport outport)
  (let ((line (read-line inport)))
    (if (eof-object? line)
	'done
	(begin (show-line line outport)
	       (append-file-helper inport outport)))))
;
;22.2  Write a procedure to count the number of lines in a file. It should take the filename as argument and return the number.

(define (count-lines name)
  (let ((port (open-input-file name)))
    (show (count-lines-helper port))
    (close-input-port port)
    'done))

(define (count-lines-helper name)
  (let ((line (read-line name)))
    (if (eof-object? line)
	0
        (+ 1 (count-lines-helper name)))))

;
;22.3  Write a procedure to count the number of words in a file. It should take the filename as argument and return the number.
;

(define (count-words name)
  (let ((port (open-input-file name)))
    (show (count-words-helper port))
    (close-input-port port)
    'done))

(define (count-words-helper name)
  (let ((line (read-line name)))
    (if (eof-object? line)
	0
        (+ (count line) (count-words-helper name)))))

  
;22.4  Write a procedure to count the number of characters in a file, including space characters. It should take the filename as argument and return the number.

(define (count-chars name)
  (let ((port (open-input-file name)))
    (show (count-chars-helper port))
    (close-input-port port)
    'done))

(define (count-chars-helper name)
  (let ((line (read-line name)))
    (if (eof-object? line)
	0
        (+ (accumulate + (map count line)) (count-chars-helper name)))))

;
;22.5  Write a procedure that copies an input file to an output file but eliminates multiple consecutive copies of the same line. That is, if the input file contains the lines
;
;John Lennon
;Paul McCartney
;Paul McCartney
;George Harrison
;
;
;Paul McCartney
;Ringo Starr
;then the output file should contain
;
;John Lennon
;Paul McCartney
;George Harrison
;
;Paul McCartney
;Ringo Starr


(define (copy-uniques inname outname)
  (let ((inport (open-input-file inname))
	(outport (open-output-file outname)))
    (copy-uniques-helper inport outport '())
    (close-input-port inport)
    (close-output-port outport)
    'done))

(define (copy-uniques-helper inport outport seen)
  (let ((line (read-string inport)))
    (if (eof-object? line)
	'done
        (if (member? line seen)
            (copy-uniques-helper inport outport seen)
            (begin (show line outport)
                   (copy-uniques-helper inport outport (cons line seen)))))))

  
;22.6  Write a lookup procedure that takes as arguments a filename and a word. The procedure should print (on the screen, not into another file) only those lines from the input file that include the chosen word.
;

(define (lookup name term)
  (let ((port (open-input-file lookup)))
    (lookup-helper port term)
    (close-input-port port)
    'done))

(define (lookup-helper port term)
  (let ((line (read-string inport)))
    (if (eof-object? line)
	'done
        (if (string-contains? line term)
            (begin (show line)
                   (lookup-helper port term))))))
  
;22.7  Write a page procedure that takes a filename as argument and prints the file a screenful at a time. Assume that a screen can fit 24 lines; your procedure should print 23 lines of the file and then a prompt message, and then wait for the user to enter a (probably empty) line. It should then print the most recent line from the file again (so that the user will see some overlap between screenfuls) and 22 more lines, and so on until the file ends.
;
;22.8  A common operation in a database program is to join two databases, that is, to create a new database combining the information from the two given ones. There has to be some piece of information in common between the two databases. For example, suppose we have a class roster database in which each record includes a student's name, student ID number, and computer account name, like this:
;
;((john alec entwistle) 04397 john)
;((keith moon) 09382 kmoon)
;((peter townshend) 10428 pete)
;((roger daltrey) 01025 roger)
;We also have a grade database in which each student's grades are stored according to computer account name:
;
;(john 87 90 76 68 95)
;(kmoon 80 88 95 77 89)
;(pete 100 92 80 65 72)
;(roger 85 96 83 62 74)
;We want to create a combined database like this:
;
;((john alec entwistle) 04397 john 87 90 76 68 95)
;((keith moon) 09382 kmoon 80 88 95 77 89)
;((peter townshend) 10428 pete 100 92 80 65 72)
;((roger daltrey) 01025 roger 85 96 83 62 74)
;in which the information from the roster and grade databases has been combined for each account name.
;
;Write a program join that takes five arguments: two input filenames, two numbers indicating the position of the item within each record that should overlap between the files, and an output filename. For our example, we'd say
;
;> (join "class-roster" "grades" 3 1 "combined-file")
;In our example, both files are in alphabetical order of computer account name, the account name is a word, and the same account name never appears more than once in each file. In general, you may assume that these conditions hold for the item that the two files have in common. Your program should not assume that every item in one file also appears in the other. A line should be written in the output file only for the items that do appear in both files.

;Do not solve any of the following exercises by converting a vector to a list, using list procedures, and then converting the result back to a vector.
;
;23.1  Write a procedure sum-vector that takes a vector full of numbers as its argument and returns the sum of all the numbers:
;
;> (sum-vector '#(6 7 8))
;21

(define (sum-vector numbers)
  (vec-sum-helper 0 numbers (- (vector-length numbers) 1)))

(define (vec-sum-helper acc old index)
  (if (< index 0)
      acc
      (vec-sum-helper (+ (vector-ref old index) acc) old (- index 1))))

(sum-vector '#(6 7 8))

;23.2  Some versions of Scheme provide a procedure vector-fill! that takes a vector and anything as its two arguments. It replaces every element of the vector with the second argument, like this:
;
;> (define vec (vector 'one 'two 'three 'four))
;
;> vec
;#(one two three four)
;
;> (vector-fill! vec 'yeah)
;
;> vec
;#(yeah yeah yeah yeah)
;Write vector-fill!. (It doesn't matter what value it returns.)
;

(define (vector-fill! vec item)
  (vec-fill-helper (make-vector (vector-length vec)) vec (- (vector-length vec) 1) item))

(define (vec-fill-helper new old index item)
  (if (< index 0)
      new
      (begin (vector-set! new index item)
             (vec-fill-helper new old (- index 1) item))))

(vector-fill! '#(6 7 8) 'yeah)
  
;23.3  Write a function vector-append that works just like regular append, but for vectors:
;
;> (vector-append '#(not a) '#(second time))
;#(not a second time)

(define (vector-append a b)
  (let ((v (make-vector (+ (vector-length a) (vector-length b)))))
    (vector-append-helper v a b 0)))
    

(define (vector-append-helper new a b index)
  (if (>= index (vector-length new))
      new
      (cond ((>= index (vector-length a))
             (begin (vector-set! new index (vector-ref b (- index (vector-length a))))
             (vector-append-helper new a b (+ index 1))))
            ((begin (vector-set! new index (vector-ref a index)))
             (vector-append-helper new a b (+ index 1))))))
      
(vector-append '#(not a) '#(second time))
  
;23.4  Write vector->list.
;
;23.5  Write a procedure vector-map that takes two arguments, a function and a vector, and returns a new vector in which each box contains the result of applying the function to the corresponding element of the argument vector.
;

(define (vector-map f vec)
  (if (= (vector-length vec) 0)
      vec
       (vec-map-helper f (make-vector (vector-length vec)) vec (- (vector-length vec) 1))))
  
(define (vec-map-helper f new old index)
  (if (< index 0)
      new
      (begin (vector-set! new index (f (vector-ref old index)))
      (vec-map-helper f new old (- index 1)))))
      
(vector-map count '#(second time))

  
;23.6  Write a procedure vector-map! that takes two arguments, a function and a vector, and modifies the argument vector by replacing each element with the result of applying the function to that element. Your procedure should return the same vector.
;
;23.7  Could you write vector-filter? How about vector-filter!? Explain the issues involved.
;
;23.8  Modify the lap procedure to print "Car 34 wins!" when car 34 completes its 200th lap. (A harder but more correct modification is to print the message only if no other car has completed 200 laps.)
;
;23.9   Write a procedure leader that says which car is in the lead right now.
;

(define (leader)
  (leader-helper 0 (- (vector-length *lap-vector*) 1) 0))

(define (leader-helper max index leaderIndex)
  (if (< index 0)
      leaderIndex
      (if (> (vector-ref *lap-vector* index) max)
          (leader-helper (vector-ref *lap-vector* index) (- index 1) index)
          (leader-helper max (- index 1) leaderIndex))))
  
;23.10  Why doesn't this solution to Exercise 23.9 work?
;
;(define (leader)
;  (leader-helper 0 1))
;
;(define (leader-helper leader index)
;  (cond ((= index 100) leader)
;	((> (lap index) (lap leader))
;	 (leader-helper index (+ index 1)))
;	(else (leader-helper leader (+ index 1)))))

; Answer : The call to lap will increment!

;23.11  In some restaurants, the servers use computer terminals to keep track of what each table has ordered. Every time you order more food, the server enters your order into the computer. When you're ready for the check, the computer prints your bill.
;
;You're going to write two procedures, order and bill. Order takes a table number and an item as arguments and adds the cost of that item to that table's bill. Bill takes a table number as its argument, returns the amount owed by that table, and resets the table for the next customers. (Your order procedure can examine a global variable *menu* to find the price of each item.)
;
;> (order 3 'potstickers)
;
;> (order 3 'wor-won-ton)
;
;> (order 5 'egg-rolls)
;
;> (order 3 'shin-shin-special-prawns)
;
;> (bill 3)
;13.85
;
;> (bill 5)
;2.75

(define *tables-vector* (make-vector 20))
(define (price item)
  (cond ((equal? item 'potstickers) 10.80)
	((equal? item 'wor-won-ton) 12.60)
	((equal? item 'egg-rolls) 5.95)
	((equal? item 'shin-shin-special-prawns) 15.95)
	(else (error "no such item as" item))))

(define (initialize-tables-vector index)
  (if (< index 0)
      'done
      (begin (vector-set! *tables-vector* index 0)
	     (initialize-tables-vector (- index 1)))))

(define (order tableNum item)
  (vector-set! *tables-vector*
	       tableNum
	       (+ (vector-ref *tables-vector* tableNum) (price item))))

(define (bill tableNum)
  (vector-ref *tables-vector* tableNum))

(order 3 'potstickers)
(order 3 'wor-won-ton)
(bill 3)
  
;23.12  Rewrite selection sort (from Chapter 15) to sort a vector. This can be done in a way similar to the procedure for shuffling a deck: Find the smallest element of the vector and exchange it (using vector-swap!) with the value in the first box. Then find the smallest element not including the first box, and exchange that with the second box, and so on. For example, suppose we have a vector of numbers:
;
;#(23 4 18 7 95 60)
;Your program should transform the vector through these intermediate stages:
;
;#(4 23 18 7 95 60)   ; exchange 4 with 23
;#(4 7 18 23 95 60)   ; exchange 7 with 23
;#(4 7 18 23 95 60)   ; exchange 18 with itself
;#(4 7 18 23 95 60)   ; exchange 23 with itself
;#(4 7 18 23 60 95)   ; exchange 60 with 95
;23.13  Why doesn't this work?
;
;(define (vector-swap! vector index1 index2)
;  (vector-set! vector index1 (vector-ref vector index2))
;  (vector-set! vector index2 (vector-ref vector index1)))

  
;23.14  Implement a two-dimensional version of vectors. (We'll call one of these structures a matrix.) The implementation will use a vector of vectors. For example, a three-by-five matrix will be a three-element vector, in which each of the elements is a five-element vector. Here's how it should work:
;
;> (define m (make-matrix 3 5))
;
;> (matrix-set! m 2 1 '(her majesty))
;
;> (matrix-ref m 2 1)
;(HER MAJESTY)

(define (make-matrix x y)
  (begin
    (initialize-vector (make-vector x) (- x 1) (make-v y))
  ))

(define (make-v x)
  (lambda ()
    (make-vector x)))

(define (initialize-vector vector index with)
  (if (< index 0)
      vector
      (begin (vector-set! vector index (with))
	     (initialize-vector vector (- index 1) with))))

(define m (make-matrix 5 3))

(define (matrix-set! m x y item)
  (let* ((xm (vector-ref m x)))
    (begin
      (vector-set! xm y item)
      (vector-set! m x xm))))
  
;23.15  Generalize Exercise 23.14 by implementing an array structure that can have any number of dimensions. Instead of taking two numbers as index arguments, as the matrix procedures do, the array procedures will take one argument, a list of numbers. The number of numbers is the number of dimensions, and it will be constant for any particular array. For example, here is a three-dimensional array (4×5×6):
;
;> (define a1 (make-array '(4 5 6)))
;
;> (array-set! a1 '(3 2 3) '(the end))


(define (make-array lst)
  (if (empty? lst)
      'done
      (make-array-helper (make-vector (car lst)) (cdr lst))))


(define (make-array-helper vector rest)
  (if (empty? rest)
      (initialize-vector vector (- (vector-length vector) 1) (lambda () 0))
      (let ((base (make-array-helper (make-vector (car rest)) (cdr rest))))
        (initialize-vector vector  (- (vector-length vector) 1) (lambda () base)))))
       

(define (initialize-vector vector index with)
  (if (< index 0)
      vector
      (begin (vector-set! vector index (with))
	     (initialize-vector vector (- index 1) with))))

(define a1 (make-array '(4 5 6)))
  
;23.16  We want to reimplement sentences as vectors instead of lists.
;
;(a) Write versions of sentence, empty?, first, butfirst, last, and butlast that use vectors. Your selectors need only work for sentences, not for words.
;
;> (sentence 'a 'b 'c)
;#(A B C)
;

(define (sentence arg . rest)
  (if (empty? arg)
      (make-vector 0)
      (begin
        (let ((v (make-vector (+ 1 (count rest)))))
          (sentence-helper v 1 rest)
          (vector-set! v 0 arg)
          v))))

(define (sentence-helper new index lst)
  (if (>= index (vector-length new))
      new
      (begin
        (vector-set! new index (car lst))
        (sentence-helper new (+ index 1) (cdr lst))
  )))
     
(sentence 'a 'b 'c)
;> (butfirst (sentence 'a 'b 'c))
;#(B C)
;(You don't have to make these procedures work on lists as well as vectors!)
;

(define (butfirst lst)
  (if (empty? lst)
      (make-vector 0)
      (begin
        (let ((v (make-vector (count (cdr lst)))))
          (sentence-helper v 0 (cdr lst))
          v))))

(define (sentence-helper new index lst)
  (if (>= index (vector-length new))
      new
      (begin
        (vector-set! new index (car lst))
        (sentence-helper new (+ index 1) (cdr lst))
  )))
     
(butfirst '(a b c))
;(b) Does the following program still work with the new implementation of sentences? If not, fix the program.
;
;(define (praise stuff)
;  (sentence stuff '(is good)))
;(c) Does the following program still work with the new implementation of sentences? If not, fix the program.
;
;(define (praise stuff)
;  (sentence stuff 'rules!))
;(d) Does the following program still work with the new implementation of sentences? If not, fix the program. If so, is there some optional rewriting that would improve its performance?
;

 (define (sentence arg . rest)
  (if (empty? arg)
      (make-vector 0)
        (let* ((rest (if (list? (cdr rest)) (car rest) (cdr rest)))
               (v (make-vector (+ 1 (count rest)))))
               
          (begin
            (sentence-helper v 1 rest)
            (vector-set! v 0 arg)
          v))))
     

(define (butfirst lst)
  (if (empty? lst)
      (make-vector 0)
        (let* ((rest (if (list? (cdr lst)) (car lst) (cdr lst)))
               (v (make-vector (count rest))))
          (begin
            (sentence-helper v 0 (cdr lst))
            v))))

(define (sentence-helper new index lst)
  (if (>= index (vector-length new))
      new
      (begin
        (vector-set! new index (car lst))
        (sentence-helper new (+ index 1) (cdr lst))
  )))
     

(define (praise stuff)
  (sentence stuff '(is good)))

(praise 'hello)
;(define (item n sent)
;  (if (= n 1)
;      (first sent)
;      (item (- n 1) (butfirst sent))))
;(e) Does the following program still work with the new implementation of sentences? If not, fix the program. If so, is there some optional rewriting that would improve its performance?
;
;(define (every fn sent)
;  (if (empty? sent)
;      sent
;      (sentence (fn (first sent))
;		(every fn (butfirst sent)))))
;(f) In what ways does using vectors to implement sentences affect the speed of the selectors and constructor? Why do you think we chose to use lists?