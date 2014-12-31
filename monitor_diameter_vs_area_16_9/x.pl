:- [library(clpr)].
solve(D,R) :- {
	pow(D, 2)=(pow(X,2)+pow(X,2)),
	R=Y*X,
	X/Y=16/9,
	X>0}.

graph([D,R]) :-
	between(0, 10, D),
	solve(D,R).

%solve(R, 30).