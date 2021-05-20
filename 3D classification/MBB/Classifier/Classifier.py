##------------ Importing Modules ------------##
# Import DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier
# Import train_test_split
from sklearn.model_selection import train_test_split
# Import accuracy_score
from sklearn.metrics import accuracy_score
# Import classification_report
from sklearn.metrics import classification_report 
# Import pandas
import pandas as pd
# Import numpy
import numpy as np

##------------ Code starts here ------------##

# Importing Dataset
def importData():
  data = pd.read_csv('dataset.csv', sep= ',', header = None) 
  print ("Dataset: ")
  print(data.head())
  print("\n------------------------") 
  return data
# Spliting Dataset
def splitDataset(data):
  X = data.values[1:, 1:]
  Y = data.values[1:, 0]
  X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3, random_state=1)
  return X, Y, X_train, Y_train, X_test, Y_test

# Train Decision tree
def trainModel(X_train, Y_train):
  dt = DecisionTreeClassifier(criterion="gini", random_state=1, max_depth=3, min_samples_leaf=3)
  dt.fit(X_train, Y_train)
  return dt

# Prediction 
def prediction(dt, X_test):
  y_pred = dt.predict(X_test)
  return y_pred

# Accuracy Score
def accuracyScore(Y_test, Y_pred):
  print("Accuracy")
  print(accuracy_score(Y_test, Y_pred) * 100)
  print("\n------------------------")
  print("Classification Report")
  print(classification_report(Y_test, Y_pred))

# main func:
def main():
  data = importData()
  X, Y, X_train, Y_train, X_test, Y_test = splitDataset(data)
  dt = trainModel(X_train, Y_train)
  Y_pred = prediction(dt, X_test)
  accuracyScore(Y_test, Y_pred)

if __name__=="__main__":
  # print("hello")
  main()
