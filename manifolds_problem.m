Dimension=20;
Popsize=600;
xymanifold=rand(Dimension,Popsize); 


% function [vol_aco]=manifolds_problem(xymanifold)
% Essa função receve tantas soluções tentativas como o tamanho da população
% Neste caso as soluçoes tentativas são as coordenadas dos manifolds e
% devolve o volume de aço necessario para cada solução tentativa. É dizer
% devolve um vetor de unidimensional de Popsize elementos.
% -------------------------------------------------------------------------

% Caracteristicas das tubulações

% LINHA             Diâmetro	Espessura	Vol Aço
% Poço-Manifold      d_pm          e_pm       V_pm
% Man.-Terra         d_mt          e_mt       V_mt

d_pm=10.75;
e_pm=0.625;
V_pm=pi()*(d_pm^2-(d_pm-2*e_pm)^2)/4;

d_mt=10.75;
e_mt=0.625;
V_mt=pi()*(d_mt^2-(d_mt-2*e_mt)^2)/4;

 



% xymanifold agora é uma matriz DimensionsXPopsize e contém Popsize soluções
% tentativas

% inicialização da matriz de coordenadas dos poços
% xywell[nrodepoços,2D]

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

% plot(xywell(:,1),xywell(:,2),'x')


% inicialização do vetor coordenada do sumidouro

xyorigin=[0 0];


% Calcular distancia dos manifold ao sumidouro




% Calcular distancia dos manifold aos poços


% Produto da distancia X Volume de Aço/m
% utilizar V_pm V_mt



% end