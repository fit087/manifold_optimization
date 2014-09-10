%-------------------------------------------------------------%
%         PROBLEMA DE LOCALIZA��O DE MANIFOLDS (PSO)          %
%-------------------------------------------------------------%
clear all
format compact
D=20;                      % Dimens�es do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espa�o de busca (x e y m�nimo)
Xmax=500;                  % Espa�o de busca (x e y m�ximo)
MaxFES=D*10000*1;          % N�mero M�ximo de Avalia��es (n�mero alto para deixar parar pela toler�ncia)
pop_size=40;               % Tamanho da popula��o
iter_max=MaxFES/pop_size;  % Numero m�ximo de gera��es
tolerancia=1e-3;           % Toler�ncia em unidade de metro c�bico
runs=51;                    % N�mero de execu��es
fhd=str2func('Func_Manifolds'); % Chama a fun��o objetivo -> ou fhd=@Func_Manifolds

disp(['N�mero M�ximo de Gera��es: ',num2str(iter_max)]);

for r=1:runs
        disp(['Rodada N�mero ',num2str(r)]);
        [gbest,gbestval]= PSO_func(fhd,D,pop_size,iter_max,Xmin,Xmax);
        xbest(r,:)=gbest;        % Vetor X �timo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=gbestval;     % Vetor Y �timo por rodada - Matriz (Num.Rodadas x 1) 
        disp(['M�nimo da Rodada ',num2str(r),' = ',num2str(fbest(r,1))]);
end
    f_mean=mean(fbest(r,:));   % M�dia dos Y de todas as rodadas