# -*- coding: utf-8 -*-
"""
https://github.com/jdwittenauer/ipython-notebooks
http://www.johnwittenauer.net/machine-learning-exercises-in-python-part-1/
"""
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

path = '\ex1data1.txt'
data = pd.read_csv(path, header=None, names=['xxx', 'xxx'])

data.head()
data.describe()
