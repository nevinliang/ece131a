clear all;

%% array generation

a = linspace(1,11,5);
b = 1:2:10; 
c = zeros(5,6);
d = ones(4,3);


random_normal_val = randn(5,4); % creates a 5 X 4 matrix with each entry N(0,1);
random_uniform_val = rand(5,4); % creates a 5 X 4 matrix with each entry Uniform in (0,1);





%% for loops
x = [1:0.1:10];
expx = zeros(1,length(x));
disp([size(x),size(expx)]);
for i = 1:length(x)
    expx(i) = exp(-x(i));
    
end
figure(1);
plot(x,expx);
xlabel('x');
ylabel('e^{-x}');
grid on;



%% while loops
x = [1:0.01:10];
logx = zeros(1,length(x));

j = 1;
while j <= length(x)
    
    logx(j) = log(x(j));
    j = j+1;
end 
figure(2);
plot(x,logx);
xlabel('x');
ylabel('log(x)');
grid on;



%% vectorization

x = [1:0.01:10];
expx = exp(x);
logx = log(x);
figure(3)
plot(x,logx);
grid on;








%% element wise operations
x = [1:1:10];
squarex = x.^2;
sumx = x + squarex;
disp([x',squarex',sumx']);
mulx = x.*squarex;
divx = x./squarex;
figure(3)
plot(x,divx);






%% logical operations
x = [1:1:10];
squarex = x.^2;

thresholdx = (x > 5);
a = x(x > 5);
b = squarex((x>2));
squarex(x < 3) = 0;








%% histogram %%% histogram(X,nbins)
x = randn(10000,1); %creates 10000 independent standart normal RVs
figure(1);
h2 = histogram(x,50,'Normalization','pdf'); 

x = rand(10000,1); %creates 10000 independent uniform RVs, each unifrom in (0,1);
figure(2);
h3 = histogram(x,50,'Normalization','pdf'); 

% hold on;
% h2 = histogram(x,200,'Normalization','pdf'); 






%% stem plots
figure(3);
y = linspace(0,2*pi,50);
stem(sin(y));











%% regular plots 
figure(4);
plot(y,cos(y),y,sin(y),'Linewidth',2);
xlabel('y');
ylabel('F(y)');
legend('cos(y)','sin(y)');
grid on;








%%
%subplot
figure(5);
subplot(2,2,1); 
h2 = histogram(x,50); 
title('Subplot 1: histogram');

subplot(2,2,2); 
stem(sin(y));
title('Subplot 2: sin(y)');

subplot(2,2,3); 
plot(y,cos(y),y,sin(y),'Linewidth',2);
xlabel('y');
ylabel('F(y)');
legend('cos(y)','sin(y)');
title('Subplot 3: cos(y),sin(y)');

subplot(2,2,4); 
stem(exp(y));
title('Subplot 4: exp(y)');


%% functions
x = [1:2:10];
avgx = average(x);


X = create_bernouli(0.2,3,4);

%%
%%%function definitions must appear at the end of the file
function ave = average(x)

    ave = sum(x(:))/numel(x); 
end



% create bernouli
function X = create_bernouli(p,n,m) % n X m matrix with each element bernouli p

    U = rand(n,m);
    X = (U <= p);
    

end

    