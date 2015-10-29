% member(Element, List):-
% ElementはListの要素である。
member(X, [X|Xs]).
member(X, [Y|Ys]):-member(X, Ys).
