import java.util.*;
import java.util.function.BiFunction;

class Calc {
    static Map<String, BiFunction<Integer, Integer, Integer>> operators = new HashMap<>() {{
        put("+", (a, b) -> a + b);
        put("-", (a, b) -> a - b);
        put("*", (a, b) -> a * b);
        put("/", (a, b) -> a / b);
    }};

    private static void eval(String op, Deque<Integer> stack) {
        Integer b = stack.pop();
        Integer a = stack.pop();
        stack.push(operators.get(op).apply(a, b));
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        Deque<Integer> stack = new ArrayDeque<>(512);

        while (true) {
            String line = s.nextLine();
            if (line.equals("#"))
                break;

            String[] components = line.split("\\s");
            for (String component : components) {
                try {
                    stack.push(Integer.parseInt(component));
                } catch (NumberFormatException e) {
                    if (operators.containsKey(component)) {
                        eval(component, stack);
                    } else {
                        System.out.println("Invalid number or operator");
                    }
                }
            }
            System.out.println(stack.pop());
        }
    }
}