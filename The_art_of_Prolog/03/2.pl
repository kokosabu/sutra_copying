% X=<Y:-
% XとYは自然数であり、XはYより小さいか等しい。
0 =< X:-natural_number(X).
s(X) =< s(Y):- X =< Y.

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).
