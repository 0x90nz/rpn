import { createInterface } from 'readline';
import { stdin, stdout, exit } from 'process';

const operators = {
    '+': (a, b) => a + b,
    '-': (a, b) => a - b,
    '*': (a, b) => a * b,
    '/': (a, b) => a / b,
};

const con = createInterface({
    input: stdin,
    output: stdout
});

con.setPrompt('');
con.on('line', text => {
    if (text === '#')
        exit(0);

    const res = text.split(/\s+/).reduce((stack, newVal) => {
        if (newVal in operators) {
            const b = stack.pop();
            const a = stack.pop();
            stack.push(operators[newVal](a, b));
        } else {
            const intVal = parseInt(newVal);
            if (intVal !== NaN) {
                stack.push(intVal);
            } else {
                console.log('Invalid operator or operand');
            }
        }
        return stack;
    }, []);
    console.log(res[0]);
});
