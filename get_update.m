function [I] = get_update(model,alpha,beta,GCA,numComponents)
%{
a=axes('position',[0 0 1 1]);
h=zoom;
setAllowAxesZoom(h,a,false);
h = rotate3d;
setAllowAxesRotate(h,a,false);
imshow('Capture.PNG','parent',a);
%}

rp     = defrp;
rp.phi = 0.5;
rp.dir_light.dir = [0;1;1];
rp.dir_light.intens = 0.6*ones(3,1);
%a1=axes('position',[0.3 0.3 .5 .5]);

%get the updated shape and texture 
shp = model.shapeMU + model.shapePC*(alpha.*model.shapeEV);
tex = model.texMU + model.texPC*(beta.*model.texEV);
%for i = 1:199
%    shp = shp + alpha(i)*(model.shapePC(:,i));
%    tex = tex + beta(i)*(model.texPC(:,i));
%end

display_face(shp, tex, model.tl, rp, GCA);
grid on
set(gca,'color','none')

F = getframe(gcf);
I=F.cdata;