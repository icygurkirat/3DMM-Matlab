function [Imodel] = align()
a=axes('position',[0 0 1 1]);
h=zoom;
setAllowAxesZoom(h,a,false);
h = rotate3d;
setAllowAxesRotate(h,a,false);
imshow('Capture.PNG','parent',a);


rp     = defrp;
rp.phi = 0.5;
rp.dir_light.dir = [0;1;1];
rp.dir_light.intens = 0.6*ones(3,1);
a1=axes('position',[0.3 0.3 .5 .5]);
model = load('01_MorphableModel.mat');
display_face(model.shapeMU, model.texMU, model.tl, rp);
grid on
set(gca,'color','none');

pause;
F = getframe(gcf);
Imodel=F.cdata;
figure, imshow(Imodel,[]), impixelinfo;

disp(rp.dir_light.dir);