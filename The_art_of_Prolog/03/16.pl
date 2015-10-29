% reverse(List, Tsil):-
% TsilはリストListを反転した結果である。

% a:素直なreverse
reverse([], []).
reverse([X|Xs], Zs):-reverse(Xs, Ys), append(Ys, [X], Zs).

% b:累算器によるreverse
reverse(Xs, Ys):-reverse(Xs, [], Ys).
reverse([X|Xs], Acc, Ys):-reverse(Xs, [X|Acc], Ys).
reverse([], Ys, Ys).
