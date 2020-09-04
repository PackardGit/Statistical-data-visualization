clear all;close all;
%%
%wczytanie danych
load('dane.txt')
H2AX=dane(1:50,1);
FDXR=dane(1:50,2);
n=50;
%%
%wykreds rozproszenia
%scatter(FDXR, H2AX)
 ylabel('Poziom bia³ka H2AX')
 xlabel('Ekpresja genu FDXR')
%%
%korelacje
Korelacja_Pearsona = corr(FDXR, H2AX, 'type', 'Pearson');
Korelacja_Spearmana = corr(FDXR, H2AX, 'type', 'Spearman');
%%
%hipoteza
%Ho: p=o - zmienne nie skorelowane
%Ha: p=!0 - zmienne skorelowane
%a=0.05
%tkryt dla takiego a to 2.01
ts_pearson=Korelacja_Pearsona*sqrt((n-2)/(1-Korelacja_Pearsona^2));
ts_spearmana=Korelacja_Spearmana*sqrt((n-2)/(1-Korelacja_Spearmana^2));
%oba testy przekraczaja wartosc krytyczna t
%odrzucamy hipotezy zerowe
%zmienne sa skorelowane
%%
%
for i =1:50
    FDXR2(i)=(-FDXR(i));
end
FDXR2=FDXR2';
figure
scatter(FDXR2, H2AX)
 ylabel('Poziom bia³ka H2AX')
 xlabel('Ujemny logarytm Ekpresji genu FDXR')
    Korelacja_Pearsona2 = corr(FDXR2, H2AX, 'type', 'Pearson');
    Korelacja_Spearmana2 = corr(FDXR2, H2AX, 'type', 'Spearman');
    ts_pearson2=Korelacja_Pearsona2*sqrt((n-2)/(1-Korelacja_Pearsona2^2));
    
    
Sx=sqrt(var(FDXR2));
Sy=sqrt(var(H2AX));
b1=Korelacja_Pearsona2*Sy/Sx;
b0=mean(H2AX)-b1*mean(FDXR2);
hold on
x = min(FDXR2):0.001:max(FDXR2);
y = x.*b1+b0;
plot(x,y)
%%
%Przedzialy ufnosci
ym=FDXR2.*b1+b0;
S2=0;
for i=1:n
   S2=S2+ (H2AX(i)-ym(i))^2;
end
S=sqrt(S2/(n-2));%bladsredniokwadratowy
SX=(n-1)*var(FDXR2);
sre=mean(FDXR2);
t=tinv(0.975, n-2);
for i=1:n
   SEy(i)= S*sqrt((1/n)+((FDXR2(i)-sre)^2)/SX);
   ym1(i)=ym(i)-t*SEy(i);
   ym2(i)=ym(i)+t*SEy(i);
end

plot(sort(FDXR2),sort(ym1))
plot(sort(FDXR2),sort(ym2))
title('Wykres rozproszenia z lini¹ regresji')
 ylabel('Poziom bia³ka H2AX')
 xlabel('Ujemny logarytm Ekpresji genu FDXR')
 legend('Wykres rozporszenia','Linia regresjii','Przedzia³ ufnoœci','Przedzia³ ufnoœci')
%%
%wykres resztowu
for i=1:n
  reszty(i)=ym(i)-H2AX(i);
  r1(i)=ym(i)-ym1(i);
  r2(i)=ym(i)-ym2(i);
end
figure
scatter(FDXR2,reszty)
hold on
plot(x,0*x)
title('Wykres resztowy')

 ylabel('Skorygowany poziom H2AX')
 xlabel('Ujemny logarytm Ekpresji genu FDXR')

