load('pop79.mat');
populacja=populacja(:,2:5);
param(1)=mean(populacja(:,1));
param(2)=mean(populacja(:,2));
param(3)=mean(populacja(:,3));
param(4)=mean(populacja(:,4));


for j=1 : p
    parampom(j)=0
end
for j=1 : p
    k=0;
for i=1:N
if(populacja(i,j)~=0)
    k=k+1;
    parampom(j)=parampom(j)+populacja(i,j);
end
end
param(j)=round(parampom(j)/k);
end
[N, p] = size(populacja);

for j=1 : p
for i=1:N
if(populacja(i,j)==0)
    populacja(i,j)=(param(j));
end
end
end


n=200;
x=int32(rand(n,1)*N)
probe=populacja(x,:)

a=randi(N-200) 
%probe=populacja(a:a+199,:)

for j=1 : p
srednia(j)=mean(probe(:,j));
end
for j=1 : p
mediana(j)=median(probe(:,j));
end
for j=1 : p
dominanta(j)=mode(probe(:,j));
end
kwantyle = quantile(probe,4)

k=sqrt(N)
hist(probe(:,1),k)
title('waga')
figure
hist(probe(:,2),k)
title('nr dziecka')
figure
hist(probe(:,3),k)
title('wiek matki')
figure
hist(probe(:,4),k)
title('wiek ojca')


figure
qqplot(probe(:,1))
title('waga')

figure
qqplot(probe(:,3))
title('wiek matki')

figure
qqplot(probe(:,2))
title('nr dziecka')

figure
qqplot(probe(:,4))
title('wiek ojca')

k1=0;
k2=0;
k3=0;
for i=1 : 200
    if(probe(i,2)==1)
        k1=k1+1;
       przedzal1(k1,1)=mean(probe(i,1));
     przedzal1(k1,2)=mean(probe(i,2));
      przedzal1(k1,3)=mean(probe(i,3));
       przedzal1(k1,4)=mean(probe(i,4));
    end
    
        if(probe(i,2)==2)
             k2=k2+1;
        przedzal2(k2,1)=mean(probe(i,1));
     przedzal2(k2,2)=mean(probe(i,2));
      przedzal2(k2,3)=mean(probe(i,3));
       przedzal2(k2,4)=mean(probe(i,4));
        end
    
    if(probe(i,2)>2)
         k3=k3+1;
    przedzal3(k3,1)=mean(probe(i,1));
     przedzal3(k3,2)=mean(probe(i,2));
      przedzal3(k3,3)=mean(probe(i,3));
       przedzal3(k3,4)=mean(probe(i,4));
    end
end
figure
boxplot(przedzal1(:,3))
title('wiek matki')

figure
boxplot(przedzal1(:,4))
title('wiek ojca')

figure
boxplot(przedzal2(:,3))
title('wiek matki')

figure
boxplot(przedzal2(:,4))
title('wiek ojca')

figure
boxplot(przedzal3(:,3))
title('wiek matki')

figure
boxplot(przedzal3(:,4))
title('wiek ojca')

