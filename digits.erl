-module(digits).

-compile(export_all).

add(NumberA, NumberB) ->
  add(lists:reverse(NumberA), lists:reverse(NumberB), [], 0).
add([], [], Result, 0) ->
  Result;
add([], [], Result, 1) ->
  [1|Result];
add([], [H|T], Result, Remainder) ->
  add([], T, [(H+Remainder) rem 10|Result], (H+Remainder) div 10);
add([H|T], [], Result, Remainder) ->
  add(T, [], [(H+Remainder) rem 10|Result], (H+Remainder) div 10);
add([HA|TA], [HB|TB], Result, Remainder) ->
  add(TA, TB, [(HA+HB+Remainder) rem 10|Result], (HA+HB+Remainder) div 10).

%% OK : digits:mul([2,1], [1,4]).
%% KO : digits:mul([2,1], [1,5]).

mul(NumberA, NumberB) when length(NumberA) > length(NumberB) ->
  mul(NumberB, NumberA);
mul(NumberA, NumberB) ->
  mul(lists:reverse(NumberB), lists:reverse(NumberA), [], 0).
mul(_, [], Result, _) ->
  Result;
mul(NumberA, [H|T], Result, Indice) ->
  mul(NumberA, T, add(Result, mul_by_digit(lists:reverse(NumberA), H)++padd_zero(Indice)), Indice+1).


mul_by_digit(Number, Digit) ->
  mul_by_digit(lists:reverse(Number), Digit, [], 0, 0).
mul_by_digit([], _, Result, _, Remainder) ->
  integer_to_digits(Remainder)++Result;
mul_by_digit([H|T], Digit, Result, Indice, Remainder) ->
  New = Remainder+H*Digit,
  mul_by_digit(T, Digit, [New rem 10|Result], Indice+1, New div 10).

padd_zero(0) ->
  [];
padd_zero(N) ->
  [0|padd_zero(N-1)].

integer_to_digits(Number) ->
  integer_to_digits(Number, []).
integer_to_digits(0, List) ->
  List;
integer_to_digits(Number, List) ->
  integer_to_digits(Number div 10, [Number rem 10] ++ List).

digits_to_integer(Digits) ->
  digits_to_integer(Digits, 0).
digits_to_integer([], Integer) ->
  round(Integer);
digits_to_integer([H|T], Integer) ->
  digits_to_integer(T, Integer + H * math:pow(10, length(T))).
