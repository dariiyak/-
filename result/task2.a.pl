% sum_list(+List, -Sum)
% True if Sum is the sum of numeric elements in List.
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.
