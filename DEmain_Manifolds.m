%-------------------------------------------------------------%
%                                                             %
%         PROBLEMA DE LOCALIZAÇÃO DE MANIFOLDS (DE)           %
%                                                             %
%-------------------------------------------------------------%

clear all
format compact
D=20;                      % Dimensões do problema = 20 (10 manifolds com X e Y)
Xmin=-500;                 % Espaço de busca (x e y mínimo)
Xmax=500;                  % Espaço de busca (x e y máximo)
MaxFES=D*10000*1;          % Número Máximo de Avaliações
pop_size=40;               % Tamanho da população
iter_max=MaxFES/pop_size;  % Numero máximo de gerações
tolerancia=1e-4;
runs=1;                    % Número de execuções
fhd=str2func('Func_Manifolds'); % Chama a função objetivo -> ou fhd=@Func_Manifolds

disp('Número Máximo de Gerações'); iter_max

for r=1:runs
        r
        [fotimo,xotimo]= DE_Func_Manifolds(fhd,D,pop_size,iter_max,Xmin,Xmax,tolerancia);
        xbest(r,:)=xotimo;     % Vetor X ótimo por rodada - Matriz (Num.Rodadas x Dimensao X) 
        fbest(r,:)=fotimo;     % Vetor Y ótimo por funcao - Matriz (Num.Rodadas x 1) 
        fotimo                 % Imprime Y (mínimo encontrado) para cada rodada
end
    f_mean=mean(fbest(r,:));   % Média dos Y de todas as rodadas
    fbest

