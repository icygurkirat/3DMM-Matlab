% load model
clear; clc;
model = load('01_MorphableModel.mat');

% align face with image
[I,GCA] = align(model);

%fit face onto morphable model
alpha = zeros(199,1);
beta = zeros(199,1);
%[alpha,beta] = fitting(model,zeros(199,1),zeros(199,1),I,GCA);

%***********************************************************
baditr=0;
maxit = 200000;
%maxit=1;
m = 199;
sigma = 10000;
Eold = rand();
alpha_old = alpha;
beta_old = beta;
lambda_shape = 100;
lambda_tex = 2;
numComponents = 5;
% target image
T = imread('Capture.PNG');
[row,col,~]=size(T);
min_E=100000000000;
min_alpha=alpha;
min_beta=beta;
const=10;
baditr=0;

for i = 1:maxit
    I = imresize(I,[row/const,col/const]);
    [x,y,z]=size(I);
    T_ = imresize(T,[x,y]);
    T_ = double(reshape(T_,[],1,1));
    I = double(reshape(I,[],1,1));
    E = norm(I/255 - T_/255)^2;
    E = (E/(x*y))*255
    if(E<=min_E)
        baditr = 0;
        min_alpha = alpha;
        min_beta = beta;
        min_Eold = Eold;
        min_alphaold = alpha_old;
        min_betaold = beta_old;
        min_E=E;
    else
        baditr=baditr+1;
    end
    if(baditr>=30)
       baditr = 0;
       lambda_shape = lambda_shape/2;
       lambda_tex = lambda_tex/2;
       E = min_E;
       alpha = min_alpha;
       beta = min_beta;
       Eold = min_Eold;
       alpha_old = min_alphaold;
       beta_old = min_betaold;
       if(lambda_tex<0.0005)
           const = const-1; 
           sigma = 100000;
           if(const==0)
               break;
           end
           I = get_update(model,alpha_old,beta_old,GCA);
           I = imresize(I,[row/const,col/const]);
           [x,y,z] = size(I);
           T_ = imresize(T,[x,y]);
           T_ = double(reshape(T_,[],1,1));
           I = double(reshape(I,[],1,1));
           Eold = norm(I/255 - T_/255)^2;
           Eold = (Eold/(x*y))*255;
           I = get_update(model,alpha,beta,GCA);
           I = imresize(I,[row/const,col/const]);
           I = double(reshape(I,[],1,1));
           E = norm(I/255 - T_/255)^2;
           E = (E/(x*y))*255;
           min_E = E;
           lambda_shape = 100;
           lambda_tex = 2;
       end
    end
    delE =  (E - Eold)/ (sigma*sigma);
    % update alpha
    alpha_temp = alpha - lambda_shape*(calcGrad(delE,(alpha - alpha_old)));% + 2*(alpha)./(model.shapeEV.*model.shapeEV));
  
    % update beta
    beta_temp = beta - lambda_shape*(calcGrad(delE,(beta - beta_old)));% + 2*(beta)./(model.texEV.*model.texEV));

    % add some gaussian noise to alpha and beta
    Eold = E;
    beta_old = beta;
    alpha_old = alpha;
    alpha = alpha_temp;
    beta = beta_temp;
    %alpha = alpha_temp + 0.0005*([rand(numComponents,1); zeros(m - numComponents,1)]);
    %beta = beta_temp + 0.0005*([rand(numComponents,1); zeros(m - numComponents,1)]);
    %updated noise
    if(i==1||i==2)
        alpha = alpha + 0.0005*([rand(5,1); zeros(m - numComponents,1)]);
        beta = beta + 0.0005*([rand(5,1); zeros(m - numComponents,1)]);
    else if((rem(i,5)==0||rem(i,5)==1)&&i<=972)
            alpha(5 + fix(i/5)) = alpha(5 + fix(i/5)) + 0.001*rand();
            beta(5 + fix(i/5)) = beta(5 + fix(i/5)) + 0.001*rand();
        end
    end
    % update render param
    % rp = rp + lambda(d/del + 2*alpha./model.shapeEV);
    % skip since we don't have enough info
    % update Eold and 
    numComponents = min(m, 5 + fix(i/5));
    if(rem(i,50) == 0)
        sigma = max(sigma/2,1000);
    end  
        
    % update I using alpha and beta
    I = get_update(model,alpha,beta,GCA);
    fprintf('No of iterations : %i numComponents : %i   Scale : %i   BADITR : %i   lamda_tex : %f   min_E : %f\n',i,numComponents,const,baditr,lambda_tex,min_E);
end
%***********************************************************







shp = model.shapeMU + model.shapePC*(min_alpha.*model.shapeEV);
tex = model.texMU + model.texPC*(min_beta.*model.texEV);
I = get_update(model,min_alpha,min_beta,GCA);

%diaplay 3D model
%display_face(shp,tex,model.tl,defrp);

disp('Hello')
