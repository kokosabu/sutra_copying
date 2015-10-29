% exp(N, X, Y):-
% N、X、Yが自然数のとき、YはXのN乗である。
exp(s(X), 0, 0).
exp(0, s(X), s(0)).
exp(s(N), X, Y):-exp(N, X, Z), times(Z, X, Y).


% times(X, Y, Z):-
% X、Y、Zが自然数のとき、ZはXとYの積である。
times(0, X, 0).
times(s(X), Y, Z):-times(X, Y, W), plus(W, Y, Z).

% plus(X, Y, Z):-
% X、Y、Zは自然数であり、ZはXとYの和である。
plus(0, X, X):-natural_number(X).
plus(s(X), Y, s(Z)):-plus(X, Y, Z).

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).
