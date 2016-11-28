function [alpha,beta] = fitting(model,alpha,beta,I,GCA)

maxit = 2000;
m = 199;
sigma = 100;
Eold = rand();
alpha_old = alpha;
beta_old = beta;
lambda_shape = 1000;
lambda_tex = 1;
numComponents = 5;
% target image
T = imread('Capture.PNG');

for i = 1:maxit
    % compute delE = {sum(Iinp - Imodel)**2}/sigma**2
    [x,y,z]=size(I);
    T_ = imresize(T,[x,y]);
    %disp(size(T_));
    T_ = double(reshape(T_,[],1,1));
    I = double(reshape(I,[],1,1));
    %disp(size(T_));
    %disp(size(I));
    E = norm(I - T_)^2
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
    % update alpha
    if (norm(alpha - alpha_old) > 1e-6 )
        alpha = alpha + lambda_shape*(delE./(alpha - alpha_old) + 2*(alpha)./(model.shapeEV));
    else
        alpha = alpha + 2*lambda_tex*(alpha)./(model.shapeEV);
    end    
    % update beta
    if (norm(beta - beta_old) > 1e-6)
        beta = beta + lambda_shape*(delE./(beta - beta_old) + 2*(beta)./(model.texEV));
    else
        beta = beta + 2*lambda_tex*beta./(model.texEV);
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
        sigma = max(sigma/2,1);
    end
    % update learning rate
    if (E < 1e6)
        lambda_shape = 100;
        lambda_tex = 0.5;
    elseif  (E < 1e3)
       lambda_shape = 10;
       lambda_tex = 0.2;
    elseif (E < 100)
        lambda_shape = 1;
        lambda_tex = 0.1;
    elseif (E < 10)
        lambda_shape = 0.1;
        lambda_tex = 0.01;
    elseif(E < 1)
        lambda_shape = 0.01;
        lambda_tex = 0.005;
    end
        
    % update I using alpha and beta
    %% todo
    I = get_update(model,alpha,beta,GCA);
    %if((i > 5) && norm(alpha-alpha_old)<1e-6 && norm(beta-beta_old)<1e-6 && delE<1e-6)
    %    break;
    %end    
    fprintf('No of iterations : %i numComponents : %i \n',i,numComponents);
end

A = alpha;
B = beta;