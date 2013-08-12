clc
m=size(kiosk,1);
canuse=ones(m,1);
catchpoint=zeros(m,1);
touchtime=min(adj(kiosk,:));
point=ones(n,1);
%dijstra
us=ones(n,1);
us(32)=0;
d=adjbak(32,:)./us'; %到集合的最短距离
w=ones(n,1)*Inf;
w(32)=0;

for i=1:n-1
    [Y I]=min(d);
    if Y==Inf 
        break;
    end
    w(I)=Y;
    us(I)=0;
    d(I)=Inf;
    %I
    if Y-30>touchtime(I) && Y>=30
        jt=kiosk(find(canuse==1));
        K=find(kiosk==jt(find(adj(jt,I)==touchtime(I))));
        canuse(K)=0;
        catchpoint(K)=I;
        point(I)=0;
        touchtime=min(adj(kiosk(find(canuse==1)),:));
    else
        d=min(d,adjbak(I,:)./us'./point'+Y);
        %find(d~=Inf)
    end
end
temp=find(point==0);
hold on
plot(p(temp,2),p(temp,3),'r^','MarkerSize',10)
hold off

%show
tp=canuse==0;

sum(tp)

tp=[kiosk(find(catchpoint~=0)) catchpoint(tp)];
AA=zeros(n,n);
for i=1:size(tp,1)
    AA(tp(i,1),tp(i,2))=1;
end
hold on
%gplot(AA,xy,'r*-')
hold off


for i=1:size(tp,1)
    tp(i,3)=adj(tp(i,1),tp(i,2));
end

