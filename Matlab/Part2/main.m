clc
clear
close all
load('pop86.mat')
%% usuniêcie niekompletnych danych
for i=1:size(populacja, 1)
    for j=1:size(populacja, 2)
        if (populacja(i,j) == 0)
            populacja(i,j)=NaN;
        end
    end
end
rmmissing(populacja);
pop.waga = ans(:, 2);
N = max(size(pop.waga));

%% rok ur | waga | numer dziecka | wiek matki | wiek ojca

% zad 1
hist(pop.waga, floor(sqrt(N)));

% zad 2
wsr = mean(pop.waga);
wstd = std(pop.waga);
hold on
plot([wsr wsr], [1 4000]);
plot([wsr-wstd wsr-wstd], [1 4000]);
plot([wsr+wstd wsr+wstd], [1 4000]);
legend('histogram wagi', 'œr', 'œr+std', 'œr-std');
title('zad1&2')

% zad 3-7
srednia=zeros(1,1000);
wariancja=zeros(1,1000);
mediana=zeros(1,1000);
i = 0;
for n = [10 100 1000 10000]
    i = i + 1;
    for j = 1:1000
        proba=datasample(pop.waga,n,'Replace',true);
        srednia(j)=mean(proba);
        wariancja(j)=var(proba);
        mediana(j)=median(proba);
    end
    zad3(i).size = n;
    zad3(i).means(:) = srednia(:);
    zad3(i).vars = wariancja;
    zad3(i).meds = mediana;
    zad3(i).meanmeans = mean(srednia);
    zad3(i).varmeans = var(srednia);
    zad3(i).meanvars = mean(wariancja);
    zad3(i).varvars = var(wariancja);
    zad3(i).meanmeds = mean(mediana);
    zad3(i).varmeds = var(mediana);

%     figure
%     subplot(3,1,1)
%     hist(srednia(:),sqrt(1000));
%     title('œrednia waga');
%     subplot(3,1,2)
%     hist(wariancja,sqrt(1000));
%     title('wariancja wagi');
%     subplot(3,1,3)
%     hist(mediana,sqrt(1000));
%     title('mediana wagi');
    
    zad3(i).meanpt = tinv(0.975, 999)*sqrt(zad3(i).varmeans)/sqrt(n);
    zad3(i).varpt = chi2inv(0.975, 999)*sqrt(zad3(i).varvars)*0.6028;
    zad3(i).medpt = tinv(0.975, 999)*sqrt(zad3(i).varmeds)*1.2533;
end
figure
for i = 1:4
    subplot(2,2,i)
    hist(zad3(i).means,sqrt(1000));
    title(['œrednie wagi dla N=', num2str(10^i)]);
end
figure
for i = 1:4
    subplot(2,2,i)
    hist(zad3(i).vars,sqrt(1000));
    title(['wariancje wagi dla N=', num2str(10^i)]);
end
figure
for i = 1:4
    subplot(2,2,i)
    hist(zad3(i).meds,sqrt(1000));
    title(['mediany wagi dla N=', num2str(10^i)]);
end

% zad 5-7
figure
n = [10 100 1000 10000];
for i = 1:max(size(n)) 
    errorbar(log10(n(i)), zad3(i).meanmeans, zad3(i).meanpt);
    hold on
end
pop.wm=mean(pop.waga);
plot([1 4], [pop.wm pop.wm]);
title('Przedzia³y ufnoœci wartoœci œredniej a = 95%');
ylabel('œrednia waga');
xlabel('log(n)');
figure
for i = 1:max(size(n)) 
    errorbar(log10(n(i)), zad3(i).meanmeans, zad3(i).varpt);
    hold on
end
pop.wv=var(pop.waga);
plot([1 4], [pop.wv pop.wv]);
title('Przedzia³y ufnoœci wariancji a = 95%');
ylabel('wariancja wagi');
xlabel('log(n)');

figure
for i = 1:max(size(n)) 
    errorbar(log10(n(i)), zad3(i).meanmeds, zad3(i).medpt);
    hold on
end
pop.wmed=median(pop.waga);
plot([1 4], [pop.wmed pop.wmed]);
title('Przedzia³y ufnoœci miediany a = 95%');
ylabel('mediana wagi');
xlabel('log(n)');