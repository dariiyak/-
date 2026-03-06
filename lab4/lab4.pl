an_q(Tokens, X) :-
    phrase(question(X), Tokens).

question(X) --> who_q(X).
question(X) --> what_q(X).
question(X) --> where_q(X).

who_q(X) -->
    who,
    love_verb(F),
    obj_noun(Obj),
    ['?'],
    { X =.. [F, agent(_Y), object(Obj)] }.

what_q(X) -->
    what,
    love_verb(F),
    subject_name(Name),
    ['?'],
    { X =.. [F, agent(Name), object(_Y)] }.

where_q(X) -->
    where,
    lie_verb(F),
    obj_noun(Obj),
    ['?'],
    { X =.. [F, object(Obj), loc(_L)] }.

who --> ['Кто'].
who --> ['кто'].

what --> ['Что'].
what --> ['что'].

where --> ['Где'].
where --> ['где'].

love_verb('любит') --> ['любит'].

lie_verb('лежать') --> ['лежат'].
lie_verb('лежать') --> ['лежит'].

obj_noun('шоколад') --> ['шоколад'].
obj_noun('деньги') --> ['деньги'].

subject_name('Даша') --> ['Даша'].
