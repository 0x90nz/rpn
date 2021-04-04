#include <iostream>
#include <stack>
#include <map>
#include <string>
#include <functional>
#include <sstream>

void apply(std::string op, std::stack<int>& stack)
{
    if (stack.size() < 2)
        return;

    int b = stack.top();
    stack.pop();
    int a = stack.top();
    stack.pop();

    if (op == "+") {
        stack.push(a + b);
    } else if (op == "-") {
        stack.push(a - b);
    } else if (op == "*") {
        stack.push(a * b);
    } else if (op == "/") {
        stack.push(a / b);
    }
}

bool is_op(std::string op)
{
    return op == "+" || op == "-" || op == "*" || op == "/";
}

void eval_line(std::stack<int>& stack, std::string line)
{
    std::istringstream iss(line);
    std::string token;
    while (iss >> token) {
        if (is_op(token)) {
            apply(token, stack);
        } else {
            try {
                stack.push(std::stoi(token));
            } catch (std::invalid_argument& ex) {
                std::cout << "Invalid number or operator" << std::endl;
                return;
            }
        }
    }
    std::cout << stack.top() << std::endl;
    stack.pop();
}

int main()
{
    std::stack<int> stack;
    std::string line;

    while (true) {
        std::getline(std::cin, line);
        if (line == "#")
            break;

        eval_line(stack, line);
    }
}