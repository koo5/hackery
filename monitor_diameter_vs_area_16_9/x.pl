:- [library(clpr)].

tv(Diag,Area,W,H) :- {
	Diag * Diag = W * W + H * H,
	W = H * 16 / 9, Area = W * H, H>0
	}.

print_tv(D, Area, W, H) :-
	tv(D, Area, W, H),
	Am is Area * 2.54 * 2.54 / 10000,
	Wcm is W * 2.54,
	Hcm is H * 2.54,
	format('diag(inch):~1f~t~20+ area(m): ~5f~t~20+ W(cm): ~1f~t~20+ H(cm): ~1f~n', [D, Am, Wcm, Hcm]).


:- forall(between(1, 200, W), print_tv(D,_,W,_)).
