% 1a
for j = [10,50,100,500,1000]
    disp(length(find(mod(mod(floor(rand(j,1)*1000),5)+1,2)==1))/j);
end

% 1d
for j = [10, 50, 100, 500, 1000]
    disp(length(find(mod(mod(floor(rand(j,1)*1000),7),2)==0))/j);
end

%2a
figure(1);
sgtitle("Plot of Prep vs pe for different N values");
N = [3, 4, 5];
pe = (0.125:0.025:0.4);
for n = N
    rvals = rand(100000, n);
    prep = zeros(length(pe));
    for x = 1:length(pe)
        prep(x) = sum(sum(rvals < pe(x), 2) == n) / 100000;
    end
    subplot(1, 3, n - 2);
    semilogy(pe, prep);
    title("N = " + n);
    xlabel("p_e");
    ylabel("P^{Rep}_{sim}");
end

%2b
figure(2);
sgtitle("Analytic plot of Prep vs pe for different N values");
for n = N
    prep = power(pe, n);
    subplot(1, 3, n - 2);
    semilogy(pe, prep);
    title("N = " + n);
    xlabel("p_e");
    ylabel("P^{Rep}_{sim}");
end

%2c
figure(3);
sgtitle("Plot of Psin vs pe for different N values");
N = [3, 4, 5];
pe = (0.125:0.025:0.4);
for n = N
    rvals = rand(100000, n);
    prep = zeros(length(pe));
    for x = 1:length(pe)
        prep(x) = sum(sum(rvals > pe(x), 2) < n - 1) / 100000;
    end
    subplot(1, 3, n - 2);
    semilogy(pe, prep);
    title("N = " + n);
    xlabel("p_e");
    ylabel("P^{Sin}_{sim}");
end

%3a
figure(1);
sgtitle("Fractions of Characteristics Across Data")
M = readmatrix("user_data.csv");
xlabs = ["Bought product (0/1)", "Type of Spender (1/2/3)", ...
            "Sex of User (0=F/1=M)", "Age of User (Years)"];
for c = 1:4
    subplot(2, 2, c);
    x = [unique(floor(M(:,c))); intmax];
    y = histcounts(M(:,c),x) / 887;
    x(end) = [];
    bar(x, y);
    xlabel(xlabs(c));
    ylabel("Probability");
end

%3b
figure(2);
sgtitle("Conditional Probability of Characteristics Given B Across Data")
pb = histcounts(M(:,1),[0 1 intmax]) / 887;
for c = 2:4
    x = [unique(floor(M(:,c))); intmax];
    M1 = M(M(:,1)==0,:);
    M2 = M(M(:,1)==1,:);
    y1 = histcounts(M1(:,c),x) / (887 * pb(1));
    y2 = histcounts(M2(:,c),x) / (887 * pb(2));
    x(end) = [];
    
    subplot(4, 2, 2 * c - 3);
    bar(x, y1);
    subplot(4, 2, 2 * c - 2);
    bar(x, y2);
end

%3c
pb0 = pb(1)
pt1b0 = sum(M1(:,2)==1)/887/pb0
ps0b0 = sum(M1(:,3)==0)/887/pb0
pa55b0 = sum(M1(:,4)<=55)/887/pb0
finalp1 = pb0 * pt1b0 * ps0b0 * pa55b0;
disp(finalp1)

pb1 = pb(2)
pt1b1 = sum(M2(:,2)==1)/887/pb1
ps0b1 = sum(M2(:,3)==0)/887/pb1
pa55b1 = sum(M2(:,4)<=55)/887/pb1
finalp2 = pb1 * pt1b1 * ps0b1 * pa55b1;
disp(finalp2)

%3d
pd1 = finalp1 / (finalp1 + finalp2)
pd2 = finalp2 / (finalp1 + finalp2)

%4a
figure(1);
sgtitle("PDF of regular die for different values of n");
N = [1, 2, 3, 10, 30, 100];
S = cumsum(rand(100, 10000) * 4 + 3);
for i = 1:6
    s = subplot(3, 2, i);
    title("x = " + N(i)); xlabel("Z_n"); ylabel("pdf");
    hold on;
    histogram(S(N(i), :) / N(i), 'Normalization', 'pdf');
end

%4c
for i = 1:6
    x = (3:0.01:7);
    y = normpdf(x, 5, sqrt(4 / (3 * N(i))));
    s = subplot(3, 2, i);
    plot(x, y);
    hold off;
end

%4d
figure(2);
sgtitle("PDF of weighted die for different values of n");
N = [1, 2, 3, 10, 30, 100];
X = abs(floor(rand(100, 10000) * 7) - 2);
X(X == 0) = 5;
S = cumsum(X);
for i = 1:6
    s = subplot(3, 2, i);
    title("x = " + N(i)); xlabel("Z_n"); ylabel("pdf");
    hold on;
    histogram(S(N(i), :) / N(i), 'Normalization', 'pdf', 'BinWidth', 1 / (N(i) + 1));
    x = (1:0.01:5);
    y = normpdf(x, 2.5714, sqrt(1.9592 / N(i)));
    plot(x, y);
    hold off;
end
