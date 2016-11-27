function [Imodel, GCA] = align(model)
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
display_face(model.shapeMU, model.texMU, model.tl, rp);
grid on
set(gca,'color','none');
disp(get(gca, 'PlotBoxAspectRatio'));
disp(get(gca, 'DataAspectRatio'));
disp(get(gca, 'CameraViewAngle'));
disp(get(gca, 'CameraUpVector'));
disp(get(gca, 'CameraTarget'));
disp(get(gca, 'CameraPosition'));

pause;
fprintf('***********************\n');
disp(get(gca, 'PlotBoxAspectRatio'));
GCA.PlotBoxAspectRatio = get(gca, 'PlotBoxAspectRatio');
disp(get(gca, 'DataAspectRatio'));
GCA.DataAspectRatio = get(gca, 'DataAspectRatio');
disp(get(gca, 'CameraViewAngle'));%
GCA.CameraViewAngle = get(gca, 'CameraViewAngle');
disp(get(gca, 'CameraUpVector'));
GCA.CameraUpVector = get(gca, 'CameraUpVector');
disp(get(gca, 'CameraTarget'));%
GCA.CameraTarget = get(gca, 'CameraTarget');
disp(get(gca, 'CameraPosition'));%
GCA.CameraPosition = get(gca, 'CameraPosition');
F = getframe(gcf);
Imodel=F.cdata;
figure, imshow(Imodel,[]), impixelinfo;

disp(rp.dir_light.dir);