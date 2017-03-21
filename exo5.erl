-module(exo5).
-compile([export_all]).

-import(exo1, [primes/1]).



%% Pb 5
%% exo5_naif() -> divisible(20, lists:seq(1,20)).
%%
%% divisible(Number, List) ->
%%   case divisible_by(Number, List) of
%%     true -> Number;
%%     false -> divisible(Number+1, List)
%%   end.
%%
%% divisible_by(Number, [H|T]) when Number rem H == 0 -> divisible_by(Number, T);
%% divisible_by(_, []) -> true;
%% divisible_by(_, _) -> false.


%% Pb 5

exo5() ->
  lists:foldl(fun(X, Prod) -> X * Prod end, 1, clean_list(lists:seq(1, 20), [])).

divide_by(Number, _) when Number == 1 -> true;
divide_by(Number, [H|T]) when Number rem H == 0 -> divide_by(Number div H, T);
divide_by(Number, [_|T]) -> divide_by(Number, T);
divide_by(Number, []) -> {false, Number}.

clean_list([], Numbers) -> Numbers;
clean_list([H|T], CleanedNumbers) ->
  case divide_by(H, CleanedNumbers) of
    true -> clean_list(T, CleanedNumbers);
    {false, Number} -> clean_list(T, lists:append(primes(Number), CleanedNumbers))
  end.
