%-------------------------------------------------------------%
%         PROBLEMA DE LOCALIZAÇÃO DE MANIFOLDS (PSO)          %
%-------------------------------------------------------------%
clear all
format compact
D=20;                      % Dimensões do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espaço de busca (x e y mínimo)
Xmax=500;                  % Espaço de busca (x e y máximo)
MaxFES=D*10000*1;          % Número Máximo de Avaliações (número alto para deixar parar pela tolerância)
pop_size=40;               % Tamanho da população
iter_max=MaxFES/pop_size;  % Numero máximo de gerações
tolerancia=1e-3;           % Tolerância em unidade de metro cúbico
runs=51;                    % Número de execuções
fhd=str2func('Func_Manifolds'); % Chama a função objetivo -> ou fhd=@Func_Manifolds

disp(['Número Máximo de Gerações: ',num2str(iter_max)]);

for r=1:runs
        disp(['Rodada Número ',num2str(r)]);
        [gbest,gbestval]= PSO_func(fhd,D,pop_size,iter_max,Xmin,Xmax);
        xbest(r,:)=gbest;        % Vetor X ótimo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=gbestval;     % Vetor Y ótimo por rodada - Matriz (Num.Rodadas x 1) 
        disp(['Mínimo da Rodada ',num2str(r),' = ',num2str(fbest(r,1))]);
end
    f_mean=mean(fbest(r,:));   % Média dos Y de todas as rodadas