-module(exo17).

-compile(export_all).

exo17() -> Map = #{
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"},
  lists:sum(
    lists:map(
      fun length/1,
      lists:map(
        fun (X) -> Word = write_word(X, Map),
        io:fwrite(Word++"~n"), Word end,
        lists:seq(1,5)
      )
    )
  ).

write_word(Number, _) when Number == 1000 ->
  "onethousand";
write_word(Number, Map) when Number >= 100 ->
  write_word(Number div 100, Map) ++
  "hundred" ++
  if Number rem 100 > 0
    -> "and" ++ write_word(Number rem 100, Map);
    true -> ""
  end;
write_word(Number, Map) ->
  case maps:find(Number, Map) of
    {ok, Word} -> Word;
    error -> write_word((Number div 10)*10, Map) ++ write_word(Number rem 10, Map)
  end.


