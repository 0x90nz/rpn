(require "asdf")

(defun stack-bi-op (op stack)
    (let ((b (car stack))
          (a (car (cdr stack))))
            (cons (apply op (list a b)) (cdr (cdr stack)))))

(defun eval-token (token stack)
    (cond
        ((equal token "+") (stack-bi-op #'+ stack))
        ((equal token "-") (stack-bi-op #'- stack))
        ((equal token "*") (stack-bi-op #'* stack))
        ((equal token "/") (stack-bi-op #'/ stack))
        (t (cons (parse-integer token) stack))))

(defun process-line (line)
    (let ((tokens (uiop:split-string line :separator " "))
          (stack '()))
            (loop for token in tokens
                do (setq stack (eval-token token stack)))
            (format t "~a~%" (car stack))))

(defun main ()
    (loop
        (let ((input (read-line)))
            (if (equal "#" input)
                (exit))
            (process-line input))))

(main)