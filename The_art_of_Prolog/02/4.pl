lecture(Lecturer, Course):-
    course(Course, Time, Lecturer, Location).

duration(Course, Length):-
    course(Course, time(Day,Start,Finish), Lecturer, Location),
    plus(Start, Length, Finish).

teaches(Lecturer, Day):-
    course(Course, time(Day,Start,Finish), Lecturer, Location).

occupied(Room, Day, Time):-
    course(Course, time(Day,Start,Finish), Lecturer,
           location(Building,Room)),
    Start =< Time, Time =< Finish.
