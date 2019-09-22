function[compImg] = ColorReduce(Img, k)

% read the image input as a three p x q matrices (3 dim array). p and q represent the
% number of pixels for a p*q resolution image, However we have created
% three matrices that separate the comosited Red, green, and blue values 
%per pixel (hence the 3dim array).
preArr3D = double(imread(Img));



sizeOld = size(preArr3D);% get the size of preArr3D
p = sizeOld(1);% p and q are the resolution of the image
q = sizeOld(2);



reshapedImg = reshape(preArr3D, p*q, 3);% creat a (p*q)x3 matrix, where each 
%column contains the red, gree, blue value per pixel. In other words, 
%we have the the coordinates of each pixel in (red,green,blue) space. 



%Now use k-means clustering to assign each pixel into k clusters in rgb space.
%Each cluster's centroid point will replace the rgb values of every pixel assigned 
%to that cluster. idx is a column vector that indexes each pixel by their 
%assigned cluster and C is a K x 3 matrix that contains the centroid points. 
[idx, C] = kmeans(reshapedImg, k);


%centroidMat is a (p*q)x3 that now has the centroid coordinates for
%each cluster. The compression is essentially done now, we just need to
%transform the cluster back to a rgb sepated 3D array that is now composed
%of just k colors ( the centroids of each cluster). 
centroidMat = C(idx, :);%read: extract idx many values from all columns.
postArr3D = reshape(centroidMat, p, q, []);



% display functions are sensitive to the input data types, so we want our 
%double valued postArr3D to be 8-bit data type for imshow()
imshow(uint8(postArr3D))
end
