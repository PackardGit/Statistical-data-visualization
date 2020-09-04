%%
%
clear;
close all;
load('populacja.mat')
[rows, cols] = size(populacja);

pop(1:3)=0;%populacja dla poszczegolnych paczkolat
chory(1:3)=0;%chorzy dla poszczegolnych paczkolat
for i=1:rows
   if populacja(i,3)==0
       pop(1)=pop(1)+1;
       if populacja(i,4)==1
           chory(1)=chory(1)+1;
       end
   end
       if populacja(i,3)==1  
             pop(2)=pop(2)+1;
               if populacja(i,4)==1
                  chory(2)=chory(2)+1;
                end
       end
      if populacja(i,3)==2
        pop(3)=pop(3)+1;
               if populacja(i,4)==1
                 chory(3)=chory(3)+1;
               end
       end
end

%%
%ENW

p(1:3)=0;
q(1:3)=0;
SE(1:3)=0;
SE(1:3)=0;
zk=1.96;
lp(1:3)=0;
lq(1:3)=0;
rp(1:3)=0;
rq(1:3)=0;
for i=1:3
   p(i)=chory(i)/pop(i);
   q(i)=1-p(i);
   SE(i)=sqrt((p(i)*q(i))/pop(i));
   lp(i)=p(i)-zk*SE(i);
   rp(i)=p(i)+zk*SE(i);
   lq(i)=q(i)-zk*SE(i);
   rq(i)=q(i)+zk*SE(i);
end

%%
%zad2
%ho p=0.5
pp=0.5;
z(1:6)=0;
for i=1:3
   z(i)=(p(i)-pp)/sqrt((p(i)*q(i))/pop(i));
   z(i+3)=(q(i)-pp)/sqrt((p(i)*q(i))/pop(i));%wartosc z dla q
end

%%
%zad3
z2(1:3)=0;
for i=1:3 
   z2(i)=(p(i)-q(i))/sqrt(0.25*2/pop(i));
end
%%
%zad4
n(1,1)=60;
n(1,2)=77;
n(2,1)=39;
n(2,2)=43;

N=219;
r(1)=137;
r(2)=82;
c(1)=99;
c(2)=120;
np(1:2,1:2)=0;
for i=1:2
    for j=1:2
    np(i,j)=r(i)*c(j)/N;
    end
end

X2=0;
for i=1:2
    for j=1:2
    X2=X2+((n(i,j)-np(i,j))^2)/np(i,j);
    end
end
%%
%zad5
SElnOR=sqrt(1/60+1/77+1/39+1/43)
przedzial1=0.165-1.96*SElnOR
przedzial2=0.165+1.96*SElnOR