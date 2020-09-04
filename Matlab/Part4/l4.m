clear all, clc, close all;
dane1=load('E-MTAB-1038_data_Dai');
dane=dane1.data;
[x y]=size(dane);
for (i=1:x)
test_normalnosci(i)=kstest(dane(i,1:52));
end
for (i=x+1:2*x)
test_normalnosci(i)=kstest(dane(i-x,53:y));
end

grupa1=dane(:,1:52);
grupa2=dane(:,53:73);

% for(i=1:5)
%     figure
%    qqplot(grupa1(i,:));
% end

for (i=1:x)
test_wariancji(i)=vartest2(grupa1(i,:),grupa2(i,:));
end
suma_war=length(test_wariancji)-sum(test_wariancji);
for (i=1:x)
[test_Manna_Whitneya_5(i,1) test_Manna_Whitneya_5(i,2)] =ranksum(grupa1(i,:),grupa2(i,:));
end

for (i=1:x)
[test_Manna_Whitneya_1(i,1) test_Manna_Whitneya_1(i,2)] =ranksum(grupa1(i,:),grupa2(i,:),'alpha',0.01);
end

liczba_genow_roznicujacych5=sum(test_Manna_Whitneya_5(:,2));
liczba_genow_roznicujacych1=sum(test_Manna_Whitneya_1(:,2));

% figure
% hist(test_Manna_Whitneya_5(:,1),round(sqrt(19657)))
% title('histogram p-wartosci dla poziomu istotnosci 5%, 2531 genów ró¿nicuj¹cych');
% hold on
% plot([0.05 0.05], [0 600])
% xlabel('p-wartoœæ');
% ylabel('licznoœæ');
% legend('Histogram', 'Poziom istotnoœci');
% 
% figure
% hist(test_Manna_Whitneya_1(:,1),round(sqrt(19657)))
% hold on
% plot([0.01 0.01], [0 600])
% title('histogram p-wartosci dla poziomu istotnosci 1%, 741 genów ró¿nicuj¹cych');
% xlabel('p-wartoœæ');
% ylabel('licznoœæ');
% legend('Histogram', 'Poziom istotnoœci');
p_w=test_Manna_Whitneya_1(:,1);
p_w=sort(p_w);
%%
%Bonferetti
bonferri_5 = sum(p_w<(0.05/x));
bonferri_1  = sum(p_w<(0.01/x));
%%
%Benjamiego Hohberga i Holma
 TempBH1(1)=0;
  TempBH5(1)=0;
  TempH1(1)=0;
  TempH5(1)=0;
for i=1:x
    
Benj_Hoch_temp_1(i) = i*0.01/x;
Benj_Hoch_temp_5(i)  = i*0.05/x;

Holm_temp_5(i) = 0.05/(x-i+1);
Holm_temp_1(i) = 0.01/(x-i+1);

if p_w(i) <= Benj_Hoch_temp_1(i)
    TempBH1(i)=1;
end  
if p_w(i) <= Benj_Hoch_temp_1(i)
    TempBH5(i)=1;
end 

if p_w(i) <= Holm_temp_1(i)
    TempH1(i)=1;
end  
if p_w(i) <= Holm_temp_5(i)
    TempH5(i)=1;
end 


end

Benj_Hoch_5 = sum( TempBH5);
Benj_Hoch_1  = sum(TempBH1);

Holm_5 = sum( TempH5);
Holm_1  = sum(TempH1);

%%
%Storey
q_w = mafdr(p_w);
S5 = sum(q_w<0.05);
S1 = sum(q_w<0.01);
wykres1(1:size(p_w))=0.01;
wykres5(1:size(p_w))=0.05;
plot(p_w,q_w);
hold on
plot(p_w,wykres1);
plot(p_w,wykres5);
ylabel('q wartosc');
xlabel('p wartosc');
legend('q=f(p)','poziom istotnosci 1%', 'poziom istotnosci 5%');

% mavolcanoplot(grupa1(:,:), grupa2(:,:), test_Manna_Whitneya_5(:,1))