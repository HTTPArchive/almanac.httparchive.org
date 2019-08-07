import os
from io import BytesIO

import matplotlib
import matplotlib.pyplot as plt
import pandas as pd

OUTLIER_MIN = 30

# plt.style.use(['seaborn-white', 'seaborn-paper'])
# plt.tight_layout()

def generate_histogram(year, key, x, y, x_label):
    path = 'data/%s/%s.json' % (year, key)

    print('\nGenerating histogram from the following file: %s' % path)

    data = pd.read_json(path)
    original_length = len(data)

    data = data[data.cdf < 0.95]
    print('Reduced the data set from %s to %s to fall within acceptable margins.' % (original_length, len(data)))
    
    data[y] *= 100

    fig, ax = plt.subplots()   

    ax.bar(data[x], data[y], width=8, align='edge')
    ax.set_xlabel(x_label)
    ax.set_ylabel('Probability density')

    # REMOVE - Just for testing.
    # plt.savefig('%s.svg' %  key)

    buf = BytesIO()
    plt.savefig(buf, format='svg')
    return buf.getvalue().decode('UTF-8')


# REMOVE - Just for testing
# generate_histogram(2019, '01_01', 'kbytes', 'pdf', 'KB')
