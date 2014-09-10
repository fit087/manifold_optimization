function [vol_aco]=Func_Manifolds(manifold_matriz)

% Fun��o recebe uma matriz [Dimensions X Popsize]
% Retorna Matriz [1 x Popsize]
% Dimensions = N�mero de manifolds x 2 , ou M x 2
% Ordenada de forma (x1,y1,x2,y2,x3,y3,...,xm,ym)

    %*************************************************************%
    %****** PAR�METROS DE ENTRADA - INPUTS DO PROBLEMA ***********%
    %*************************************************************%

    R=30; % Dist�ncia m�xima para conex�o entre um po�o e um manifold

    % Caracteristicas das tubula��es
    % LINHA             Di�metro	Espessura	Are Transversal 
    % Po�o-Manifold      d_pm          e_pm       A_pm
    % Man.-Terra         d_mt          e_mt       A_mt

    d_pm=10.75;                                           % Di�metro da linha po�o - manifold em polegadas
    e_pm=0.625;                                           % Espessura da linha po�o - manifold em polegadas
    A_pm=(0.0254^2)*pi()*(d_pm^2-(d_pm-2*e_pm)^2)/4;      % �rea da se��o transversal da linha po�o - manifold em metros quardados

    d_mt=22.00;                                           % Di�metro da linha manifold - terra em polegadas
    e_mt=0.500;                                           % Espessura da linha manifold - terra em polegadas
    A_mt=(0.0254^2)*pi()*(d_mt^2-(d_mt-2*e_mt)^2)/4;      % �rea da se��o transversal da linha manifold - terra em metros quardados

    % Inicializa��o da matriz de coordenadas dos po�os
    % xywell[nrodepo�os,2D]

    P=20; % N�mero de po�os = 20
    M=10; % N�mero de manifolds = 10

    xywell=[138.7505033     0.99463512
            187.1555503     25.74283704
            197.3126214     36.61867037
            145.329228      -52.87040263
            178.2210815     125.2542484
            97.24245585     -41.17651608
            177.130317      -5.49643968
            175.1681896     -1.8057
            202.4921726     46.06266583
            152.4825506     25.43214552
            223.4416512     280.0970049
            235.506172      252.5044576
            234.6356171     258.6769892
            262.6111327     315.198455
            -107.1417218	-353.6711314
            -95.56131273	-335.7198188
            -110.4007283	-349.5300591
            -94.5333125     -197.6429402
            -104.7952728	-350.7133326
            -105.8726551	-346.9953196];

    % inicializa��o do vetor coordenada do sumidouro (ponto de chegada em
    % terra)
    xyorigin=[0 0];

    %-------------------------------------------------------------%
    %                                                             %
    %         C�LCULO DA FUN��O VOLUME DE A�O TOTAL               %
    %                                                             %
    %-------------------------------------------------------------%
    
    [Dim,PopSize]=size(manifold_matriz); % N�mero de linhas (Dim) e colunas (PopSize) da matriz recebida pela fun��o
    
for k=1:PopSize     % LOOP PARA C�LCULO DO VOLUME DE A�O DE CADA INDIV�DUO (coluna) DA MATRIZ RECEBIDA PELA FUN��O
    
    % MATRIZ COM AS POSI��ES X Y DOS MANIFOLDS PARA CADA INDIV�DUO
    
    xymanifold=manifold_matriz(:,k);     % Gera matriz 1x20 (x,y dos manifolds) do k-�simo indiv�duo da populacao
    xymanifold=reshape(xymanifold,2,[]); % formata em uma matriz 2x10
    xymanifold=transpose(xymanifold);    % formata em uma matriz 10x2

    %-------------------------------------------------------------%
    %         Dist�ncia entre po�os e manifolds                   %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N� PO�OS X N� DE MANIFOLDS) COM AS DIST�NCIAS ENTRE PO�OS E
    % MANIFOLDS

    for i=1:P
        for j=1:M
            Distancia_Poco_Manifold(i,j)=sqrt((xywell(i,1)-xymanifold(j,1))^2+(xywell(i,2)-xymanifold(j,2))^2);
        end
    end
    Distancia_Poco_Manifold;

    %-------------------------------------------------------------%
    %         Matriz de conex�o entre po�os e manifolds           %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N� PO�OS X N� DE MANIFOLDS) DE CONEX�ES ENTRE PO�O E MANIFOLD

    Conexao_Poco_Manifold=zeros(P,M);
    for i=1:P
        for j=1:M
            if isequal(Distancia_Poco_Manifold(i,j), min(Distancia_Poco_Manifold(i,:)))
               Conexao_Poco_Manifold(i,j)=1;
            end
         end
    end
    Conexao_Poco_Manifold;

    %-------------------------------------------------------------%
    % Matriz de penaliza��o das conex�es que violam a restri��o R %
    %-------------------------------------------------------------%

    % MATRIZ P X 1 DE PENALIZA��O DE CONEX�ES QUE VIOLAM O RAIO M�XIMO R

    Penalizacao_Poco_Manifold=zeros(P,1);
    for i=1:P
        if min(Distancia_Poco_Manifold(i,:))>R
               Penalizacao_Poco_Manifold(i,1)=sum(Distancia_Poco_Manifold(i,:))*10;
        end
    end
    Penalizacao_Poco_Manifold;


    %-------------------------------------------------------------%
    %   Matriz de dist�ncia entre po�os e manifolds conectados    %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N� PO�OS X N� DE MANIFOLDS) de dist�ncia entre po�os e
    % manifolds conectados

    Distancia_Conexoes_Poco_Manifold=zeros(P,M);
    for i=1:P
        for j=1:M
            if Conexao_Poco_Manifold(i,j) == 1
               Distancia_Conexoes_Poco_Manifold(i,j)=Distancia_Poco_Manifold(i,j);
            else
               Distancia_Conexoes_Poco_Manifold(i,j)=0;
            end
         end
    end
    Distancia_Conexoes_Poco_Manifold;


    %-------------------------------------------------------------%
    %         Dist�ncia entre manifolds e terra                   %
    %-------------------------------------------------------------%

    % MATRIZ 1 X N COM AS DIST�NCIAS ENTRE MANIFOLDS E TERRA

    for j=1:M
        Distancia_Manifold_Terra(1,j)=sqrt((xyorigin(1,1)-xymanifold(j,1))^2+(xyorigin(1,2)-xymanifold(j,2))^2);
    end
    Distancia_Manifold_Terra;

    %-------------------------------------------------------------%
    %        Volume de a�o utilizado                              %
    %-------------------------------------------------------------%

    Distancia_Total_Manifolds_Pocos = sum(sum(Distancia_Conexoes_Poco_Manifold))*1000; % DIst�ncia total de conex�es em metros
    Distancia_Total_Manifolds_Terra =sum(sum(Distancia_Manifold_Terra))*1000;          % DIst�ncia total de conex�es em metros
    Distancia_Total_Penalizacoes =sum(sum(Penalizacao_Poco_Manifold))*1000;            % DIst�ncia total de conex�es em metros
    Vol_Aco_Total_Manifolds_Pocos = Distancia_Total_Manifolds_Pocos*A_pm;              % Volume total das conex�es manifold e po�os em metros c�bicos
    Vol_Aco_Total_Manifolds_Terra =Distancia_Total_Manifolds_Terra*A_mt;               % Volume total das conex�es manifold e terra em metros c�bicos
    Vol_Aco_Total_Penalizacoes =Distancia_Total_Penalizacoes*A_pm;                     % Volume total de penaliza��es em metros c�bicos
    Vol_Aco_Total=Vol_Aco_Total_Manifolds_Pocos+Vol_Aco_Total_Manifolds_Terra+Vol_Aco_Total_Penalizacoes;      % Volume total em metros c�bicos


    vol_aco(1,k)= Vol_Aco_Total;  % Matriz do tipo (1,PopSize)
    
end