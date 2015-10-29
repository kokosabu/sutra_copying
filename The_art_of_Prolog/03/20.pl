sort(Xs, Ys):-permutation(Xs, Ys), ordered(Ys).

permutation(Xs, [Z|Zs]):-select(Z, Xs, Ys), permutation(Ys, Zs).
permutation([], []).

ordered([X]).
ordered([X, Y|Ys]):-X =< Y, ordered([Y|Ys]).
