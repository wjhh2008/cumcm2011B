

X=binvar(24,92);
add=[29 40 48 89];
fee=p(1:92,5);

f=sum((X*fee-5.1875).^2);
F=set(sum(X>can)==zeros(24,92))+set(sum(X)==ones(1,92));
solvesdp(F,f);
double(f)
        
