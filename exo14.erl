-module(exo14).

-compile(export_all).

exo14() ->
  Caching = array:set(1, 0, array:new()),
  collatz(1, 0, 1, lists:seq(2, 1000000), Caching).

collatz(_, _, _, [], Caching) ->
  max(array:sparse_to_orddict(Caching));
collatz(CurrentNumber, CurrentLength, Number, [H|T], Caching) ->
  case array:get(CurrentNumber, Caching) of
    undefined when CurrentNumber rem 2 == 0 ->
      collatz(CurrentNumber div 2, CurrentLength+1, Number, [H|T], Caching);
    undefined ->
      collatz(3*CurrentNumber+1, CurrentLength+1, Number, [H|T], Caching);
    Length ->
%%        io:fwrite(integer_to_list(CurrentNumber)++"~n"),
      collatz(H, 0, H, T, array:set(Number, CurrentLength+Length, Caching))
  end.

max(CachingArray) ->
  max(CachingArray, 0, 0).
max([], _, Max_index) -> Max_index;
max([{Index, Nb}|T], Max, Max_index) ->
%%   io:fwrite(integer_tolist(nb)++"~n"),
%%   {index, nb} = H,
  case Nb>Max of
    true -> max(T, Nb, Index);
    false -> max(T, Max, Max_index)
  end.