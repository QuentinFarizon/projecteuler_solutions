-module(exo20).

-compile(export_all).
-import(digits, [mul/2]).


exo20() -> lists:sum(lists:foldl(fun(X, Result) -> digits:mul(Result, X) end, [1], lists:map(fun digits:integer_to_digits/1, lists:seq(1,100)))).


