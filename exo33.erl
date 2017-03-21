-module(exo33).

-import(digits, [add/2]).
-compile(export_all).


exo33() -> [{U,V} || U <- two_digits_number(), V <- two_digits_number(), U < V, test_fraction({U,V})].

two_digits_number() ->
  [10*X+Y || X <- lists:seq(1,9), Y <- lists:seq(1,9) ].

test_fraction({Numerator, Denominator}) ->
  {SimplifiedNum, SimplifiedDen} = simplify_fraction(Numerator, Denominator),
  SimplifiedDen /= 0 andalso Numerator /= SimplifiedNum andalso Numerator / Denominator == SimplifiedNum / SimplifiedDen.

simplify_fraction(Numerator, Denominator) ->
  Num = digits:integer_to_digits(Numerator),
  Den = digits:integer_to_digits(Denominator),
  {digits:digits_to_integer(lists:subtract(Num, Den)), digits:digits_to_integer(lists:subtract(Den, Num))}.

