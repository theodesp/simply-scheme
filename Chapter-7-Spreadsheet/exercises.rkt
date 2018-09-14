#lang racket
;25.1  The "magic numbers" 26 and 30 (and some numbers derived from them) appear many times in the text of this program. It's easy to imagine wanting more rows or columns.
;
;Create global variables total-cols and total-rows with values 26 and 30 respectively. Then modify the spreadsheet program to refer to these variables rather than to the numbers 26 and 30 directly. When you're done, redefine total-rows to be 40 and see if it works.
;
;25.2  Suggest a way to notate columns beyond z. What procedures would have to change to accommodate this?
;
;25.3  Modify the program so that the spreadsheet array is kept as a single vector of 780 elements, instead of a vector of 30 vectors of 26 vectors. What procedures do you have to change to make this work? (It shouldn't be very many.)
;
;25.4  The procedures get-function and get-command are almost identical in structure; both look for an argument in an association list. They differ, however, in their handling of the situation in which the argument is not present in the list. Why?
;
;25.5  The reason we had to include the word id in each cell ID was so we would be able to distinguish a list representing a cell ID from a list of some other kind in an expression. Another way to distinguish cell IDs would be to represent them as vectors, since vectors do not otherwise appear within expressions. Change the implementation of cell IDs from three-element lists to two-element vectors:
;
;> (make-id 4 2)
;#(4 2)
;Make sure the rest of the program still works.
;
;25.6  The put command can be used to label a cell by using a quoted word as the "formula." How does that work? For example, how is such a formula translated into an expression? How is that expression evaluated? What if the labeled cell has children?
;
;25.7  Add commands to move the "window" of cells displayed on the screen without changing the selected cell. (There are a lot of possible user interfaces for this feature; pick anything reasonable.)
;
;25.8  Modify the put command so that after doing its work it prints
;
;14 cells modified
;(but, of course, using the actual number of cells modified instead of 14). This number may not be the entire length of a row or column because put doesn't change an existing formula in a cell when you ask it to set an entire row or column.
;
;25.9  Modify the program so that each column remembers the number of digits that should be displayed after the decimal point (currently always 2). Add a command to set this value for a specified column. And, of course, modify print-screen to use this information.
;
;25.10  Add an undo command, which causes the effect of the previous command to be nullified. That is, if the previous command was a cell selection command, undo will return to the previously selected cell. If the previous command was a put, undo will re-put the previous expressions in every affected cell. You don't need to undo load or exit commands. To do this, you'll need to modify the way the other commands work.
;
;25.11  Add an accumulate procedure that can be used as a function in formulas. Instead of specifying a sequence of cells explicitly, in a formula like
;
;(put (+ c2 c3 c4 c5 c6 c7) c10)
;we want to be able to say
;
;(put (accumulate + c2 c7) c10)
;In general, the two cell names should be taken as corners of a rectangle, all of whose cells should be included, so these two commands are equivalent:
;
;(put (accumulate * a3 c5) d7)
;(put (* a3 b3 c3 a4 b4 c4 a5 b5 c5) d7)
;Modify pin-down to convert the accumulate form into the corresponding spelled-out form.
;
;25.12  Add variable-width columns to the spreadsheet. There should be a command to set the print width of a column. This may mean that the spreadsheet can display more or fewer than six columns.