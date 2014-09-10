%-------------------------------------------------------------%
%         PROBLEMA DE LOCALIZAÇÃO DE MANIFOLDS (DE)           %
%-------------------------------------------------------------%
clear all
format compact
D=20;                      % Dimensões do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espaço de busca (x e y mínimo)
Xmax=500;                  % Espaço de busca (x e y máximo)
MaxFES=D*10000*5;          % Número Máximo de Avaliações (número alto para deixar parar pela tolerância)
pop_size=40;               % Tamanho da população
iter_max=MaxFES/pop_size;  % Numero máximo de gerações
tolerancia=1e-3;           % Tolerância em unidade de metro cúbico
runs=1;                    % Número de execuções
fhd=str2func('Func_Manifolds'); % Chama a função objetivo -> ou fhd=@Func_Manifolds

disp(['Número Máximo de Gerações: ',num2str(iter_max)]);

% otimos(runs,MaxFES)=0;
% medias(runs,MaxFES)=0;

% otimos(runs,MaxFES)=0;
% medias(runs,MaxFES)=0;

for r=1:runs
        disp(['Rodada Número ',num2str(r)]);
        [fotimo,xotimo,Avaliacoes,otimo,media]= DE_Func_Manifolds(fhd,D,pop_size,iter_max,Xmin,Xmax,tolerancia);
        xbest(r,:)=xotimo;     % Vetor X ótimo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=fotimo;     % Vetor Y ótimo por rodada - Matriz (Num.Rodadas x 1) 
        NAval(r,:)=Avaliacoes; % Vetor N avaliacoes por rodada - Matriz (Num.Rodadas x 1)
%         otimos(r,:)=otimo;
%         medias(r,:)=media;
end
    f_mean=mean(fbest(r,:));   % Média dos Y de todas as rodadas


plot(otimo, 'r')
hold on
plot(media)

% plot(otimo(2000:end), 'r');hold on;plot(media(2000:end))