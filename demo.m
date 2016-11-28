% load model
model = load('01_MorphableModel.mat');

% align face with image
[I,GCA] = align(model);

%fit face onto morphable model
alpha = zeros(199,1);
beta = zeros(199,1);
%[alpha,beta] = fitting(model,zeros(199,1),zeros(199,1),I,GCA);

%***********************************************************
baditr=0;
maxit = 20000;
m = 199;
sigma = 100;
Eold = rand();
alpha_old = alpha;
beta_old = beta;
lambda_shape = 1;
lambda_tex = 0.02;
numComponents = 5;
% target image
T = imread('Capture.PNG');

for i = 1:maxit
    % coarse to fine
    %{
    if(E > 1e4)
        I = imresize(I,[50,40]);
    elseif(E > 1e3)
        I = imresize(I,[100,80]);
    elseif(E > 1e2)
        I = imresize(I,[200,160]);
    end
    %}
    [x,y,z]=size(I);
    T_ = imresize(T,[x,y]);
    %disp(size(T_));
    T_ = double(reshape(T_,[],1,1));
    I = double(reshape(I,[],1,1));
    %disp(size(T_));
    %disp(size(I));
    % compute delE = {sum(Iinp - Imodel)**2}/sigma**2
    E = norm(I/255 - T_/255)^2
    %{
    if (E<1000000000)
        lambda=10;
    else if(E<100000000)
            lambda=1;
        else
            lambda=0.1;
        end
    end
    %}
    delE =  (E - Eold)/ sigma;
    delE = delE * delE;
    %{
    if(E-Eold>0)
        baditr=baditr+1;
    else
        baditr=0;
    end
    %}
    % update alpha
    if (norm(alpha - alpha_old) > 1e-6 )
        alpha = alpha - lambda_shape*(delE./(alpha - alpha_old) + 2*(alpha)./(model.shapeEV.*model.shapeEV));
    else
        alpha = alpha - 2*lambda_tex*(alpha)./(model.shapeEV.*model.shapeEV);
    end    
    % update beta
    if (norm(beta - beta_old) > 1e-6)
        beta = beta - lambda_shape*(delE./(beta - beta_old) + 2*(beta)./(model.texEV.*model.texEV));
    else
        beta = beta - 2*lambda_tex*beta./(model.texEV.*model.texEV);
    end
    % add some gaussian noise to alpha and beta
    alpha = alpha + 0.001*([rand(numComponents,1); zeros(m - numComponents,1)]);
    beta = beta + 0.001*([rand(numComponents,1); zeros(m - numComponents,1)]);
    % update render param
    % rp = rp + lambda(d/del + 2*aplha./model.shapeEV);
    % skip since we don't have enough info
    % update Eold and 
    Eold = E;
    beta_old = beta;
    alpha_old = alpha;
    %update numComponents  and sigma 
    numComponents = min(m, 5 + int32(i/5));
    if(rem(i,50) == 0)
        sigma = max(sigma/2,0.1);
    end
    % update learning rate
    if (E < 1e4)
        lambda_shape = 20;
        lambda_tex = 0.125;
    elseif  (E < 1e3 || baditr==20)
     %  lambda_shape = 10;
      % lambda_tex = 0.2;
      break;
    %elseif (E < 100)
     %   lambda_shape = 1;
      %  lambda_tex = 0.1;
    %elseif (E < 10)
     %   lambda_shape = 0.1;
      %  lambda_tex = 0.01;
    %elseif(E < 1)
     %   lambda_shape = 0.01;
      %  lambda_tex = 0.005;
    end
    
        
    % update I using alpha and beta
    %% todo
    I = get_update(model,alpha,beta,GCA);
    %if((i > 5) && norm(alpha-alpha_old)<1e-6 && norm(beta-beta_old)<1e-6 && delE<1e-6)
    %    break;
    %end    
    fprintf('No of iterations : %i numComponents : %i \n',i,numComponents);
end
%***********************************************************







shp = model.shapeMU + model.shapePC*(alpha.*model.shapeEV);
tex = model.texMU + model.texPC*(beta.*model.texEV);

%{
for i = 1:199
   shp = shp + alpha(i)*(model.shapePC(:,i));
   tex = tex + beta(i)*(model.texPC(:,i));
end
%}

%diaplay 3D model
display_face(shp,tex,model.tl,defrp);

disp('Hello')
