% minimum(N1, N2, Min):-
% 自然数N1、N2の最小値はMinである。
minimum(N1, N2, N1):-N1 =< N2.
minimum(N1, N2, N2):-N2 =< N1.


% X=<Y:-
% XとYは自然数であり、XはYより小さいか等しい。
0 =< X:-natural_number(X).
s(X) =< s(Y):- X =< Y.

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).
