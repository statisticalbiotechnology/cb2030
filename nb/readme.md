# Jupyter Notebooks

Here you can find jupyter notebooks for the Seminars on

* [Hypothesis Testing](testing/readme.md)  
* [Multiple Hypothesis Testing](multiplehypo/readme.md)  
* [Linear Models](linear/readme.md)  
* [Clustering](clustering/readme.md)  
* [PCA](pca/readme.md)  
* [Enrichment](enrichment/readme.md)  

## On-line usage

Most of the contained notebooks can be executed on-line, using services provided by mybinder.org. Just click the small icon present in the readme files of each subfolder, and wait for the notebook to be executed in an online docker container.

## Download
To use this material off-line follow the following steps:

1. Install the anaconda development environment from https://www.anaconda.com/distribution/#download-section
2. Use the links above to download the repository as a zipfile(, or better clone the repository using git).
3. Decend into the newly created cb2030 folder
4. Install the right environment by issuing `conda env create -f environment.yml`
5. Activate your new environment using `conda activate p37`
6. Run the command `jupyter-notebook-3.7 .`
