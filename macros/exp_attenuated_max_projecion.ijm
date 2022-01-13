t1 = getTime();
attenuation = 0.8;
imageID = getImageID();
w = getWidth();
h = getHeight();
d = nSlices;
title = getTitle();

bd = bitDepth();

newImage("attenuated ("+attenuation+") mip of " + title, "16-bit", w, h, 1);
resID = getImageID();
selectImage(imageID);
setBatchMode("hide");
for (x = 0; x < w; x++) {
	showProgress(x+1, w);
	for (y = 0; y < h; y++) {
		pixels = newArray(d);
		sum = 0;
		for(z=1; z<=d; z++) {	
			setSlice(z);
			pixel = getPixel(x, y);
			sum += pixel/65535;
			pixels[z-1] = pixel * exp(-attenuation * (sum - 1));
		}
		Array.getStatistics(pixels, min, max, mean, stdDev);
		selectImage(resID);
		setPixel(x, y, max);
		selectImage(imageID);
	}
}
selectImage(resID);
setBatchMode("exit and display");
t2 = getTime();
print("attenuated projection took: " + (t2-t1)/1000 + "s");