-module(exo1).

-compile([export_all]).

%% Pb 1
exo1()  ->
  lists:sum([X || X <- lists:seq(1,999), (X rem 5==0) or (X rem 3==0)]).



%% Pb 2
exo2() ->
  fib_sum(1,1,0).

fib_sum(_, N, Sum) when N >= 4000000 -> Sum;
fib_sum(M, N, Sum) when (N rem 2 == 0) -> fib_sum(N, M+N, Sum + N);
fib_sum(M, N, Sum) -> fib_sum(N, M+N, Sum).



%% Pb 3
exo3() ->
  max_prime_factor(1450, 2).

max_prime_factor(Number, Divisor) when Number rem Divisor == 0 -> max_prime_factor(Number/Divisor, 2);
max_prime_factor(Number, Divisor) -> max_prime_factor(Number, Divisor+1).

max_primes(Number) ->
  lists:max(primes(Number)).

primes(Number) -> primes(Number, [], [], 2).
primes(1, ListDivisor, _, _) -> ListDivisor;
primes(Number, ListDivisor, ListPrimes, Divisor) ->
  case is_prime(ListPrimes, Divisor) of
    false -> primes(Number, ListDivisor, ListPrimes, Divisor+1);
    true when Number rem Divisor == 0 -> primes(Number div Divisor, [Divisor|ListDivisor], [Divisor|ListPrimes], Divisor);
    true -> primes(Number, ListDivisor, [Divisor|ListPrimes], Divisor+1)
  end.

is_prime([], _) -> true;
is_prime([P|_], Divisor) when Divisor == P -> true;
is_prime([P|_], Divisor) when Divisor rem P == 0 -> false;
is_prime([_|ListPrimes], Divisor) -> is_prime(ListPrimes, Divisor).



%% Pb 4
exo4() -> palindrome(0, 0, 0).

palindrome(X, Y, Result) when X == 1000, Y == 999 -> Result;
palindrome(X, Y, Result) when (X == 1000) -> palindrome(0, Y+1, Result);
palindrome(X, Y, Result) ->
  case is_palindrome(X*Y) of
    true -> palindrome(X+1, Y, max(X*Y, Result));
    false -> palindrome(X+1, Y, Result)
  end.

is_palindrome(Int) when is_integer(Int) -> is_palindrome(integer_to_list(Int));
is_palindrome([]) -> true;
is_palindrome(List) when length(List) == 1 -> true;
is_palindrome(List) -> lists:nth(1, List) == lists:nth(length(List), List) andalso is_palindrome(lists:sublist(List, 2, length(List) -2)).

