# Logistic Regression simple example
'''
http://www.analyticsvidhya.com/blog/2014/07/baby-steps-learning-python-data-analysis/
'''
import numpy as np
import matplotlib as plt
from sklearn import datasets
from sklearn import metrics
from sklearn.linear_model import LogisticRegression

dataset = datasets.load_iris()

# model
model.fit(dataset.data, dataset.target)
LogisticRegression(C=1.0, class_weight=None, dual=False, fit_intercept=True, intercept_scaling=1, penalty='12', random_state=None, told=0.0001)

# validation
expected = dataset.target
predicted = model.predict(dataset.data)
print(metrics.classification_report(expected, predicted))
print(metrics.confusion_matrix(expected, predicted))
