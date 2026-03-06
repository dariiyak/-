:- use_module(library(lists)).

solve(Assignments) :-
    Roles = [dancer, artist, singer, writer],
    permutation(Roles, [RV, RP, RL, RS]),
    Assignments = [role(voronov, RV), role(pavlov, RP), role(levitsky, RL), role(sakharov, RS)],
    RV \= singer,
    RL \= singer,
    RP \= writer,
    RP \= artist,
    RS \= writer,
    RV \= writer,
    RV \= artist.

solution(Voronov, Pavlov, Levitsky, Sakharov) :-
    solve([role(voronov, Voronov), role(pavlov, Pavlov), role(levitsky, Levitsky), role(sakharov, Sakharov)]).
