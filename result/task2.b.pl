% reverse_list(+List, -Reversed)
% True if Reversed is List in reverse order.
reverse_list(List, Reversed) :-
    reverse_list(List, [], Reversed).

% reverse_list(+List, +Acc, -Reversed)
reverse_list([], Acc, Acc).
reverse_list([H|T], Acc, Reversed) :-
    reverse_list(T, [H|Acc], Reversed).
