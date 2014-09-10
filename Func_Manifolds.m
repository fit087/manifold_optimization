function [vol_aco]=Func_Manifolds(manifold_matriz)

% Função recebe uma matriz [Dimensions X Popsize]
% Retorna Matriz [1 x Popsize]
% Dimensions = Número de manifolds x 2 , ou M x 2
% Ordenada de forma (x1,y1,x2,y2,x3,y3,...,xm,ym)

    %*************************************************************%
    %****** PARÂMETROS DE ENTRADA - INPUTS DO PROBLEMA ***********%
    %*************************************************************%

    R=30; % Distância máxima para conexão entre um poço e um manifold

    % Caracteristicas das tubulações
    % LINHA             Diâmetro	Espessura	Are Transversal 
    % Poço-Manifold      d_pm          e_pm       A_pm
    % Man.-Terra         d_mt          e_mt       A_mt

    d_pm=10.75;                                           % Diâmetro da linha poço - manifold em polegadas
    e_pm=0.625;                                           % Espessura da linha poço - manifold em polegadas
    A_pm=(0.0254^2)*pi()*(d_pm^2-(d_pm-2*e_pm)^2)/4;      % Área da seção transversal da linha poço - manifold em metros quardados

    d_mt=22.00;                                           % Diâmetro da linha manifold - terra em polegadas
    e_mt=0.500;                                           % Espessura da linha manifold - terra em polegadas
    A_mt=(0.0254^2)*pi()*(d_mt^2-(d_mt-2*e_mt)^2)/4;      % Área da seção transversal da linha manifold - terra em metros quardados

    % Inicialização da matriz de coordenadas dos poços
    % xywell[nrodepoços,2D]

    P=20; % Número de poços = 20
    M=10; % Número de manifolds = 10

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

    % inicialização do vetor coordenada do sumidouro (ponto de chegada em
    % terra)
    xyorigin=[0 0];

    %-------------------------------------------------------------%
    %                                                             %
    %         CÁLCULO DA FUNÇÃO VOLUME DE AÇO TOTAL               %
    %                                                             %
    %-------------------------------------------------------------%
    
    [Dim,PopSize]=size(manifold_matriz); % Número de linhas (Dim) e colunas (PopSize) da matriz recebida pela função
    
for k=1:PopSize     % LOOP PARA CÁLCULO DO VOLUME DE AÇO DE CADA INDIVÍDUO (coluna) DA MATRIZ RECEBIDA PELA FUNÇÃO
    
    % MATRIZ COM AS POSIÇÕES X Y DOS MANIFOLDS PARA CADA INDIVÍDUO
    
    xymanifold=manifold_matriz(:,k);     % Gera matriz 1x20 (x,y dos manifolds) do k-ésimo indivíduo da populacao
    xymanifold=reshape(xymanifold,2,[]); % formata em uma matriz 2x10
    xymanifold=transpose(xymanifold);    % formata em uma matriz 10x2

    %-------------------------------------------------------------%
    %         Distância entre poços e manifolds                   %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N° POÇOS X N° DE MANIFOLDS) COM AS DISTÂNCIAS ENTRE POÇOS E
    % MANIFOLDS

    for i=1:P
        for j=1:M
            Distancia_Poco_Manifold(i,j)=sqrt((xywell(i,1)-xymanifold(j,1))^2+(xywell(i,2)-xymanifold(j,2))^2);
        end
    end
    Distancia_Poco_Manifold;

    %-------------------------------------------------------------%
    %         Matriz de conexão entre poços e manifolds           %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N° POÇOS X N° DE MANIFOLDS) DE CONEXÕES ENTRE POÇO E MANIFOLD

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
    % Matriz de penalização das conexões que violam a restrição R %
    %-------------------------------------------------------------%

    % MATRIZ P X 1 DE PENALIZAÇÃO DE CONEXÕES QUE VIOLAM O RAIO MÁXIMO R

    Penalizacao_Poco_Manifold=zeros(P,1);
    for i=1:P
        if min(Distancia_Poco_Manifold(i,:))>R
               Penalizacao_Poco_Manifold(i,1)=sum(Distancia_Poco_Manifold(i,:))*10;
        end
    end
    Penalizacao_Poco_Manifold;


    %-------------------------------------------------------------%
    %   Matriz de distância entre poços e manifolds conectados    %
    %-------------------------------------------------------------%

    % MATRIZ P X N (N° POÇOS X N° DE MANIFOLDS) de distância entre poços e
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
    %         Distância entre manifolds e terra                   %
    %-------------------------------------------------------------%

    % MATRIZ 1 X N COM AS DISTÂNCIAS ENTRE MANIFOLDS E TERRA

    for j=1:M
        Distancia_Manifold_Terra(1,j)=sqrt((xyorigin(1,1)-xymanifold(j,1))^2+(xyorigin(1,2)-xymanifold(j,2))^2);
    end
    Distancia_Manifold_Terra;

    %-------------------------------------------------------------%
    %        Volume de aço utilizado                              %
    %-------------------------------------------------------------%

    Distancia_Total_Manifolds_Pocos = sum(sum(Distancia_Conexoes_Poco_Manifold))*1000; % DIstãncia total de conexões em metros
    Distancia_Total_Manifolds_Terra =sum(sum(Distancia_Manifold_Terra))*1000;          % DIstãncia total de conexões em metros
    Distancia_Total_Penalizacoes =sum(sum(Penalizacao_Poco_Manifold))*1000;            % DIstãncia total de conexões em metros
    Vol_Aco_Total_Manifolds_Pocos = Distancia_Total_Manifolds_Pocos*A_pm;              % Volume total das conexões manifold e poços em metros cúbicos
    Vol_Aco_Total_Manifolds_Terra =Distancia_Total_Manifolds_Terra*A_mt;               % Volume total das conexões manifold e terra em metros cúbicos
    Vol_Aco_Total_Penalizacoes =Distancia_Total_Penalizacoes*A_pm;                     % Volume total de penalizações em metros cúbicos
    Vol_Aco_Total=Vol_Aco_Total_Manifolds_Pocos+Vol_Aco_Total_Manifolds_Terra+Vol_Aco_Total_Penalizacoes;      % Volume total em metros cúbicos


    vol_aco(1,k)= Vol_Aco_Total;  % Matriz do tipo (1,PopSize)
    
end