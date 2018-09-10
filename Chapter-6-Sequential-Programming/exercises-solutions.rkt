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
