% function [gbest,gbestval,fitcount]= PSO_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,varargin)
function [gbest,gbestval,fitcount,beschi,media]= PSO_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
rand('state',sum(100*clock));
me=Max_Gen;
ps=Particle_Number;
D=Dimension;
cc=[2 2];   %acceleration constants
iwt=0.9-(1:me).*(0.5./me);
% iwt=0.5.*ones(1,me);
if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=0.5*(VRmax-VRmin);
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
Vmin=repmat(-mv,ps,1);
Vmax=-Vmin;
pos=VRmin+(VRmax-VRmin).*rand(ps,D);

% e=feval(fhd,pos',varargin{:});

e=feval(fhd,pos');

% ******************************
beschi(me)=0;
media(me)=0;
% ******************************

fitcount=ps;
vel=Vmin+2.*Vmax.*rand(ps,D);%initialize the velocity of the particles
pbest=pos;
pbestval=e; %initialize the pbest and the pbest's fitness value
[gbestval,gbestid]=min(pbestval);

% ******************************
beschi(1)=gbestval;
media(1)=mean(pbestval);
% ******************************

gbest=pbest(gbestid,:);%initialize the gbest and the gbest's fitness value
gbestrep=repmat(gbest,ps,1);


% ************************
i=2;
erro=1;
% ************************

% for i=2:me
    contador=0;
%     *******************
% Modificando
discrepancia(me)=0;
% ***********************
while(i<=me&(abs(erro)>10^-3|erro==0|abs(erro_do_erro)>=1))
%     while(i<=me&(abs(erro)>eps|erro==0))
%         i

%         rd=mod(i,35);%verificar. problema 50 e divisor exato de 100
%         rd=mod(i,37);
%         if rd==0
% %         
%         minimoDaFuncao=gbestval;
%         
%         end
        
%         rd=mod(i,37);
%         if rd==0
% %         
%         minimoDaFuncao=gbestval;
%         
%         end

%         minimoDaFuncao=gbestval;
        aa=cc(1).*rand(ps,D).*(pbest-pos)+cc(2).*rand(ps,D).*(gbestrep-pos);
        vel=iwt(i).*vel+aa;
        vel=(vel>Vmax).*Vmax+(vel<=Vmax).*vel;
        vel=(vel<Vmin).*Vmin+(vel>=Vmin).*vel;
        pos=pos+vel;
        pos=((pos>=VRmin)&(pos<=VRmax)).*pos...
            +(pos<VRmin).*(VRmin+0.25.*(VRmax-VRmin).*rand(ps,D))+(pos>VRmax).*(VRmax-0.25.*(VRmax-VRmin).*rand(ps,D));
%         e=feval(fhd,pos',varargin{:});
        e=feval(fhd,pos');
        fitcount=fitcount+ps;
        tmp=(pbestval<e);
        temp=repmat(tmp',1,D);
        pbest=temp.*pbest+(1-temp).*pos;
        pbestval=tmp.*pbestval+(1-tmp).*e;%update the pbest
        [gbestval,tmp]=min(pbestval);
        gbest=pbest(tmp,:);
        %         ***************************************
        beschi(i)=gbestval;            %guarda num vector os melhores
        media(i)=mean(pbestval);
%         ***************************************
        gbestrep=repmat(gbest,ps,1);%update the gbest
        
        %         *****************************************************************
        i=i+1;
%         erro=(gbestval-minimoDaFuncao);%/minimoDaFuncao;
%         *****************************************************************


  rd=mod(i,100);
    if rd==0
%         erro=abs(Fit(iBest)-valorAnterior);
       
%         erro=(gbestval-minimoDaFuncao);
%         beschi(i-1)
%         beschi(i-99)
        contador=contador+1;
        erro=(beschi(i-1)-beschi(i-99));
        discrepancia(contador)=erro;
        %     *******************
        % Modificando
        erro_do_erro=1;
        if(contador>=2)
            erro_do_erro=discrepancia(contador)-discrepancia(contador-1);
%             erro_do_erro=(discrepancia(contador)-discrepancia(contador-1))/discrepancia(contador);
        end
        disp(['Fitness ', num2str(gbestval),'   Geração ',num2str(i),'  Erro   ',num2str(erro), '     Erro do e ',num2str(erro_do_erro)]);
        % ***********************
%         disp(['Fitness ', num2str(gbestval),'   Geração ',num2str(i),'  Erro   ',num2str(erro)]);
%         erro
    end


    end
end


