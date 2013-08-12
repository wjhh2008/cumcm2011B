clear,clc
file='..\cumcm2011B附件2_全市六区交通网路和平台设置的数据表.xls';
kiosk=xlsread(file,3,'A2:B81');
p=xlsread(file,1,'A2:E583');
e=xlsread(file,2,'A2:B929');
entryA=xlsread(file,4,'C2:C14');

n=582;
limit=30;
%plot graph
A=zeros(n);
xy=zeros(n,2);
for i=1:size(e,1)
    x=e(i,1);
    y=e(i,2);
    A(x,y)=1;
    A(y,x)=1;
end
xy= p(:,2:3);
gplot(A,xy,'k.-');
hold on

for i=1:size(p,1)
    text(p(i,2)+2,p(i,3)+2,num2str(i));
end

%floyd
for i=1:size(e,1)
    x=e(i,1);
    y=e(i,2);
    A(x,y)=1;
    A(y,x)=1;
end

adj=ones(n)*Inf;
for i=1:n 
    adj(i,i)=0;
end
for i=1:n
    for j=1:n
        if A(i,j)==1
            p1=[p(i,2);p(i,3)];
            p2=[p(j,2);p(j,3)];
            adj(i,j)=sqrt((p1-p2)'*(p1-p2));
        end
    end
end
adjbak=adj;

for k=1:n
    for i=1:n
        for j=1:n
            if adj(i,k)+adj(k,j)<adj(i,j)
                adj(i,j)=adj(i,k)+adj(k,j);
            end
        end
    end
end

%初始最短分配图
 Bad=zeros(92,1);
 for i=1:size(kiosk)
     plot(p(kiosk(i),2),p(kiosk(i),3),'bo')
 end
 assign=zeros(1,92);
 for i=1:92
     [Y,I]=min(adj(i,1:20));
     if Y>limit 
         Bad(i)=1;
     end
     assign(i)=I;
 end
 for i=1:92
     if Bad(i)==1
         plot(p(i,2),p(i,3),'rx', 'MarkerSize',10,'LineWidth',2)    
     end
 end
 %assign
 %Bad
hold off


%匈牙利分配
low=0.0;
high=max(max(adj));
    %20*13 警亭与节点距离矩阵
L=zeros(20,size(entryA,1));
for i=1:20
    for j=1:size(entryA,1)
        L(i,j)=adj(i,entryA(j));
    end
end
    %二分搜索
while high-low>0.001
    mid=(low+high)/2;
    Metrix=1./(L<=mid);
    [at,Cost]=munkres(Metrix);
    if Cost<13
        low=mid;
    else
        high=mid;
    end
end
Metrix=1./(L<=high);
[at,Cost]=munkres(Metrix);
at
Cost
high
M=zeros(20,13);
for i=1:20 
    if at(i)~=0 M(i,at(i))=1; end
end
        
[X,Y]=find(M==1);
Y=entryA(Y);
l=[X,Y];
for i=1:13
    l(i,3)=adj(l(i,1),l(i,2));
end
%l

%分配均匀度计算
load=zeros(20,1);
for i=1:92
    if assign(i)~=0 
        load(assign(i))=load(assign(i))+p(i,5);
    end
end
%load




            