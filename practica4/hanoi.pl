hanoi(1,From,To,_) :-
    format("Mover disco 1 de ~w a ~w~n",[From,To]).
hanoi(N,From,To,Via) :-
    N > 1,
    N1 is N - 1,
    hanoi(N1,From,Via,To),
    format("Mover disco ~w de ~w a ~w~n",[N,From,To]),
    hanoi(N1,Via,To,From).