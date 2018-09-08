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