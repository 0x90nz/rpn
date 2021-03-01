       identification division.
       program-id. rpn.

       data division.
           working-storage section.
      *    Working storage for input processing
           01 ws-line pic X(256).
           01 ws-command.
               05 ws-command-item pic x(32) occurs 8 times.

      *    Working storage for the stack
           01 ws-stack.
               05 ws-stack-item pic 9(8) occurs 32 times.
               05 ws-stack-ptr pic 9(2) value 32.

      *    Working storage for calculations
           01 ws-value-a pic 9(8).
           01 ws-value-b pic 9(8).
           01 ws-value-res pic 9(8).

      *    For dump
           01 ws-dump-index pic 9(3).

       procedure division.
           perform get-input until ws-line = "quit" or ws-line = "q".
           stop run.

           get-input.
                  display "> " with no advancing.
                  accept ws-line.

                  if ws-line = "+"
                      perform stack-pop
                      add ws-value-a to ws-value-b
                           giving ws-value-res
                      display ws-value-res
                      perform stack-push
                  else if ws-line = "-"
                      perform stack-pop
                      subtract ws-value-b from ws-value-a
                           giving ws-value-res
                      display ws-value-res
                      perform stack-push
                  else if ws-line = "*"
                      perform stack-pop
                      multiply ws-value-a by ws-value-b
                           giving ws-value-res
                      display ws-value-res
                      perform stack-push
                  else if ws-line = "/"
                      perform stack-pop
                      divide ws-value-b by ws-value-a
                           giving ws-value-res
                      display ws-value-res
                      perform stack-push
                  else if ws-line = "."
                      perform stack-dump
                  else
                      move ws-line to ws-value-res
                      perform stack-push
                  end-if.

           stack-pop.
                  add 1 to ws-stack-ptr.
                  move ws-stack-item(ws-stack-ptr) to ws-value-a.
                  add 1 to ws-stack-ptr.
                  move ws-stack-item(ws-stack-ptr) to ws-value-b.

           stack-push.
                  move ws-value-res to ws-stack-item(ws-stack-ptr).
                  subtract 1 from ws-stack-ptr.

           stack-dump.
                   move 32 to ws-dump-index.
                   perform until ws-dump-index = ws-stack-ptr
                       display ws-stack-item(ws-dump-index)
                       subtract 1 from ws-dump-index
                   end-perform.
