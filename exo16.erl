-module(exo16).

-import(digits, [addition/2]).
-compile(export_all).

exo16() -> lists:sum(calculate_power_2(1000)).

calculate_power_2(N) ->
  calculate_power_2(N, [1]).
calculate_power_2(0, Result) ->
  Result;
calculate_power_2(N, Result) ->
  calculate_power_2(N-1, multiply_by_2(Result)).

multiply_by_2(Number) -> exo13:addition(Number, Number).
