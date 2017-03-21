-module(exo22).

-compile(export_all).


exo22() ->
  {ok, File} = file:open("p022_names.txt", read),
  {ok, Data} = file:read_line(File),
  Names = re:split(Data, "\",\"",[{return, list}]),
  SortedNames = lists:sort(Names),
  IndexedNames = lists:zip(SortedNames, lists:seq(1,length(SortedNames))),
  Scores = lists:map(fun({Name, Index}) -> name_value(Name) * Index end, IndexedNames),
  lists:sum(Scores).

name_value(Name) -> lists:foldl(fun(C, Value) -> C - 64 + Value end, 0, Name).