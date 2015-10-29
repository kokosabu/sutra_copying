% prefix(Prefix, List):-
% PrefixはリストListの接頭部である。
prefix([], Ys).
prefix([X|Xs], [X|Ys]):-prefix(Xs, Ys).

% suffix(Suffix, List):-
% SuffixはリストListの接尾部である。
suffix(Xs, Ys).
suffix(Xs, [Y|Ys]):-suffix(Xs, Ys).
