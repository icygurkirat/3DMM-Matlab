[model msz] = load_model();
plywrite('data\mean.ply', model.shapeMU, model.texMU, model.tl );

% Generate a random head
for i=1:199
    plywrite(strcat('data\head',num2str(i),'.ply'), (10*model.shapeEV(i))*model.shapePC(:,i), model.texEV(i)*model.texPC(:,i), model.tl );
    fprintf('number %d\n',i);
end