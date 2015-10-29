% append(Xs, Ys, XsYs):-
% XsYsはリストXs、Ysを連結した結果である。
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]):-append(Xs, Ys, Zs).
