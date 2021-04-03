import operator

operators = {'+': operator.add, '-': operator.sub, '*': operator.mul, '/': operator.floordiv}

while True:
    stack = []
    tokens = input().split()

    if tokens[0] == '#':
        break

    for token in tokens:
        try:
            stack.append(int(token))
        except ValueError:
            if token in operators:
                b = stack.pop()
                a = stack.pop()
                stack.append(operators[token](a, b))
            else:
                print('Invalid number or operator')

    print(stack.pop())