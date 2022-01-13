t1 = getTime();
attenuation = 0.8;
imageID = getImageID();
w = getWidth();
h = getHeight();
d = nSlices;
title = getTitle();
bd = bitDepth();

newImage("attenuated ("+attenuation+") mip of " + title, bd+"-bit", w, h, 1);
resID = getImageID();
selectImage(imageID);
setBatchMode("hide");
for (x = 0; x < w; x++) {
	showProgress(x+1, w);
	for (y = 0; y < h; y++) {
		pixels = newArray(d);
		for(z=1; z<=d; z++) {	
			setSlice(z);
			pixels[z-1] = getPixel(x, y) * pow(((d+1)-z)/(d+1), attenuation);
		}
		Array.sort(pixels);
		selectImage(resID);
		setPixel(x, y, pixels[pixels.length-1]);
		selectImage(imageID);
	}
}
setBatchMode("exit and display");
selectImage(resID);
t2 = getTime();
print("attenuated projection took: " + (t2-t1)/1000 + "s");


