start([w,w,w,e,b,b,b]).
goal([b,b,b,e,w,w,w]).

empty(e).

within(State, I) :-
    length(State, L),
    I >= 1,
    I =< L.

replace_nth1(1, [_|T], X, [X|T]).
replace_nth1(N, [H|T], X, [H|R]) :-
    N > 1,
    N1 is N - 1,
    replace_nth1(N1, T, X, R).

swap_positions(List, I, J, New) :-
    nth1(I, List, Ei),
    nth1(J, List, Ej),
    replace_nth1(I, List, Ej, Temp),
    replace_nth1(J, Temp, Ei, New).

adjacent(To, From) :-
    From is To - 1.
adjacent(To, From) :-
    From is To + 1.

jump(To, From, State) :-
    From is To - 2,
    Mid is To - 1,
    nth1(Mid, State, MidElem),
    empty(E),
    MidElem \= E.
jump(To, From, State) :-
    From is To + 2,
    Mid is To + 1,
    nth1(Mid, State, MidElem),
    empty(E),
    MidElem \= E.

move(State, Next, move(From, To)) :-
    empty(E),
    nth1(To, State, E),
    ( adjacent(To, From) ; jump(To, From, State) ),
    within(State, From),
    nth1(From, State, Ball),
    Ball \= E,
    swap_positions(State, From, To, Next).

dfs_path(Path, Moves) :-
    start(S), goal(G),
    dfs(S, G, [S], [], RevStates, RevMoves),
    reverse(RevStates, Path),
    reverse(RevMoves, Moves).

dfs(S, G, States, Moves, States, Moves) :-
    S = G.

dfs(S, G, States, Moves, FinalStates, FinalMoves) :-
    move(S, Next, Move),
    \+ member(Next, States),
    dfs(Next, G, [Next|States], [Move|Moves], FinalStates, FinalMoves).

bfs_path(Path, Moves) :-
    start(S), goal(G),
    bfs_queue([node([S], [])], G, Path, Moves).

bfs_queue([node(States, Moves)|_], G, Path, MovesOut) :-
    States = [Current|_],
    Current = G,
    reverse(States, Path),
    reverse(Moves, MovesOut).

bfs_queue([node(States, Moves)|Rest], G, Path, MovesOut) :-
    States = [Current|_],
    findall(node([Next|States], [Move|Moves]),
        ( move(Current, Next, Move),
          \+ member(Next, States)
        ),
        Children),
    append(Rest, Children, NewQueue),
    bfs_queue(NewQueue, G, Path, MovesOut).

ids_path(Path, Moves) :-
    start(S), goal(G),
    between(0, 50, Depth),
    dls(S, G, [S], [], Depth, RevStates, RevMoves),
    reverse(RevStates, Path),
    reverse(RevMoves, Moves).

dls(S, G, States, Moves, _, States, Moves) :-
    S = G.

dls(S, G, States, Moves, Depth, FinalStates, FinalMoves) :-
    Depth > 0,
    move(S, Next, Move),
    \+ member(Next, States),
    Depth1 is Depth - 1,
    dls(Next, G, [Next|States], [Move|Moves], Depth1, FinalStates, FinalMoves).

% Helper predicates for defense/demo: return only solution length.
dfs_len(L) :-
    dfs_path(_, Moves),
    length(Moves, L).

bfs_len(L) :-
    bfs_path(_, Moves),
    length(Moves, L).

ids_len(L) :-
    ids_path(_, Moves),
    length(Moves, L).
