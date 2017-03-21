-module(exo10).

-compile(export_all).
-import(exo7, [is_prime/2]).

exo10() -> lists:sum(eratosthene_sieve(2000000)).

eratosthene_sieve(Max) -> eratosthene_sieve(Max, [], lists:seq(2,Max)).

clean_multiples(_, [], CleanedList) -> lists:reverse(CleanedList);
clean_multiples(Number, [Current|ListNumbers], CleanedList) ->
  case Current rem Number of
    0 -> clean_multiples(Number, ListNumbers, CleanedList);
    _ -> clean_multiples(Number, ListNumbers, [Current|CleanedList])
  end.

eratosthene_sieve(_, ListPrimes, []) ->
  lists:reverse(ListPrimes);
eratosthene_sieve(Max, ListPrimes, [Number|ListNumbers]) when Number*Number > Max ->
  lists:append(ListPrimes, [Number|ListNumbers]);
eratosthene_sieve(Max, ListPrimes, [Number|ListNumbers]) ->
  io:fwrite(integer_to_list(length(ListNumbers))++"~n"),
  eratosthene_sieve(Max, [Number|ListPrimes], clean_multiples(Number, ListNumbers, [])).