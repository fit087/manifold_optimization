clear all
format compact

% MATRIZ DE ENTRADA DIM X NUMERO POPULACAO
% FUNCAO RECEBIDA DO TIPO 1 X NUMERO POPULACAO (VOL ACO EM METROS CUBICOS)

D=20;
NP=50;
Pop = rand(D,NP)
fhd=str2func('Func_Manifolds'); % ou fhd=@Manifolds
%[y1, y2, ...] = feval(fhandle, x1, ..., xn)
Aco = feval(fhd,Pop)