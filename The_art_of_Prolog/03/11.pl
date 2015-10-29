% list(Xs):-
% Xsはリストである。
list([]).
list([X|Xs]):-list(Xs).
