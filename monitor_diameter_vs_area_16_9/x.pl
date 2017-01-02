:- [library(clpr)].

tv(Diag,Area,W,H) :- {
	pow(Diag, 2) = pow(W,2) + pow(H,2),
	W = H * 16 / 9,
	Area = W * H,
	W>0,
	H>0
	}.

print_tv(D, Area, W, H) :-
	tv(D, Area, W, H),
	Am is Area * 2.54 / 10000,
	Wcm is W * 2.54,
	Hcm is H * 2.54,
	format('diag(inch):~0f~t~25+ area(m): ~5f~t~25+ W(cm): ~2f~t~25+ H(cm): ~2f~n', [D, Am, Wcm, Hcm]).


:- forall(between(1, 200, D), print_tv(D,_,_,_)).
