import numpy as np

data = np.random.random(size=20)
smooth = mean3filter(data)

from matplotlib import pyplot

fig, axes = pyplot.subplots()
axes.plot(data, 'x') 
axes.plot(smooth, '--') 
fig.show() 
