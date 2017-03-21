-module(exo25).

-compile(export_all).
-import(digits, [mul/2]).


exo25() ->exo25([1],[1], 2).

exo25(A, B, NbTerm) ->
  C = digits:add(A,B),
  if length(C) >= 1000
    -> NbTerm+1;
    true -> exo25(B, C, NbTerm+1)
  end.