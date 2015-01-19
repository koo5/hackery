:- [library(clpr)].

solve(D,R, X, Y) :- {
	pow(D, 2)=(pow(X,2)+pow(X,2)),
	R=Y*X,
	X/Y=16/9,
	X>0}.

vals(D, Dcm, R, X, Y) :-
	solve(D,R, X, Y),
	Dcm is D * 2.54,
	format('D:~2f~t~10+ Dcm: ~2f~t~15+ area: ~2f~t~15+ W: ~2f~t~15+ H: ~2f~n', [D, Dcm, R, X, Y]).

:- forall(between(1, 100, D), vals(D,_,_,_,_)).