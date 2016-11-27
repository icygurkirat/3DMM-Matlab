% load model
model = load('01_MorphableModel.mat');

% align face with image
[I,GCA] = align(model);

%fit face onto morphable model
[alpha,beta] = fitting(model,zeros(199,1),zeros(199,1),I,GCA);

shp = model.shapeMU;
tex = model.texMU;
for i = 1:199
    shp = shp + alpha(i)*(model.shapeEV(i));
    tex = tex + beta(i)*(model.texEV(i));
end


%diaplay 3D model
display_face(shp,tex,model.tl,defrp);

disp('Hello')
