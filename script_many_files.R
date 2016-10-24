library(bioimagetools)
library(nucim)

# choose one of the files in a folder of RGB files
folder = file.choose()
f = unlist(gregexpr("/",folder))
folder = substr(folder,1,f[length(f)])

# scripts can use parallel computing, if available (not under windows)
nr.cores=ifelse(.Platform$OS.type=="windows", 1, 4)

# split channels
splitchannels.folder(folder, rgb.folder="./", cores=nr.cores)

# masks
dapimask.folder(folder, cores=nr.cores)

# classification 
classify.folder(folder, 7, cores=nr.cores)

# results will be in folders "class7" und "class7-n"
