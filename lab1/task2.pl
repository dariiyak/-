:- ensure_loaded('one.pl').

sum_and_count([], 0, 0).
sum_and_count([Head|Tail], Sum, Count) :-
    sum_and_count(Tail, TailSum, TailCount),
    Sum is TailSum + Head,
    Count is TailCount + 1.

failed_student(Name) :-
    grade(Name, _, 2).

subject_average(SubjectCode, Average) :-
    findall(GradeValue, grade(_, SubjectCode, GradeValue), Grades),
    Grades \= [],
    sum_and_count(Grades, Sum, Count),
    Average is Sum / Count.

print_subject_averages :-
    subject(SubjectCode, SubjectName),
    subject_average(SubjectCode, Average),
    format('~w (~w): ~2f~n', [SubjectName, SubjectCode, Average]),
    fail.
print_subject_averages.

group_failed_count(Group, Count) :-
    (   setof(Name, (student(Group, Name), failed_student(Name)), FailedStudents)
    ->  length(FailedStudents, Count)
    ;   Count = 0
    ).

print_group_failed_counts :-
    setof(Group, Name^student(Group, Name), Groups),
    member(Group, Groups),
    group_failed_count(Group, Count),
    format('Group ~w: ~w~n', [Group, Count]),
    fail.
print_group_failed_counts.

subject_failed_count(SubjectCode, Count) :-
    (   setof(Name, grade(Name, SubjectCode, 2), FailedStudents)
    ->  length(FailedStudents, Count)
    ;   Count = 0
    ).

print_subject_failed_counts :-
    subject(SubjectCode, SubjectName),
    subject_failed_count(SubjectCode, Count),
    format('~w (~w): ~w~n', [SubjectName, SubjectCode, Count]),
    fail.
print_subject_failed_counts.
