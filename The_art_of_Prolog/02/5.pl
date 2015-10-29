% ancestor(Ancestor, Descendant):-
%    AncestorはDescendantの先祖である。
ancestor(Ancestor, Descendant):-
    parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant):-
    parent(Ancestor, Person), ancestor(Person, Descendant).
