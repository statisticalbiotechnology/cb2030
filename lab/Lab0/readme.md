# Getting your software ready

We suggest you install and access your environment via

## Installing the software with conda (bash)

If you work on Windows, we suggest you install the [Linux subsystem for Windows](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10) first, and follow the instructions for Linux.

1. Install (Mini)conda by following instructions for [Linux](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html) or [MacOS](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html)
2. Clone the course directory by running `git clone https://github.com/statisticalbiotechnology/cb2030.git`.
3. Go to the Lab0 directory (`cd cb2030/lab/Lab0/`)
4. Create the environment (`conda env create -f cb2030-labs-environment.yml`)
5. Activate the environment (`conda activate cb2030`)


## Installing the software with Anaconda (Graphical User Interface)

1. Install Anaconda, you can download it [here](https://www.anaconda.com/products/individual).
2. Download the files needed for the lab [here](https://github.com/statisticalbiotechnology/cb2030/) (Check the green "Code" field in top right corner or (better) write and execute `git clone https://github.com/statisticalbiotechnology/cb2030.git` in your command line (Linux/Mac/[Linux subsystem for Windows](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10)).
3. Open Anaconda Navigator.
4. Environments &#8594; Import.
5. Select the `cb2030-labs-environment.yml` file. 
    * If you are using **Windows**, select the `cb2030-labs-environment-windows.yml` [file](cb2030-labs-environment-windows.yml) instead. 
    * This will install some packages that are required for the labs, it might take some time.
6. Once this is done, we will test to see if everything works correctly.

## Testing if everything installed correctly

If you installed the conda environment through the terminal:
1. Launch **Jupyter Notebook** (`jupyter notebook`, the conda environment needs to be activated, see point nr 5 above).
2. Enter one of the links displayed in the terminal (clicking on it while holding `ctrl` or `Cmd` should work, otherwise you can copy the link and open it in the browser).
Or, if you installed the environment through Anacononda Graphical User Interface:
1. On Anaconda Navigator &#8594; Home, select `cb2030` on the `Applications on:` dropdown menu.
2. Launch **Jupyter Notebook** by clicking **[Launch]**.

The following steps are common regradless of the way you installed the conda environment:
3. Navigate to and open the `Lab0.ipynb` notebook.
4. Run the **first cell** by clicking on **[&#9658; Run]**.
    * You only need to run the first cell to test the software. The rest of the notebook gives you an introduction on how to use Jupyter notebooks.
5. If you didn't get any errors, your **Python** installation is ready! :D

# Introduction to Jupyter notebooks.

The rest of the notebook will give you an overview of how to use Jupyter notebooks, something we will use a lot on the course. You can now try to follow it along.

If you have encountered any problems during the software installation, or have any question on how to use notebooks, bring your questions to lab session **C0**.

---


### Appendix: Binder

If for any reason you cannot install and run Jupyter notebooks on you computer, there is the possibility to run them on the cloud, through a service called Binder.

All you have to do is click this respective icon for the notebook you want: ![Binder](https://mybinder.org/badge_logo.svg)

There are, however, two big caveats of doing this, the first being that the notebook will shut down after 10 minutes of inactivity (if you leave your window open, this will be counted as “activity”), and this means that you can easily lose all your data and progress if you are not carefull.
The second is that it will run much slower in the cloud than on your computer.
