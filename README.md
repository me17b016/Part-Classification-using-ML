# Part-Classification-using-ML
Part Classification using ML

# 2D Classification

MATLAB file: 2D.m 

Specify the folder where your dataset is located
If you are using MATLAB in your local machine then mention the full address of the folder in the drive.
Or, if you are using MATLAB online, then mention the address of folder w.r.t MATLAB online Drive. 

# 3D Classification

Two different algorithms are used:-

#### 1 Minimum Bounding Box (MBB)
#### 2 Multi-View CNN (MVCNN)

## MBB

Python files: DataGen.py (for data generation), Classifier.py (for classification)

## Steps to run MBB

1. Mention correct path in `directory` variable in line 6 of `DataGen.py`, run the file.
2. `dataset.csv` will be generated.
3. Finally, run `Classifier.py`.


## MVCNN

Matlab files: DataGen.m, PlotMesh.m

Google Colab (Python Notebook): Car_Plugs_Multi_View_Image_Classification.ipynb

`DataGen.m` generates data by using STL files. It captures different views of a model (stl file) from different view point (by mentioning Azimuthal and Elevation angle). After running this file a folder named `dataset` and a file `train.csv` will be generated.

`PlotMesh.m` is responsible for different type of style and shaded for the view captured from a stl file. Different styles are there: `mesh`, `solid`, etc.

## Steps to run MVCNN

1. Mention correct path of folder in line 32 and all other places wherever is necessary (Current we are using MATLAB online drive for all) of `DateGen.m`.
2. Run `DataGen.m`.
3. A folder named `dataset` and a file `train.csv` will be generated.
4. Mention corrent path of folder in python notebook.




