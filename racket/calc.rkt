#lang racket
(module calc racket)

(define (stack-bi-op op stack)
  (let ([b (car stack)] [a (car (cdr stack))])
    (cons (op a b) (cdr (cdr stack)))))

(define (conv-and-push token stack)
  (let ([val (string->number token)])
    (if val (cons val stack) stack)))

(define (eval-token token stack)
  (cond [(string=? "+" token) (stack-bi-op + stack)]
	[(string=? "-" token) (stack-bi-op - stack)]
	[(string=? "*" token) (stack-bi-op * stack)]
	[(string=? "/" token) (stack-bi-op / stack)]
	[else (conv-and-push token stack)])) 

(define (process-line line)
  (let ([tokens (string-split line)])
    (displayln (car (foldl eval-token '[] tokens)))))

(define (main)
  (define input (read-line))
  (if (equal? "#" input)
      (exit)
      ((process-line input) (main))))

(main)

