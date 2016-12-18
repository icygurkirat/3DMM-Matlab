% load model
clear; clc;
model = load('01_MorphableModel.mat');

% align face with image
[I,GCA] = align(model);

%fit face onto morphable model
alpha = zeros(199,1);
beta = zeros(199,1);
baditr=0;
maxit = 200000;
m = 199;
sigma = 100;
lambda_shape = 1000;
lambda_tex = 200;
numComponents = 5;

% target image
T = imread('Capture.PNG');
[row,col,~]=size(T);
min_E=100000000000;
min_alpha=alpha;
min_beta=beta;
const=10;
baditr=0;

x = row/const;
y = col/const;
T_ = imresize(T,[x,y]);
T_ = double(reshape(T_,[],1,1));
T_ = T_/255;


for i = 1:maxit
    I = imresize(I,[x,y]);
    I = double(reshape(I,[],1,1));
    E = norm(I/255 - T_)^2;
    E = (E/(x*y))*255
    if(E<=min_E)
        baditr = 0;
        min_alpha = alpha;
        min_beta = beta;
        min_E=E;
    else
        baditr=baditr+1;
    end
    if(baditr>=4)
       baditr = 0;
       lambda_shape = lambda_shape/2;
       lambda_tex = lambda_tex/2;
       E = min_E;
       alpha = min_alpha;
       beta = min_beta;
       if(lambda_tex<5)
           const = const-1; 
           if(const==0)
               break;
           end
           I = get_update(model,alpha,beta,GCA);
           I = imresize(I,[row/const,col/const]);
           [x,y,z] = size(I);
           T_ = imresize(T,[x,y]);
           T_ = double(reshape(T_,[],1,1));
           T_ = T_/255;
           I = double(reshape(I,[],1,1));
           E = norm(I/255 - T_)^2;
           E = (E/(x*y))*255;
           min_E = E;
           lambda_shape = 1000;
           lambda_tex = 200;
       end
    end
    % update alpha and beta
    [gradAlpha,gradBeta]=gradE(model,alpha,beta,GCA,numComponents,const,T_);
    alpha = alpha - lambda_shape*(gradAlpha/(sigma*sigma) + 2*(alpha)./(model.shapeEV.*model.shapeEV));
    beta = beta - lambda_tex*(gradBeta/(sigma*sigma) + 2*(beta)./(model.texEV.*model.texEV));
    numComponents = min(m, 5 + fix(i/5));
    %{
    if(rem(i,50) == 0)
        sigma = max(sigma/2,1000);
    end  
    %}
        
    % update I using alpha and beta
    I = get_update(model,alpha,beta,GCA);
    fprintf('No of iterations : %i numComponents : %i   Scale : %i   BADITR : %i   lamda_tex : %f   min_E : %f\n',i,numComponents,const,baditr,lambda_tex,min_E);
end


shp = model.shapeMU + model.shapePC*(min_alpha.*model.shapeEV);
tex = model.texMU + model.texPC*(min_beta.*model.texEV);
I = get_update(model,min_alpha,min_beta,GCA);

