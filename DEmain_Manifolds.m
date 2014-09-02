%-------------------------------------------------------------%
%                                                             %
%         PROBLEMA DE LOCALIZA��O DE MANIFOLDS (DE)           %
%                                                             %
%-------------------------------------------------------------%

clear all
format compact
D=20;                      % Dimens�es do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espa�o de busca (x e y m�nimo)
Xmax=500;                  % Espa�o de busca (x e y m�ximo)
MaxFES=D*10000*1;          % N�mero M�ximo de Avalia��es
pop_size=40;               % Tamanho da popula��o
iter_max=MaxFES/pop_size;  % Numero m�ximo de gera��es
tolerancia=1e-4;
runs=1;                    % N�mero de execu��es
fhd=str2func('Func_Manifolds'); % Chama a fun��o objetivo -> ou fhd=@Func_Manifolds

disp('N�mero M�ximo de Gera��es'); iter_max

for r=1:runs
        r
        [fotimo,xotimo]= DE_Func_Manifolds(fhd,D,pop_size,iter_max,Xmin,Xmax,tolerancia);
        xbest(r,:)=xotimo;     % Vetor X �timo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=fotimo;     % Vetor Y �timo por funcao - Matriz (Num.Rodadas x 1) 
        fotimo                 % Imprime Y (m�nimo encontrado) para cada rodada
end
    f_mean=mean(fbest(r,:));   % M�dia dos Y de todas as rodadas
    fbest

