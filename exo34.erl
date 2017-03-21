-module(exo34).

-import(digits, [addition/2]).
-compile(export_all).

exo34() -> lists:sum(lists:filter(fun is_factorial_digits/1, lists:seq(3,1000000))).

is_factorial_digits(Number) ->
  factorial_digits(exo13:integer_to_digits(Number), 0) == Number.
factorial_digits([], Sum) ->
  Sum;
factorial_digits([H|T], Sum) ->
  factorial_digits(T, Sum + fac(H)).


fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).



