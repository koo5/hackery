import sys
from sympy import *

for d in range(1, 500) :
	D,W,H,Aimp,Am = symbols('d w h, Aimp, Am', nonnegative=True)
	r = solve((Eq(D*D, W*W+H*H).subs(D,d), Eq(W/H, 16/9),Eq(Aimp,W*H),Eq(Am, Aimp * (2.54**2)/10000)))
	rr = r[0]
	print('d:', d, ' A[m]:', rr[Am])
	