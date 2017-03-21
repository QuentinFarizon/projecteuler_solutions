-module(exo65).

-compile(export_all).

exo65() ->true.

reduce_fraction({N,D}) when N div D == 0 -> reduce_fraction()
