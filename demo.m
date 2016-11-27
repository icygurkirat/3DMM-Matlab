% load model
model = load('01_MorphableModel.mat');

% align face with image
[I,GCA] = align(model);

%fit face onto morphable model
[alpha,beta] = fitting(model,model.shapeMU,model.texMU,I,GCA);

%diaplay 3D model
display_face(alpha,beta,model.tl,defrp);
