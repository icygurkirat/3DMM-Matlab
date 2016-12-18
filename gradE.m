function [gradAlpha,gradBeta] = gradE(model,alpha,beta,GCA,numComponents,const,T_)

gradAlpha = zeros(199,1);
gradBeta = zeros(199,1);
for i = 1:numComponents
    %del Alpha
    delAlpha = 1e-2;
    alpha(i)=alpha(i)+delAlpha;
    I = get_update(model,alpha,beta,GCA);
    [row,col,~]=size(I);
    x = row/const;
    y = col/const;
    I = imresize(I,[x,y]);
    I = double(reshape(I,[],1,1));
    E1 = norm(I/255 - T_)^2;
    E1 = (E1/(x*y))*255;
    alpha(i)=alpha(i)-2*delAlpha;
    I = get_update(model,alpha,beta,GCA);
    I = imresize(I,[x,y]);
    I = double(reshape(I,[],1,1));
    E2 = norm(I/255 - T_)^2;
    E2 = (E2/(x*y))*255;
    gradAlpha(i)=(E1-E2)/(2*delAlpha);
    alpha(i)=alpha(i)+delAlpha;
    
    %del Beta
    delBeta = 1e-2;
    beta(i)=beta(i)+delBeta;
    I = get_update(model,alpha,beta,GCA);
    I = imresize(I,[x,y]);
    I = double(reshape(I,[],1,1));
    E1 = norm(I/255 - T_)^2;
    E1 = (E1/(x*y))*255;
    beta(i)=beta(i)-2*delBeta;
    I = get_update(model,alpha,beta,GCA);
    I = imresize(I,[x,y]);
    I = double(reshape(I,[],1,1));
    E2 = norm(I/255 - T_)^2;
    E2 = (E2/(x*y))*255;
    gradBeta(i)=(E1-E2)/(2*delBeta);
    beta(i)=beta(i)+delBeta;
end

end

