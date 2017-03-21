-module(exo55).

-import(exo13, [addition/2]).
-compile(export_all).

count_lychrels() -> count_lychrels(lists:seq(0,10000), 0).

count_lychrels([], NbLychrels) ->
  NbLychrels;
count_lychrels([H|T], NbLychrels) ->
  count_lychrels(T, NbLychrels + is_lychrel(H, 0)).

is_lychrel(_, 50) -> 1;
is_lychrel(N, NbIter) ->
  Next = N + reverse(N),
  case is_palindrome(Next) of
    true -> 0;
    false -> is_lychrel(Next, NbIter + 1)
  end.

reverse(N) -> exo13:digits_to_integer(lists:reverse(exo13:integer_to_digits(N))).

is_palindrome(N) -> reverse(N) == N.
