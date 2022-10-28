##import the picture as png

Irgb = imread('peppers.png');


figure
image(Iy,'CDataMapping','scaled')
colormap('gray')
title('Iy')


You can use other filters to obtain the image gradients, such as the Sobel operator or the Prewitt operator.





Define Fuzzy Inference System (FIS) for Edge Detection
edgeFIS = mamfis('Name','edgeDetection');
edgeFIS = addInput(edgeFIS,[-1 1],'Name','Ix');
edgeFIS = addInput(edgeFIS,[-1 1],'Name','Iy');

sx = 0.1;
sy = 0.1;
edgeFIS = addMF(edgeFIS,'Ix','gaussmf',[sx 0],'Name','zero');
edgeFIS = addMF(edgeFIS,'Iy','gaussmf',[sy 0],'Name','zero');

Specify the intensity of the edge-detected image as an output of edgeFIS.
edgeFIS = addOutput(edgeFIS,[0 1],'Name','Iout');

Specify the triangular membership functions, white and black, for Iout.
wa = 0.1;
wb = 1;
wc = 1;
ba = 0;
bb = 0;
bc = 0.7;
edgeFIS = addMF(edgeFIS,'Iout','trimf',[wa wb wc],'Name','white');
edgeFIS = addMF(edgeFIS,'Iout','trimf',[ba bb bc],'Name','black');

Plot the membership functions of the inputs and outputs of edgeFIS.
figure
subplot(2,2,1)
plotmf(edgeFIS,'input',1)
title('Ix')
subplot(2,2,2)
plotmf(edgeFIS,'input',2)
title('Iy')
subplot(2,2,[3 4])
plotmf(edgeFIS,'output',1)
title('Iout')


output

Plot the membership functions of the inputs and outputs of edgeFIS.

Specify FIS Rules
Add rules to make a pixel white if it belongs to a uniform region and black otherwise.
r1 = "If Ix is zero and Iy is zero then Iout is white";
r2 = "If Ix is not zero or Iy is not zero then Iout is black";
edgeFIS = addRule(edgeFIS,[r1 r2]);
edgeFIS.Rules


Evaluate FIS
Evaluate the output of the edge detector for each row of 
pixels in I using corresponding rows of Ix and Iy as inputs.

Ieval = zeros(size(I));
for ii = 1:size(I,1)
    Ieval(ii,:) = evalfis(edgeFIS,[(Ix(ii,:));(Iy(ii,:))]');
end


Plot the detected edges.
figure
image(Ieval,'CDataMapping','scaled')
colormap('gray')
title('Edge Detection Using Fuzzy Logic')















Convert Irgb to grayscale so that you can work with a 2-D array instead of a 3-D array. 
To do so, use the rgb2gray function.
Igray = rgb2gray(Irgb);

figure
image(Igray,'CDataMapping','scaled')
colormap('gray')
title('Input Image in Grayscale')


##Convert Image to Double-Precision Data
I = im2double(Igray);



##Obtain Image Gradient
Gx = [-1 1];
Gy = Gx';
Ix = conv2(I,Gx,'same');
Iy = conv2(I,Gy,'same');


##Plot the image gradients.

figure
image(Ix,'CDataMapping','scaled')
colormap('gray')
title('Ix')

figure
image(Iy,'CDataMapping','scaled')
colormap('gray')
title('Iy')


###Define Fuzzy Inference System (FIS) for Edge Detection
edgeFIS = mamfis('Name','edgeDetection');

edgeFIS = addInput(edgeFIS,[-1 1],'Name','Ix');
edgeFIS = addInput(edgeFIS,[-1 1],'Name','Iy');

sx = 0.1;
sy = 0.1;
edgeFIS = addMF(edgeFIS,'Ix','gaussmf',[sx 0],'Name','zero');
edgeFIS = addMF(edgeFIS,'Iy','gaussmf',[sy 0],'Name','zero');

edgeFIS = addOutput(edgeFIS,[0 1],'Name','Iout');

wa = 0.1;
wb = 1;
wc = 1;
ba = 0;
bb = 0;
bc = 0.7;
edgeFIS = addMF(edgeFIS,'Iout','trimf',[wa wb wc],'Name','white');
edgeFIS = addMF(edgeFIS,'Iout','trimf',[ba bb bc],'Name','black');



figure
subplot(2,2,1)
plotmf(edgeFIS,'input',1)
title('Ix')
subplot(2,2,2)
plotmf(edgeFIS,'input',2)
title('Iy')
subplot(2,2,[3 4])
plotmf(edgeFIS,'output',1)
title('Iout')

###Specify FIS Rules

r1 = "If Ix is zero and Iy is zero then Iout is white";
r2 = "If Ix is not zero or Iy is not zero then Iout is black";
edgeFIS = addRule(edgeFIS,[r1 r2]);
edgeFIS.Rules

###Evaluate FIS

Ieval = zeros(size(I));
for ii = 1:size(I,1)
    Ieval(ii,:) = evalfis(edgeFIS,[(Ix(ii,:));(Iy(ii,:))]');
end


##Plot Results
figure
image(I,'CDataMapping','scaled')
colormap('gray')
title('Original Grayscale Image')

###Plot the detected edges.
figure
image(Ieval,'CDataMapping','scaled')
colormap('gray')
title('Edge Detection Using Fuzzy Logic')




