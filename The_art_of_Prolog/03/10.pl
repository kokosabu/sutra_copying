% gcd(X, Y, Z):-
% Zは自然数X、Yの最大公約数である。
gcd(X, Y, Gcd):-mod(X, Y, Z), gcd(Y, Z, Gcd).
gcd(X, 0, X):-X > 0.
