% resistor(R, Node1, Node2):-
%    RはNode1とNode2の間にある抵抗である。
resistor(r1, power, n1).
resistor(r2, power, n2).

% transistor(T, Gate, Source, Drain):-
% Tは、ゲートがGate、ソースがSource、ドレインがDrainで
% あるようなトランジスタである。
transistor(t1, n2, ground, n1).
transistor(t2, n3, n4, n2).
transistor(t3, n5, ground, n4).

% inverter(I, Input, Output):-
% IはInputをOutputに反転するインバータである。
inverter(inv(T,R), Input, Output):-
    transistor(T, Input, ground, Output),
    resistor(R, power, Output).

% nand_gate(Nand, Input1, Input2, Output):-
% Nandは、Input1とInput2の論理NANDをOutputとする
% ゲートである。
nand_gate(nand(T1,T2,R), Input1, Input2, Output):-
    transistor(T1, Input1, X, Output),
    transistor(T2, Input2, ground, X),
    resistor(R, power, Output).

% and_gate(And, Input1, Input2, Output):-
% Andは、Input1とInput2の論理ANDをOutputとする
% ゲートである。
and_gate(and(N,I), Input1, Input2, Output):-
    nand_gate(N, Input1, Input2, X),
    inverter(I, X, Output).
