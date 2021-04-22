use std::io::{self, BufRead};

fn op(operator: &str, stack: &mut Vec<i32>) {
    let b = stack.pop().expect("Stack underflow");
    let a = stack.pop().expect("Stack underflow");
    match operator {
        "+" => stack.push(a + b),
        "-" => stack.push(a - b),
        "*" => stack.push(a * b),
        "/" => stack.push(a / b),
        _ => ()
    }
}

fn main() {
    let stdin = io::stdin();
    let mut stack: Vec<i32> = Vec::new();

    for line in stdin.lock().lines() {
        let contents = line.unwrap();
        if contents == "#" {
            break;
        }

        for token in contents.split_ascii_whitespace() {
            match token.parse::<i32>() {
                Ok(i) => stack.push(i),
                Err(_) => op(&token, &mut stack)
            }
        }

        println!("{}", stack.pop().expect("Stack underflow"))
    }
}
