-module(exo21).

-compile(export_all).


exo21() -> lists:sum(lists:filtermap(fun sum_amicable/1, [{X,Y} || X <- lists:seq(2,9998,2), Y <- lists:seq(X+2,10000,2)])).

sum_amicable({X, Y}) ->
  case are_amicable(X,Y) of
    true -> io:fwrite(integer_to_list(X)++"   "++integer_to_list(Y)++"~n"), {true, X+Y};
    false -> false
  end.

are_amicable(X,Y) -> lists:sum(proper_divisors(X)) == Y andalso lists:sum(proper_divisors(Y)) == X.

proper_divisors(Number) -> [Div || Div <- lists:seq(1,round(Number/2 +1)), Number rem Div == 0].
