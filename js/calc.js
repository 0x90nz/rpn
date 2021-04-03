const readline = require('readline');
const process = require('process');

const operators = {
    '+': (a, b) => a + b,
    '-': (a, b) => a - b,
    '*': (a, b) => a * b,
    '/': (a, b) => a / b,
};

const con = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

con.setPrompt('');
con.on('line', text => {
    if (text === '#')
        process.exit(0);

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
