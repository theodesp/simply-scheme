#lang racket
(require (planet dyoo/simply-scheme:2:2))


;20.1  What happens when we evaluate the following expression? What is printed, and what is the return value? Try to figure it out in your head before you try it on the computer.
;
;(cond ((= 2 3) (show '(lady madonna)) '(i call your name))
;      ((< 2 3) (show '(the night before)) '(hello little girl))
;      (else '(p.s. i love you)))
;20.2  What does newline return in your version of Scheme?
;
;20.3  Define show in terms of newline and display.
;
;20.4  Write a program that carries on a conversation like the following example. What the user types is in boldface.
;
;> (converse)
;Hello, I'm the computer.  What's your name? Brian Harvey
;Hi, Brian.  How are you? I'm fine.
;Glad to hear it.
;20.5  Our name-table procedure uses a fixed width for the column containing the last names of the people in the argument list. Suppose that instead of liking British-invasion music you are into late romantic Russian composers:
;
;> (name-table '((piotr tchaikovsky) (nicolay rimsky-korsakov)
;		(sergei rachmaninov) (modest musorgsky)))
;Alternatively, perhaps you like jazz:
;
;> (name-table '((bill evans) (paul motian) (scott lefaro)))
;Modify name-table so that it figures out the longest last name in its argument list, adds two for spaces, and uses that number as the width of the first column.
;
;20.6  The procedure ask-user isn't robust. What happens if you type something that isn't a number, or isn't between 1 and 9? Modify it to check that what the user types is a number between 1 and 9. If not, it should print a message and ask the user to try again.
;
;20.7  Another problem with ask-user is that it allows a user to request a square that isn't free. If the user does this, what happens? Fix ask-user to ensure that this can't happen.
;
;20.8  At the end of the game, if the computer wins or ties, you never find out which square it chose for its final move. Modify the program to correct this. (Notice that this exercise requires you to make play-ttt-helper non-functional.)
;
;20.9  The way we invoke the game program isn't very user-friendly. Write a procedure game that asks you whether you wish to play x or o, then starts a game. (By definition, x plays first.) Then write a procedure games that allows you to keep playing repeatedly. It can ask "do you want to play again?" after each game. (Make sure that the outcome of each game is still reported, and that the user can choose whether to play x or o before each game.)
;
;[1] The only exception is that we've used trace, which prints messages about the progress of a computation.
;[2] We know that it's still not as beautiful as can be, because of the capital letters and parentheses, but we'll get to that later.
;
;[3] Suppose show returns #f in your version of Scheme. Then you might see
;
;> (show 7)
;7
;#F
;But since the return value is unspecified, we try to write programs in such a way that we never use show's return value as the return value from our procedures. That's why we return values like burp.
;
;[4] The term side effect is based on the idea that a procedure may have a useful return value as its main purpose and may also have an effect "on the side." It's a misnomer to talk about the side effect of show, since the effect is its main purpose. But nobody ever says "side return value"!
;
;[5] In Chapter 4, we said that the body of a procedure was always one single expression. We lied. But as long as you don't use any procedures with side effects, it doesn't do you any good to evaluate more than one expression in a body.
;
;[6] For example:
;
;> (cond ((< 4 0)
;	 (show '(how interesting))
;	 (show '(4 is less than zero?))
;	 #f)
;	((> 4 0)
;	 (show '(more reasonable))
;	 (show '(4 really is more than zero))
;	 'value)
;	(else
;	 (show '(you mean 4=0?))
;	 #f))
;(MORE REASONABLE)
;(4 REALLY IS MORE THAN ZERO)
;VALUE
;[7] Sometimes people sloppily say that the procedure is a function. In fact, you may hear people be really sloppy and call a non-functional procedure a function!
;
;[8] You wrote the procedures already-won? and tie-game? in Exercises 10.1 and 10.2:
;
;(define (already-won? position who)
;  (member? (word who who who)  (find-triples position)))
;
;(define (tie-game? position)
;  (not (member? '_ position)))
;[9] Alternate version:
;
;(define (subword wd start end)
;  (cond ((> start 1) (subword (bf wd) (- start 1) (- end 1)))
;	((< end (count wd)) (subword (bl wd) start end))
;	(else wd)))
;You can take your choice, depending on which you think is easier, recursion or higher-order functions.

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
;21.3  Every time we want to know something about a function that the user typed in, such as its number of arguments or its domain-checking predicate, we have to do an assoc in *the-functions*. That's inefficient. Instead, rewrite the program so that get-fn returns a function's entry from the a-list, instead of just its name. Then rename the variable fn-name to fn-entry in the functions-loop procedure, and rewrite the selectors scheme-procedure, arg-count, and so on, so that they don't invoke assoc.
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
;21.8  What is the value of the following Scheme expression?
;
;(functions)
;21.9  We said in the recursion chapters that every recursive procedure has to have a base case and a recursive case, and that the recursive case has to somehow reduce the size of the problem, getting closer to the base case. How does the recursive call in get-fn reduce the size of the problem?


;22.1  Write a concatenate procedure that takes two arguments: a list of names of input files, and one name for an output file. The procedure should copy all of the input files, in order, into the output file.
;
;22.2  Write a procedure to count the number of lines in a file. It should take the filename as argument and return the number.
;
;22.3  Write a procedure to count the number of words in a file. It should take the filename as argument and return the number.
;
;22.4  Write a procedure to count the number of characters in a file, including space characters. It should take the filename as argument and return the number.
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
;22.6  Write a lookup procedure that takes as arguments a filename and a word. The procedure should print (on the screen, not into another file) only those lines from the input file that include the chosen word.
;
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
;23.3  Write a function vector-append that works just like regular append, but for vectors:
;
;> (vector-append '#(not a) '#(second time))
;#(not a second time)
;23.4  Write vector->list.
;
;23.5  Write a procedure vector-map that takes two arguments, a function and a vector, and returns a new vector in which each box contains the result of applying the function to the corresponding element of the argument vector.
;
;23.6  Write a procedure vector-map! that takes two arguments, a function and a vector, and modifies the argument vector by replacing each element with the result of applying the function to that element. Your procedure should return the same vector.
;
;23.7  Could you write vector-filter? How about vector-filter!? Explain the issues involved.
;
;23.8  Modify the lap procedure to print "Car 34 wins!" when car 34 completes its 200th lap. (A harder but more correct modification is to print the message only if no other car has completed 200 laps.)
;
;23.9   Write a procedure leader that says which car is in the lead right now.
;
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
;23.15  Generalize Exercise 23.14 by implementing an array structure that can have any number of dimensions. Instead of taking two numbers as index arguments, as the matrix procedures do, the array procedures will take one argument, a list of numbers. The number of numbers is the number of dimensions, and it will be constant for any particular array. For example, here is a three-dimensional array (4×5×6):
;
;> (define a1 (make-array '(4 5 6)))
;
;> (array-set! a1 '(3 2 3) '(the end))
;23.16  We want to reimplement sentences as vectors instead of lists.
;
;(a) Write versions of sentence, empty?, first, butfirst, last, and butlast that use vectors. Your selectors need only work for sentences, not for words.
;
;> (sentence 'a 'b 'c)
;#(A B C)
;
;> (butfirst (sentence 'a 'b 'c))
;#(B C)
;(You don't have to make these procedures work on lists as well as vectors!)
;
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
