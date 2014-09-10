%-------------------------------------------------------------%
%         PROBLEMA DE LOCALIZA��O DE MANIFOLDS (DE)           %
%-------------------------------------------------------------%
clear all
format compact
D=20;                      % Dimens�es do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espa�o de busca (x e y m�nimo)
Xmax=500;                  % Espa�o de busca (x e y m�ximo)
MaxFES=D*10000*5;          % N�mero M�ximo de Avalia��es (n�mero alto para deixar parar pela toler�ncia)
pop_size=40;               % Tamanho da popula��o
iter_max=MaxFES/pop_size;  % Numero m�ximo de gera��es
tolerancia=1e-3;           % Toler�ncia em unidade de metro c�bico
runs=1;                    % N�mero de execu��es
fhd=str2func('Func_Manifolds'); % Chama a fun��o objetivo -> ou fhd=@Func_Manifolds

disp(['N�mero M�ximo de Gera��es: ',num2str(iter_max)]);

% otimos(runs,MaxFES)=0;
% medias(runs,MaxFES)=0;

% otimos(runs,MaxFES)=0;
% medias(runs,MaxFES)=0;

for r=1:runs
        disp(['Rodada N�mero ',num2str(r)]);
        [fotimo,xotimo,Avaliacoes,otimo,media]= DE_Func_Manifolds(fhd,D,pop_size,iter_max,Xmin,Xmax,tolerancia);
        xbest(r,:)=xotimo;     % Vetor X �timo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=fotimo;     % Vetor Y �timo por rodada - Matriz (Num.Rodadas x 1) 
        NAval(r,:)=Avaliacoes; % Vetor N avaliacoes por rodada - Matriz (Num.Rodadas x 1)
%         otimos(r,:)=otimo;
%         medias(r,:)=media;
end
    f_mean=mean(fbest(r,:));   % M�dia dos Y de todas as rodadas


plot(otimo, 'r')
hold on
plot(media)

% plot(otimo(2000:end), 'r');hold on;plot(media(2000:end))