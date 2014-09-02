%  **** DIFFERENTIAL EVOLUTION ****  %
%       (EVOLU��O DIFERENCIAL)
%  ********************************  %
function [f,X] = DE_Func_Manifolds(fhd,Dimension,Pop_Size,Max_Gen,VRmin,VRmax)  %adicionar par�metros de entrada

%function [gbest,gbestval,fitcount]= PSO_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,varargin)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
%**********************************%
%******* PAR�METROS DE SA�DA ******%
%**********************************%
% f - optimal fitness
% X - optimal solution

%**********************************%
%****** PAR�METROS DE ENTRADA *****%
%**********************************%
%D = 2;      % Dimens�o do Problema
D=Dimension;
%NP = 6;     % Tamanho da Popula��o
NP=Pop_Size;
F = 0.6;    % Constante de Diferencia��o
CR = 0.9;   % Constante de Cruzamento
%GEN = 1000; % N�mero de Gera��es
GEN =Max_Gen;
%L = -10;    % Restri��o de Contorno Inferior
L=VRmin;
%H = 10;     % Restri��o de Contorno Superior
H=VRmax;
% ********************************%
% ** INICIALIZA��O DE VARI�VEIS **%
% ********************************%
X = zeros(D,1);    % Popula��o de Julgamento
Pop = zeros(D,NP); % Popula��o
Fit = zeros(1,NP); % Avalia��o do melhor indiv�vuo da popula��o
iBest = 1;         % �ndice do melhor indiv�duo da popula��o
r = zeros(3,1);    % �ndices selecionados aleat�riamente [r(0), r(1) e r(2)]

%********************************%
%****** POPULA��O INICIAL *******%
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
for g = 1:GEN % Loop na gera��o
    for j = 1:NP % Loop nos indiv�duos da popula��o
        
        %**********************************************
        % Escolhe tr�s indiv�duos da popula��o, segundo os seguintes crit�rios:
        %    1. Indiv�duos mutuamente distintos entre si;
        %    2. Indiv�duo diferente do indiv�duo da popula��o atual.
        
        % Escolha do 1� indiv�duo
        r(1) = floor(rand()* NP) + 1;
        while r(1)==j
            r(1) = floor(rand()* NP) + 1;
        end
        % Escolha do 2� indiv�duo
        r(2) = floor(rand()* NP) + 1;
        while (r(2)==r(1))||(r(2)==j)
            r(2) = floor(rand()* NP) + 1;
        end
        % Escolha do 3� indiv�duo
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
                iBest = j ; % update the best�s index
            end
        end

    end
    rd=mod(g,100);
    if rd==0
        disp(['Fitness ', num2str(Fit(iBest)),'   Gera��o ',num2str(g)]);
    end
end
% ************* %
% ** RESULTS ** %
% ************* %
f = Fit(iBest);
X = Pop(:,iBest);
 disp(['Melhor Fitness ',num2str(f)]);

% ============================================== %

