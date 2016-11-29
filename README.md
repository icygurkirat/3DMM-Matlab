# 3DMM-Matlab
This is a matlab implementation of 3D morphable model as discussed in this <a href = 'http://gravis.dmi.unibas.ch/publications/Sigg99/morphmod2.pdf'> paper </a>by Volker Blanz and Thomas Vetter.
# <b>Data-Base</b>
To use this code you will need the data set provided by the original authors. We do not have the license to distribute it. However, You can request for the data set <a href = 'http://faces.cs.unibas.ch/bfm/main.php?nav=1-0&id=basel_face_model'>here</a>. Keep the .mat files in the same directory.
# <b>Using the code</b>
<p>
<b>EditorApp.m</b>: Running this app will open a gui which can be used to generate various shapes and texture of faces. Also you can add attributes like age, gender, weight and height.
</p>
<p>
<b>demo.m</b>: Running this script will fit the model to the image in Capture.PNG and generate a 3d output.
</p>
#<b>To see previous results</b> 
run:<br>
load('results.mat')<br>
display_face(shp,tex,model.tl,defrp)
<p>
Rest of the scripts are utility scripts.
</p>
