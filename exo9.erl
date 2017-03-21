-module(exo9).

-compile(export_all).

exo9() -> exo9(1,0,0, 1000).

exo9(A, B, C, Sum) when A*A + B*B == C*C, A+B+C == Sum -> A*B*C;
exo9(A, B, C, Sum) when A == Sum -> exo9(0, B+1, C, Sum);
exo9(_, B, C, Sum) when B == Sum -> exo9(0, 0, C+1, Sum);
exo9(_, _, C, Sum) when C == Sum -> error;
exo9(A, B, C, Sum) -> exo9(A+1, B, C, Sum).

