clear all;
S = [2 0 3 0;0 25 0 30;3 0 91 0;0 32 0 661];
Rinf = cholinc(sparse(S),'inf');
Rinf=full(Rinf)
Rinf'* Rinf
