% ackermann(X, Y, A):-
% Aは自然数X、YのAckermann関数値である。
ackermann(0, N, s(N)).
ackermann(s(M), 0, Val):-ackermann(M, s(0), Val).
ackermann(s(M), s(N), Val):-
    ackermann(s(M), N, Val1), ackermann(M, Val1, Val).
