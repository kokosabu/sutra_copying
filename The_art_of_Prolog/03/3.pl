% plus(X, Y, Z):-
% X、Y、Zは自然数であり、ZはXとYの和である。
plus(0, X, X):-natural_number(X).
plus(s(X), Y, s(Z)):-plus(X, Y, Z).

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).
