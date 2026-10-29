"""
Example use of pod5 to plot the signal data from a selected read.
"""

import matplotlib.pyplot as plt
import numpy as np

import pod5

# Using the example pod5 file provided
base_dir = "./output"
example_pod5 = base_dir + "/T1_B1_pod5_subset_ITS_FBB34176.pod5"
selected_read_id = 'c10d82c1-9c6a-44af-8065-0aa269619e50'
output_dir = base_dir

with pod5.Reader(example_pod5) as reader:

    # Read the selected read from the pod5 file
    # next() is required here as Reader.reads() returns a Generator
    read = next(reader.reads([selected_read_id]))

    # Get the signal data and sample rate
    sample_rate = read.run_info.sample_rate
    signal = read.signal

    # Compute the time steps over the sampling period
    time = np.arange(len(signal)) / sample_rate

    # Make plot
    fig, ax = plt.subplots(figsize=(14, 5))

    ax.plot(
        time,
        signal,
        color="darkblue",
        linewidth=0.7
    )

    ax.set_title(f"Nanopore raw signal\nRead {selected_read_id}", fontsize=12)
    ax.set_xlabel("Time (seconds)")
    ax.set_ylabel("Signal (pA)")

    ax.grid(True, alpha=0.25)

    # Remove unnecessary borders
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    plt.tight_layout()

    plt.savefig(output_dir + "/" + selected_read_id + "_signal_plot.png", dpi=500)

    plt.close()



