#lang racket

;11.1  Write downup4 using only the word and sentence primitive procedures.
;
;11.2  [8.12][4] When you teach a class, people will get distracted if you say "um" too many times. Write a count-ums that counts the number of times "um" appears in a sentence:
;
;> (count-ums
;   '(today um we are going to um talk about the combining um method))
;3
;Here are some special-case count-ums procedures for sentences of particular lengths:
;
;(define (count-ums0 sent)
;  0)
;
;(define (count-ums1 sent)
;  (if (equal? 'um (first sent))
;      1
;      0))
;
;(define (count-ums2 sent)
;  (if (equal? 'um (first sent))
;      (+ 1 (count-ums1 (bf sent)))
;      (count-ums1 (bf sent))))
;
;(define (count-ums3 sent)
;  (if (equal? 'um (first sent))
;      (+ 1 (count-ums2 (bf sent)))
;      (count-ums2 (bf sent))))
;Write count-ums recursively.
;
;11.3  [8.13] Write a procedure phone-unspell that takes a spelled version of a phone number, such as POPCORN, and returns the real phone number, in this case 7672676. You will need a helper procedure that translates a single letter into a digit:
;
;(define (unspell-letter letter)
;  (cond ((member? letter 'abc) 2)
;	((member? letter 'def) 3)
;	((member? letter 'ghi) 4)
;	((member? letter 'jkl) 5)
;	((member? letter 'mno) 6)
;	((member? letter 'prs) 7)
;	((member? letter 'tuv) 8)
;	((member? letter 'wxy) 9)
;	(else 0)))
;Here are some some special-case phone-unspell procedures:
;
;(define (phone-unspell1 wd)
;  (unspell-letter wd))
;
;(define (phone-unspell2 wd)
;  (word (unspell-letter (first wd))
;	(unspell-letter (first (bf wd)))))
;
;(define (phone-unspell3 wd)
;  (word (unspell-letter (first wd))
;	(unspell-letter (first (bf wd)))
;	(unspell-letter (first (bf (bf wd))))))
;Write phone-unspell recursively.
;
;Real Exercises
;Use recursion to solve these problems, not higher order functions (Chapter 8)!
;
;11.4  Who first said "use what you have to get what you need"?
;
;11.5  Write a procedure initials that takes a sentence as its argument and returns a sentence of the first letters in each of the sentence's words:
;
;> (initials '(if i needed someone))
;(I I N S)
;11.6  Write a procedure countdown that works like this:
;
;> (countdown 10)
;(10 9 8 7 6 5 4 3 2 1 BLASTOFF!)
;
;> (countdown 3)
;(3 2 1 BLASTOFF!)
;11.7  Write a procedure copies that takes a number and a word as arguments and returns a sentence containing that many copies of the given word:
;
;> (copies 8 'spam)
;(SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM)


;12.1  Here is a definition of a procedure that returns the sum of the numbers in its argument sentence:
;
;(define (addup nums)
;  (if (empty? (bf nums))
;      (first nums)
;      (+ (first nums) (addup (bf nums)))))
;Although this works, it could be simplified by changing the base case. Do that.
;
;12.2  Fix the bug in the following definition:
;
;(define (acronym sent)                       ;; wrong
;  (if (= (count sent) 1)
;      (first sent)
;      (word (first (first sent))
;	    (acronym (bf sent)))))
;12.3  Can we reduce the factorial base case argument from 0 to -1? If so, show the resulting procedure. If not, why not?
;
;12.4  Here's the definition of a function f:
;
;math display
;Implement f as a Scheme procedure. What does f do?
;
;Real Exercises
;Solve all of the following problems with recursive procedures. If you've read Part III, do not use any higher-order functions such as every, keep, or accumulate.
;
;12.5  [8.8] Write an exaggerate procedure which exaggerates sentences:
;
;> (exaggerate '(i ate 3 potstickers))
;(I ATE 6 POTSTICKERS)
;
;> (exaggerate '(the chow fun is good here))
;(THE CHOW FUN IS GREAT HERE)
;It should double all the numbers in the sentence, and it should replace "good" with "great," "bad" with "terrible," and anything else you can think of.
;
;12.6  [8.11] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding grade point average:
;
;> (gpa '(A A+ B+ B))
;3.67
;Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns −.33, 0, or .33, depending on whether the Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns -.33, 0, or .33, depending on whether the grade has a minus, a plus, or neither.zero one two three four five six seven eight nine)))
;12.8  Write a procedure numbers that takes a sentence as its argument and returns another sentence containing only the numbers in the argument:
;
;> (numbers '(76 trombones and 110 cornets))
;(76 110)
;12.9  Write a procedure real-words that takes a sentence as argument and returns all the "real" words of the sentence, using the same rule as the real-word? procedure from Chapter 1.
;
;12.10  Write a procedure remove that takes a word and a sentence as arguments and returns the same sentence, but with all copies of the given word removed:
;
;> (remove 'the '(the song love of the loved by the beatles))
;(SONG LOVE OF LOVED BY BEATLES)
;12.11  Write the procedure count, which returns the number of words in a sentence or the number of letters in a word.
;
;12.12  Write a procedure arabic which converts Roman numerals into Arabic numerals:
;
;> (arabic 'MCMLXXI)
;1971
;
;> (arabic 'MLXVI)
;1066
;You will probably find the roman-value procedure from Chapter 6 helpful. Don't forget that a letter can reduce the overall value if the letter that comes after it has a larger value, such as the C in MCM.
;
;12.13  Write a new version of the describe-time procedure from Exercise . Instead of returning a decimal number, it should behave like this:
;
;> (describe-time 22222)
;(6 HOURS 10 MINUTES 22 SECONDS)
;
;> (describe-time 4967189641)
;(1 CENTURIES 57 YEARS 20 WEEKS 6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)
;Can you make the program smart about saying 1 CENTURY instead of 1 CENTURIES?
;

;Exercises
;Classify each of these problems as a pattern (every, keep, or accumulate), if possible, and then write the
;procedure recursively. In some cases we've given an example of invoking the procedure we want you to write, instead
;of describing it.
;14.1
;> (remove–once 'morning '(good morning good morning))
;(GOOD GOOD MORNING)
;(It's okay if your solution removes the other MORNING instead, as long as it removes only one of them.)
;14.2
;> (up 'town)
;(T TO TOW TOWN)
;14.3
;> (remdup '(ob la di ob la da)) ;; remove duplicates
;(OB LA DI DA)
;(It's okay if your procedure returns (DI OB LA DA) instead, as long as it removes all but one instance of each
;duplicated word.)
;14.4
;> (odds '(i lost my little girl))
;(I MY GIRL)
;14.5 [8.7] Write a procedure letter–count that takes a sentence as its argument and returns the total number of
;letters in the sentence:
;> (letter–count '(fixing a hole))
;11
;14.6 Write member?.
;Page 230
;14.7 Write differences, which takes a sentence of numbers as its argument and returns a sentence containing the
;differences between adjacent elements. (The length of the returned sentence is one less than that of the argument.)
;> (differences '(4 23 9 87 6 12))
;(19 –14 78 –81 6)
;14.8 Write expand, which takes a sentence as its argument. It returns a sentence similar to the argument, except that
;if a number appears in the argument, then the return value contains that many copies of the following word:
;> (expand '(4 calling birds 3 french hens))
;(CALLING CALLING CALLING CALLING BIRDS FRENCH FRENCH FRENCH HENS)
;> (expand '(the 7 samurai))
;(THE SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI)
;
;14.9 Write a procedure called location that takes two arguments, a word and a sentence. It should return a number
;indicating where in the sentence that word can be found. If the word isn't in the sentence, return #f. If the word
;appears more than once, return the location of the first appearance.
;> (location 'me '(you never give me your money))
;4
;14.10 Write the procedure count–adjacent–duplicates that takes a sentence as an argument and returns the
;number of words in the sentence that are immediately followed by the same word:
;> (count–adjacent–duplicates '(y a b b a d a b b a d o o))
;3
;> (count–adjacent–duplicates '(yeah yeah yeah))
;2
;14.11 Write the procedure remove–adjacent–duplicates that takes a sentence as argument and returns the
;same sentence but with any word that's immediately followed by the same word removed:
;Page 231
;> (remove–adjacent–duplicates '(y a b b a d a b b a d o o))
;(Y A B A D A B A D O)
;> (remove–adjacent–duplicates '(yeah yeah yeah))
;(YEAH)
;14.12 Write a procedure progressive–squares? that takes a sentence of numbers as its argument. It should
;return #t if each number (other than the first) is the square of the number before it:
;> (progressive–squares? '(3 9 81 6561))
;#T
;> (progressive–squares? '(25 36 49 64))
;#F
;14.13 What does the pigl procedure from Chapter 11 do if you invoke it with a word like "frzzmlpt" that has no
;vowels? Fix it so that it returns "frzzmlptay."
;14.14 Write a predicate same–shape? that takes two sentences as arguments. It should return #t if two conditions
;are met: The two sentences must have the same number of words, and each word of the first sentence must have the
;same number of letters as the word in the corresponding position in the second sentence.
;> (same–shape? '(the fool on the hill) '(you like me too much))
;#T
;> (same–shape? '(the fool on the hill) '(and your bird can sing))
;#F
;14.15 Write merge, a procedure that takes two sentences of numbers as arguments. Each sentence must consist of
;numbers in increasing order. Merge should return a single sentence containing all of the numbers, in order. (We'll use
;this in the next chapter as part of a sorting algorithm.)
;> (merge '(4 7 18 40 99) '(3 6 9 12 24 36 50))
;(3 4 6 7 9 12 18 24 36 40 50 99)
;
;14.16 Write a procedure syllables that takes a word as its argument and returns the number of syllables in the
;word, counted according to the following rule: the number of syllables is the number of vowels, except that a group of
;consecutive vowels counts as one. For example, in the word "soaring," the group "oa" represents one syllable and the
;vowel "i" represents a second one.
;Be sure to choose test cases that expose likely failures of your procedure. For example, what if the word ends with a
;vowel? What if it ends with two vowels in a row? What if it has more than two consecutive vowels?
;(Of course this rule isn't good enough. It doesn't deal with things like silent "e"s that don't create a syllable ("like"),
;consecutive vowels that don't form a diphthong ("cooperate"), letters like "y" that are vowels only sometimes, etc. If
;you get bored, see whether you can teach the program to recognize some of these special cases.)
;
;Project:
;Spelling Names of Huge Numbers
;Write a procedure number–name that takes a positive integer argument and returns a sentence containing that
;number spelled out in words:
;> (number–name 5513345)
;(FIVE MILLION FIVE HUNDRED THIRTEEN THOUSAND THREE HUNDRED FORTY FIVE)
;> (number–name (factorial 20))
;(TWO QUINTILLION FOUR HUNDRED THIRTY TWO QUADRILLION NINE HUNDRED TWO
; TRILLION EIGHT BILLION ONE HUNDRED SEVENTY SIX MILLION SIX HUNDRED
; FORTY THOUSAND)
;There are some special cases you will need to consider:
;• Numbers in which some particular digit is zero
;• Numbers like 1,000,529 in which an entire group of three digits is zero.
;• Numbers in the teens.
;Here are two hints. First, split the number into groups of three digits, going from right to left. Also, use the sentence
;'(thousand million billion trillion quadrillion quintillion
; sextillion septillion octillion nonillion decillion)
;You can write this bottom-up or top-down. To work bottom-up, pick a subtask and get that working before you tackle
;the overall structure of the problem. For example, write a procedure that returns the word FIFTEEN given the
;argument 15.
;To work top-down, start by writing number–name, freely assuming the existence of whatever helper procedures you
;like. You can begin debugging by writing stub procedures that fit into the overall program but don't really do their job
;correctly. For example, as an intermediate stage you might end up with a program that works like this:
;> (number–name 1428425) ;; intermediate version
;(1 MILLION 428 THOUSAND 425)


;15.1 Write a procedure to–binary:
;> (to–binary 9)
;1001
;> (to–binary 23)
;10111
;15.2 A "palindrome" is a sentence that reads the same backward as forward. Write a predicate palindrome? that
;takes a sentence as argument and decides whether it is a palindrome. For example:
;> (palindrome? '(flee to me remote elf))
;#T
;> (palindrome? '(flee to me remote control))
;#F
;Do not reverse any words or sentences in your solution.
;15.3 Write a procedure substrings that takes a word as its argument. It should return a sentence containing all of
;the substrings of the argument. A substring is a subset whose letters come consecutively in the original word. For
;example, the word bat is a subset, but not a substring, of brat.
;15.4 Write a predicate procedure substring? that takes two words as arguments and returns #t if and only if the
;first word is a substring of the second. (See Exercise 15.3 for the definition of a substring.)
;Be careful about cases in which you encounter a "false start," like this:
;> (substring? 'ssip 'mississippi)
;#T
;and also about subsets that don't appear as consecutive letters in the second word:
;> (substring? 'misip 'mississippi)
;#F
;Page 244
;15.5 Suppose you have a phone number, such as 223-5766, and you'd like to figure out a clever way to spell it in
;letters for your friends to remember. Each digit corresponds to three possible letters. For example, the digit 2
;corresponds to the letters A, B, and C. Write a procedure that takes a number as argument and returns a sentence of all
;the possible spellings:
;> (phone–spell 2235766)
;(AADJPMM AADJPMN ... CCFLSOO)
;(We're not showing you all 2187 words in this sentence.) You may assume there are no zeros or ones in the number,
;since those don't have letters.
;Hint: This problem has a lot in common with the subsets example.
;15.6 Let's say a gladiator kills a roach. If we want to talk about the roach, we say "the roach the gladiator killed." But if
;we want to talk about the gladiator, we say "the gladiator that killed the roach."
;People are pretty good at understanding even rather long sentences as long as they're straightforward: "This is the
;farmer who kept the cock that waked the priest that married the man that kissed the maiden that milked the cow that
;tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." But even a
;short nested sentence is confusing: "This is the rat the cat the dog worried killed." Which rat was that?
;Write a procedure unscramble that takes a nested sentence as argument and returns a straightforward sentence
;about the same cast of characters:
;> (unscramble '(this is the roach the gladiator killed))
;(THIS IS THE GLADIATOR THAT KILLED THE ROACH)
;> (unscramble '(this is the rat the cat the dog the boy the
; girl saw owned chased bit))
;(THIS IS THE GIRL THAT SAW THE BOY THAT OWNED THE DOG THAT
; CHASED THE CAT THAT BIT THE RAT)
;You may assume that the argument has exactly the structure of these examples, with no special cases like "that lay in
;the house" or "that Jack built."
;
;Project:
;Scoring Poker Hands
;The idea of this project is to invent a procedure poker–value that works like this:
;> (poker–value '(h4 s4 c6 s6 c4))
;(FULL HOUSE – FOURS OVER SIXES)
;> (poker–value '(h7 s3 c5 c4 d6))
;(SEVEN–HIGH STRAIGHT)
;> (poker–value '(dq d10 dj da dk))
;(ROYAL FLUSH – DIAMONDS)
;> (poker–value '(da d6 d3 c9 h6))
;(PAIR OF SIXES)
;As you can see, we are representing cards and hands just as in the Bridge project, except that poker hands have only
;five cards.*
;Here are the various kinds of poker hands, in decreasing order of value:
;• Royal flush: ten, jack, queen, king, and ace, all of the same suit
;• Straight flush: five cards of sequential rank, all of the same suit
;• Four of a kind: four cards of the same rank
;• Full house: three cards of the same rank, and two of a second rank
;• Flush: five cards of the same suit, not sequential rank
;• Straight: five cards of sequential rank, not all of the same suit
;• Three of a kind: three cards of the same rank, no other matches
;• Two pair: two pairs of cards, of two different ranks
;• Pair: two cards of the same rank, no other matches
;• Nothing: none of the above
;An ace can be the lowest card of a straight (ace, 2, 3, 4, 5) or the highest card of a straight (ten, jack, queen, king, ace),
;but a straight can't ''wrap around"; a hand with queen, king, ace, 2, 3 would be worthless (unless it's a flush).
;Notice that most of the hand categories are either entirely about the ranks of the cards (pairs, straight, full house, etc.)
;or entirely about the suits (flush). It's a good idea to begin your program by separating the rank information and the
;suit information. To check for a straight flush or royal flush, you'll have to consider both kinds of information.
;In what form do you want the suit information? Really, all you need is a true or false value indicating whether or not
;the hand is a flush, because there aren't any poker categories like "three of one suit and two of another."
;What about ranks? There are two kinds of hand categories involving ranks: the ones about equal ranks (pairs, full
;house) and the ones about sequential ranks (straight). You might therefore want the rank information in two forms. A
;sentence containing all of the ranks in the hand, in sorted order, will make it easier to find a straight. (You still have to
;be careful about aces.)
;For the equal-rank categories, what you want is some data structure that will let you ask questions like "are there three
;cards of the same rank in this hand?" We ended up using a representation like this:
;> (compute–ranks '(q 3 4 3 4))
;(ONE Q TWO 3 TWO 4)
;One slightly tricky aspect of this solution is that we spelled out the numbers of cards, one to four, instead of using
;the more obvious (1 Q 2 3 2 4). The reason, as you can probably tell just by looking at the latter version, is that
;it would lead to confusion between the names of the ranks, most of which are digits, and the numbers of occurrences,
;which are also digits. More specifically, by spelling out the numbers of occurrences, we can use member? to ask
;easily if there is a three-of-a-kind rank in the hand.
;You may find it easier to begin by writing a version that returns only the name of a category, such as
;three of a kind, and only after you get that to work, revise it to give more specific results such as
;three sixes.
;Page 247
;Extra Work for Hotshots
;In some versions of poker, each player gets seven cards and can choose any five of the seven to make a hand. How
;would it change your program if the argument were a sentence of seven cards? (For example, in five-card poker there
;is only one possible category for a hand, but in seven-card you have to pick the best category that can be made from
;your cards.) Fix your program so that it works for both five-card and seven-card hands.
;Another possible modification to the program is to allow for playing with "wild" cards. If you play with "threes wild,"
;it means that if there is a three in your hand you're allowed to pretend it's whatever card you like. For this modification,
;your program will require a second argument indicating which cards are wild. (When you play with wild cards, there's
;the possibility of having five of a kind. This beats a straight flush.)