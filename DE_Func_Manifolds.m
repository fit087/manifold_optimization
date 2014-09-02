%  **** DIFFERENTIAL EVOLUTION ****  %
%       (EVOLUÇÃO DIFERENCIAL)
%  ********************************  %
function [f,X] = DE_Func_Manifolds(fhd,Dimension,Pop_Size,Max_Gen,VRmin,VRmax)  %adicionar parâmetros de entrada

%function [gbest,gbestval,fitcount]= PSO_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,varargin)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
%**********************************%
%******* PARÂMETROS DE SAÍDA ******%
%**********************************%
% f - optimal fitness
% X - optimal solution

%**********************************%
%****** PARÂMETROS DE ENTRADA *****%
%**********************************%
%D = 2;      % Dimensão do Problema
D=Dimension;
%NP = 6;     % Tamanho da População
NP=Pop_Size;
F = 0.6;    % Constante de Diferenciação
CR = 0.9;   % Constante de Cruzamento
%GEN = 1000; % Número de Gerações
GEN =Max_Gen;
%L = -10;    % Restrição de Contorno Inferior
L=VRmin;
%H = 10;     % Restrição de Contorno Superior
H=VRmax;
% ********************************%
% ** INICIALIZAÇÃO DE VARIÁVEIS **%
% ********************************%
X = zeros(D,1);    % População de Julgamento
Pop = zeros(D,NP); % População
Fit = zeros(1,NP); % Avaliação do melhor indivívuo da população
iBest = 1;         % Índice do melhor indivíduo da população
r = zeros(3,1);    % Índices selecionados aleatóriamente [r(0), r(1) e r(2)]

%********************************%
%****** POPULAÇÃO INICIAL *******%
%********************************%
rand('state',sum(100*clock)); %verificar************************
for j = 1:NP % initialize each individual
    Pop(:,j) = L + (H-L)*rand(D,1); % within b.constraints
    
    
    
    %Fit(1,j) = fnc(Pop(:,j)); % and evaluate fitness
    %e=feval(fhd,pos',varargin{:});
    %Fit(1,j) = feval(fhd,Pop(:,j),varargin{:}); % and evaluate fitness
    Fit(1,j) = feval(fhd,Pop(:,j)); 
    
    
end
% ****************** %
% ** OPTIMIZATION ** %
% ****************** %
for g = 1:GEN % Loop na geração
    for j = 1:NP % Loop nos indivíduos da população
        
        %**********************************************
        % Escolhe três indivíduos da população, segundo os seguintes critérios:
        %    1. Indivíduos mutuamente distintos entre si;
        %    2. Indivíduo diferente do indivíduo da população atual.
        
        % Escolha do 1º indivíduo
        r(1) = floor(rand()* NP) + 1;
        while r(1)==j
            r(1) = floor(rand()* NP) + 1;
        end
        % Escolha do 2º indivíduo
        r(2) = floor(rand()* NP) + 1;
        while (r(2)==r(1))||(r(2)==j)
            r(2) = floor(rand()* NP) + 1;
        end
        % Escolha do 3º indivíduo
        r(3) = floor(rand()* NP) + 1;
        while (r(3)==r(2))||(r(3)==r(1))||(r(3)==j)
            r(3) = floor(rand()* NP) + 1;
        end
        %*********************************************
        
        %*********************************************
        % create trial individual
        % in which at least one parameter is changed
        Rnd = floor(rand()*D) + 1;
        for i = 1:D
            if ( rand()<CR ) || ( Rnd==i )
                X(i) = Pop(i,r(3)) +...
                F * (Pop(i,r(1)) - Pop(i,r(2)));
            else
                X(i) = Pop(i,j);
            end
        end
        %*********************************************
        
        % verify boundary constraints
        for i = 1:D
            if (X(i)<L)||(X(i)>H)
                X(i) = L + (H-L)*rand();
            end
        end
        % select the best individual
        % between trial and current ones
        % calculate fitness of trial individual
        
       
        
        
      
       %f = fnc(X);
       % f = feval(fhd,X,varargin{:}); % and evaluate fitness
        f = feval(fhd,X); % and evaluate fitness
        
        
        % if trial is better or equal than current
        if f <= Fit(j)
            Pop(:,j) = X; % replace current by trial
            Fit(j) = f ;
            % if trial is better than the best
            if f <= Fit(iBest)
                iBest = j ; % update the best’s index
            end
        end

    end
    rd=mod(g,100);
    if rd==0
        disp(['Fitness ', num2str(Fit(iBest)),'   Geração ',num2str(g)]);
    end
end
% ************* %
% ** RESULTS ** %
% ************* %
f = Fit(iBest);
X = Pop(:,iBest);
 disp(['Melhor Fitness ',num2str(f)]);

% ============================================== %

