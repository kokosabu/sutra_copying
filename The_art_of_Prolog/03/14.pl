% sublist(Sub, List):-
% SubはリストListの部分リストである。

% a:接頭部の接尾部
sublist(Xs, Ys):-prefix(Ps, Ys), suffix(Xs, Ps).

% b:接尾部の接頭部
sublist(Xs, Ys):-prefix(Xs, Ss), suffix(Ss, Ys).

% c:部分リストの再帰定義
sublist(Xs, Ys):-prefix(Xs, Ys).
sublist(Xs, [Y|Ys]):-sublist(Xs, Ys).

% appendを用いた、接頭部の接尾部
sublist(Xs, AsXsBs):-
    append(As, XsBs, AsXsBs), append(Xs, Bs, XsBs).

% appendを用いた、接尾部の接頭部
sublist(Xs, AsXsBs):-
    append(AsXs, Bs, AsXsBs), append(XAs, Xs, AsXs).
