-module(exo96).

-compile(export_all).

exo96() ->
  {ok, Data} = file:read_file("p096_sudoku.txt"),
  List = binary:split(Data, [<<"\n">>], [global]),
  RawGrids = [lists:sublist(List, X+1, 9) || X <- lists:seq(1,length(List),10) ],
  SolvedGrids = lists:map(fun solve/1, lists:map(fun store_grid/1, RawGrids)),
  lists:foldl(fun(SolvedGrid, Sum) -> Sum + maps:get({1,1}, SolvedGrid)*100 + maps:get({2,1}, SolvedGrid)*10 + maps:get({3,1}, SolvedGrid) end, 0, SolvedGrids).

store_grid(RawGrid) ->
  Flattened = lists:flatten(lists:map(fun binary:bin_to_list/1, RawGrid)),
  IndexedStr = lists:zip(lists:seq(1, length(Flattened)), Flattened),
  IndexedNbr = lists:map(fun({Key, Value}) -> {Int, _} = string:to_integer([Value]), {Key, Int} end, IndexedStr),
  maps:from_list(lists:map(fun({Index, Value}) -> {{((Index - 1) rem 9) + 1, ((Index - 1) div 9) +  1}, Value} end, IndexedNbr)).

solve(Grid) ->
  EmptyCells = lists:filter(fun({_, Value}) -> Value == 0 end, maps:to_list(Grid)),
%%   io:fwrite(integer_to_list(length(EmptyCells))++"~n"),
  case EmptyCells of
    [] -> Grid;
    [{{Col, Row}, 0}|_] ->
      case try_available_numbers(available_numbers(Col, Row, Grid), Col, Row, Grid) of
        error -> error;
        SolvedGrid -> SolvedGrid
      end
  end.

try_available_numbers([], _, _, _) ->
  error;
try_available_numbers([H|T], Col, Row, Grid) ->
  UpdatedGrid = maps:update({Col, Row}, H, Grid),
  case solve(UpdatedGrid) of
    error -> try_available_numbers(T, Col, Row, UpdatedGrid);
    SolvedGrid -> SolvedGrid
  end.

extract_row(Row, Grid) ->
  [maps:get({X, Row}, Grid) || X <- lists:seq(1,9)].

extract_col(Col, Grid) ->
  [maps:get({Col, Y}, Grid) || Y <- lists:seq(1,9)].

extract_square(Col, Row, Grid) ->
  [maps:get({X, Y}, Grid) ||
    X <- lists:seq(square_index(Col) + 1, square_index(Col) + 3),
    Y <- lists:seq(square_index(Row) + 1, square_index(Row) + 3)].

available_numbers(Col, Row, Grid) ->
  FilledOnCol = filled_numbers(extract_col(Col, Grid)),
  FilledOnRow = filled_numbers(extract_row(Row, Grid)),
  FilledOnSquare = filled_numbers(extract_square(Col, Row, Grid)),
  Filled = lists:append([FilledOnCol, FilledOnRow, FilledOnSquare]),
  lists:filter(fun(X) -> not lists:member(X, Filled) end, lists:seq(1,9)).

filled_numbers(Numbers) ->
  lists:filter(fun(Number) -> Number /= 0 end, Numbers).

square_index(Pos) ->
  ((Pos - 1) div 3)*3.

solve_grid(Grid) ->
  Grid.
