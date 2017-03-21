-module(exo7).
-compile([export_all]).

exo7() -> exo7([], 2).
exo7([Last|ListPrimes], _) when length([Last|ListPrimes]) == 10001 -> Last;
exo7(ListPrimes, Number) ->
  case is_prime(Number, ListPrimes) of
    true -> exo7([Number|ListPrimes], Number +1);
    false -> exo7(ListPrimes, Number +1)
  end.

%% with Number > max(ListPrimes)
is_prime(1, _) -> false;
is_prime(_, []) -> true;
is_prime(Number, [H|ListPrimes]) when Number rem H == 0 -> is_prime(Number div H, [H|ListPrimes]);
is_prime(Number, [_|ListPrimes]) -> is_prime(Number, ListPrimes).