% length(Xs, N):-
% リストXsにはN個の要素がある。
length([], 0).
length([X|Xs], s(N)):-legnth(Xs, N).
