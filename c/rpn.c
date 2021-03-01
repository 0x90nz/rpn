#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

#define WHITESPACE  " \t\n\r\v\f"

typedef int stack_item_t;

static stack_item_t stack[32];
static int stack_ptr;
static size_t stack_size;

void stack_init()
{
    memset(stack, 0, sizeof(stack));
    stack_size = (sizeof(stack) / sizeof(*stack));
    stack_ptr =  stack_size - 1;
}

void stack_push(stack_item_t item)
{
    stack[stack_ptr] = item;
    stack_ptr--;
}

stack_item_t stack_pop()
{
    return stack[++stack_ptr];
}

size_t stack_used()
{
    return stack_size - (stack_ptr + 1);
}

void stack_dump()
{
    size_t used = stack_used();
    for (size_t i = 0; i < used; i++) {
        printf("%d\n", stack[stack_size - 1 - i]);
    }
}

bool isnumeric(const char* str)
{
    while (*str) {
        if (!isdigit(*str))
            return false;
        str++;
    }
    return true;
}

void process_op(char op)
{
    // No argument ops
    switch (op) {
    case '.':
        stack_dump();
        return;
    }

    // Binary ops
    stack_item_t b = stack_pop();
    stack_item_t a = stack_pop();
    stack_item_t result = 0;
    switch(op) {
    case '+':
        result = a + b;
        break;
    case '-':
        result = a - b;
        break;
    case '/':
        result = a / b;
        break;
    case '*':
        result = a * b;
        break;
    default:
        return;
    }
    stack_push(result);
}

void help()
{
    printf(
        "RPN Calculator\n"
        "Operations:    '+', '-', '/', '*'\n"
        "Dump stack:    '.'\n"
        "Exit:          'q' or 'quit'\n"
        "\nExample: '10 20 + 3 /' will output 10"
    );
}

bool process_term(const char* term)
{
    if (strcmp(term, "quit") == 0 || strcmp(term, "q") == 0) {
        exit(0);
    } else if (strcmp(term, "?") == 0) {
        help();
    } else if (strspn(term, "+-/*.")) {
        process_op(term[0]);
        return true;
    } else if (isnumeric(term)) {
        stack_push(atoi(term));
    } else {
        printf("Error: Invalid. Must be numeric or [+-/*.]\n");
    }

    return false;
}

int main(int argc, char** argv)
{
    printf("RPN Calculator. '?' for help\n");

    char line[256];
    stack_init();

    while (1) {
        printf("> ");
        fgets(line, 256, stdin);
        line[strcspn(line, "\n")] = '\0';

        bool wants_print = false;
        char* term = strtok(line, WHITESPACE);
        while (term) {
            wants_print |= process_term(term);
            term = strtok(NULL, WHITESPACE);
        }

        if (wants_print)
            printf("%d\n", stack[stack_ptr + 1]);
    }
}