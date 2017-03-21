-module(exo92).

-compile(export_all).

exo92() -> length(lists:filter(fun finishing_number/1, lists:seq(1,10000000))).

finishing_number(1) ->
  false;
finishing_number(89) ->
  true;
finishing_number(X) ->
  finishing_number(lists:foldl(fun(Digit, Sum) -> Digit*Digit + Sum end, 0, digits:integer_to_digits(X))).

