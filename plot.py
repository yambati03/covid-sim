import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sys

names = ["healthy", "infected", "recovered", "deceased"]
df = pd.read_csv(sys.argv[1], names=names)

x = np.arange(0, len(df.index))
healthy = df["healthy"]
infected = df["infected"]
recovered = df["recovered"]
deceased = df["deceased"]

color_map = ["#d43949", "#3ba852", "#646464", "#464646"]
y = np.vstack([infected, healthy, recovered, deceased])
fig, ax = plt.subplots()
ax.stackplot(x, y, colors=color_map)
plt.show()
