#!/usr/bin/env escript

% we need to use compile mode because I want the nice `fun fn/arity` syntax
% within escript
-mode(compile).

parse_input(Token, Stack) ->
	try
		Num = list_to_integer(Token),
		[Num | Stack]
	catch error:badarg ->
		[Y, X | Rest] = Stack,
		case Token of
			"+" -> [X+Y | Rest];
			"-" -> [X-Y | Rest];
			"*" -> [X*Y | Rest];
			"/" -> [X/Y | Rest]
		end
	end.

process_line("#") -> done;
process_line(Input) ->
	Tokens = string:tokens(Input, [$\s]),
	[Head | _] = lists:foldl(fun parse_input/2, [], Tokens),
	{ok, Head}.

repl() ->
	Input = string:strip(io:get_line("> "), right, $\n),
	case process_line(Input) of
		{ok, Result} -> io:format("~p~n", [Result]), repl();
		done -> ok
	end.

main(_) -> repl().

