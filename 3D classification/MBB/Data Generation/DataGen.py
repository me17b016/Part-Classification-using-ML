import os
import vtk
import csv

folders = ['BOLTS AND SCREW', 'NUTS']
directory = "/content/drive/My Drive/DATASET_FOR_3D/"
data = [("label", "R1", "R2", "R3", "D")]
# "length", "breadth", "height", 

for foldername in folders:
  tem_directory = directory + foldername
  for filename in os.listdir(tem_directory):
      if filename.endswith(".stl") or filename.endswith(".STL"): 
          path = os.path.join(tem_directory, filename)
          reader = vtk.vtkSTLReader()
          reader.SetFileName(path)
          bounds = [0 for i in range(6)]
          mapper = vtk.vtkPolyDataMapper()
          mapper.SetInputConnection(reader.GetOutputPort())
          mapper.GetBounds(bounds)
          L = bounds[1] - bounds[0]
          B = bounds[3] - bounds[2]
          H = bounds[5] - bounds[4]
          D = L**2 + B**2 + H**2
          model_data = (foldername, L / B, B / H, H / L, D);
          data.append(model_data)
      else:
          continue
          
print(len(data))
csvfile = open('dataset.csv', 'w', newline='')
obj = csv.writer(csvfile)
obj.writerows(data)
csvfile.close()
