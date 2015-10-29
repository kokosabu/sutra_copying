edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(d, e).
edge(f, g).

% connected(Node1, Node2):-
% Node1は、関係edge/2で定義されたグラフ中で
% Node2に連結されている。
connected(Node, Node).
connected(Node1, Node2):-
    edge(Node1, Link),
    connected(Link, Node2).
