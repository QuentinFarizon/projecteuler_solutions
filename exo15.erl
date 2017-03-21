-module(exo15).

-compile(export_all).

exo15() -> route_generator(20, 20, 0).

route_generator2(0, 0, Current, Result) ->
  [Current|Result];
route_generator2(0, Nb_B, Current, Result) ->
  route_generator2(0, Nb_B-1, [b|Current], Result);
route_generator2(Nb_T, 0, Current, Result) ->
  route_generator2(Nb_T-1, 0, [t|Current], Result);
route_generator2(Nb_T, Nb_B, Current, Result) ->
  route_generator2(Nb_T-1, Nb_B, [t|Current], Result) ++
  route_generator2(Nb_T, Nb_B-1, [b|Current], Result).

route_generator(0, 0, NbRoads) ->
  NbRoads+1;
route_generator(0, _, NbRoads) ->
  NbRoads+1;
route_generator(_, 0, NbRoads) ->
  NbRoads+1;
 route_generator(Nb_T, Nb_B, NbRoads) when Nb_B == Nb_T ->
  2*route_generator(Nb_T-1, Nb_B, NbRoads);
 route_generator(Nb_T, Nb_B, NbRoads) ->
  route_generator(Nb_T-1, Nb_B, NbRoads) +
  route_generator(Nb_T, Nb_B-1, NbRoads).