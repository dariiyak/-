% dfs(+Start, +Goal, -Path)
% Depth-first search in a graph defined by edge/2 facts.
% Path is a list of nodes from Start to Goal.
dfs(Start, Goal, Path) :-
    dfs(Start, Goal, [Start], RevPath),
    reverse_list(RevPath, Path).

% dfs(+Current, +Goal, +Visited, -Path)
dfs(Goal, Goal, Path, Path).
dfs(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs(Next, Goal, [Next|Visited], Path).

% reverse_list(+List, -Reversed)
reverse_list(List, Reversed) :-
    reverse_list(List, [], Reversed).
reverse_list([], Acc, Acc).
reverse_list([H|T], Acc, Reversed) :-
    reverse_list(T, [H|Acc], Reversed).
