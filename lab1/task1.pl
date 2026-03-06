my_length([], 0).
my_length([_|Tail], Length) :-
    my_length(Tail, TailLength),
    Length is TailLength + 1.

my_member(Element, [Element|_]).
my_member(Element, [_|Tail]) :-
    my_member(Element, Tail).

my_append([], List, List).
my_append([Head|Tail], List, [Head|ResultTail]) :-
    my_append(Tail, List, ResultTail).

my_remove(Element, [Element|Tail], Tail).
my_remove(Element, [Head|Tail], [Head|ResultTail]) :-
    my_remove(Element, Tail, ResultTail).

my_permute([], []).
my_permute(List, [Head|Tail]) :-
    my_remove(Head, List, Rest),
    my_permute(Rest, Tail).

my_sublist(Sublist, List) :-
    my_append(_, Rest, List),
    my_append(Sublist, _, Rest).

insert_at_std(Element, Position, List, Result) :-
    integer(Position),
    Position >= 1,
    PrefixLength is Position - 1,
    length(Prefix, PrefixLength),
    append(Prefix, Suffix, List),
    append(Prefix, [Element|Suffix], Result).

insert_at_no_std(Element, Position, List, Result) :-
    integer(Position),
    Position >= 1,
    insert_at_no_std_(Element, Position, List, Result).

insert_at_no_std_(Element, 1, List, [Element|List]).
insert_at_no_std_(Element, Position, [Head|Tail], [Head|ResultTail]) :-
    Position > 1,
    NextPosition is Position - 1,
    insert_at_no_std_(Element, NextPosition, Tail, ResultTail).

is_geometric_std(List) :-
    length(List, Length),
    (   Length =< 1
    ->  true
    ;   List = [First, Second|Rest],
        (   First =:= 0
        ->  Second =:= 0,
            all_zero_std(Rest)
        ;   Ratio is Second / First,
            check_ratio_std([Second|Rest], Ratio)
        )
    ).

all_zero_std(List) :-
    maplist(=(0), List).

check_ratio_std([_], _).
check_ratio_std([Current, Next|Tail], Ratio) :-
    Next =:= Current * Ratio,
    check_ratio_std([Next|Tail], Ratio).

is_geometric_no_std([]).
is_geometric_no_std([_]).
is_geometric_no_std([First, Second|Rest]) :-
    (   First =:= 0
    ->  Second =:= 0,
        all_zero_no_std(Rest)
    ;   Ratio is Second / First,
        check_ratio_no_std(Second, Rest, Ratio)
    ).

all_zero_no_std([]).
all_zero_no_std([0|Tail]) :-
    all_zero_no_std(Tail).

check_ratio_no_std(_, [], _).
check_ratio_no_std(Current, [Next|Tail], Ratio) :-
    Next =:= Current * Ratio,
    check_ratio_no_std(Next, Tail, Ratio).

insert_and_check_gp_std(Element, Position, List, NewList, IsGeometric) :-
    insert_at_std(Element, Position, List, NewList),
    (   is_geometric_std(NewList)
    ->  IsGeometric = yes
    ;   IsGeometric = no
    ).

insert_and_check_gp_no_std(Element, Position, List, NewList, IsGeometric) :-
    insert_at_no_std(Element, Position, List, NewList),
    (   is_geometric_no_std(NewList)
    ->  IsGeometric = yes
    ;   IsGeometric = no
    ).
