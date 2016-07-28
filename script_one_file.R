library(bioimagetools)
library(nucim)
# choose RGB file
img = readTIF(file.choose())

# number of slices 
slices = dim(img)[4]

# we need the dimensions of the image in microns
x = attributes(img)$x.resolution
y = attributes(img)$y.resolution
z = as.numeric(attributes(img)$spacing) * slices
# and the dimensions of each voxel
X = x/dim(img)[1]
Y = y/dim(img)[2]
Z = as.numeric(attributes(img)$spacing)
zscale=mean(c(X,Y))/Z

# we assume that the third channel is blue, ie, DAPI
blue = img[,,3,] 

# we mask the kernel
mask = dapimask(blue, c(x,y,z), thresh="auto")

# classify the DAPI channel
classes = classify.single(blue, mask, 7, z=zscale)

# count voxel per class
counts <- table.n(classes, 7)

# percentages
perc <- print(counts/sum(counts)*100, 1)

barplot(perc, names.arg=1:7, xlab="DAPI intensity class", ylab="percentage")
