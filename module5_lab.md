---
layout: tutorial_page
permalink: /GenMed_2017_module5_lab
title: GenMed Lab 5
header1: Workshop Pages for Students
header2: Genomic Medicine 2017 Module 5 Lab
image: /site_images/CBW_population_icon.jpg
home: https://bioinformaticsdotca.github.io/genomic_medicine_2017
---

# Module 5: Available Epigenomics Data and Resources

by Guillaume Bourque, *PhD*

## Introduction

### Description of the lab
In this module's lab, we will explore some of the tools that were covered in the lecture.

* First, we will learn how to use the IHEC Data Portal's tools to fetch datasets of interest.
* Second, we will explore the ENCODE Data Portal.
* Third, we will explore the GTEx Data Portal.

### Local software that we will use
* A web browser


## Tutorial

### 1- IHEC Data Portal

#### Exploring available datasets
* Open a web browser on your computer, and load the URL [http://epigenomesportal.ca/ihec](http://epigenomesportal.ca/ihec) .

* In the Overview page, click on the "View all" button.

* You will get a grid with all available datasets for IHEC Core Assays.
    * You can filter visible datasets in the grid using the filtering options on the right side of the grid.

* Select only the datasets coming from the CEEHRC consortium, you should see something like this:

<img src="https://bioinformaticsdotca.github.io/Genomic_Med_2017/img/ihec_data.jpeg" alt="IMG" width="750" />

* Explore the various filtering options on the right, is there a way to restrict this list to your tissue of interest?

* Can you sort and re-organize the grid differently? Try sorting by *Cell type category*.

#### Visualizing the tracks

* Select the 3 H3K27ac ChIP-seq datasets in *B cells - Other*
   * Notice the importance of ontologies...
   
* Select the 3 mRNA-seq datasets in the same cell type

* Click on the button *Visualize in Genome Browser* just below the grid
   * You can see that the datasets are being displayed at a mirror of the UCSC Genome Browser. These are all peaks and signal for the chosen H3K27ac ChIP-Seq and RNA-seq datasets. 

* (Optional) If the browser is slow, notice that in the address bar you have something like:
   * http://ucscbrowser.genap.ca/cgi-bin/hgTracks?hubClear=http://epigenomesportal.ca/cgi-bin/hub.cgi?session=3113&db=hg19
   * The second portion of the address is actually a track hub that you can load in any UCSC Genome Browser
   * Go to the main UCSC genome browser: http://genome.ucsc.edu/cgi-bin/hgGateway
   * Click on MyData -> Track Hubs, then click on My Hubs
   * Copy the URL, e.g. http://epigenomesportal.ca/cgi-bin/hub.cgi?session=3113&db=hg19
   
* Now, type in the name of the gene CD79A (a gene expressed in B cells)
   
* In the Genome Browser, expand the ChIP-seq tracks and RNA-seq tracks by changing visibility from "pack" to "full" and clicking the "Refresh" button.

* Zoom out 10X, do you see the potential regulatory regions around this genes?

* You should get something like this: [Solution](https://github.com/bioinformaticsdotca/Genomic_Med_2017/blob/master/img/CD79A.jpg)

* Can you find another gene expressed in B cells?

#### Tracks correlation
You can get a whole genome overview of the similarity of a group of tracks by using the Portal's correlation tool.

* Select 3 RNA-seq datasets in *Adipocyte of omentum tissue*

* Select 3 RNA-seq datasets in *induced pluripotent stem cells*

* Click on the button *Correlate datasets* just below the grid, you should see something like:

[Solution](https://github.com/bioinformaticsdotca/Genomic_Med_2017/blob/master/img/correlation.jpeg)

* Can you find a outlier/bad datasets?
   * Try correlating the 8 *amygdala - Other* with the 5 *B cell - Blood* H3K27ac datasets 

#### Download tracks or metadata
You can also download these tracks locally for visualization or further analysis, or view the metadata.

* Go back to the IHEC Data Portal tab.
* Click on the *Download tracks* button at the bottom of the grid.
* Use the download links to download a few of the tracks.
* Go back to the IHEC Data Portal tab.
* Click on the *Get metadata* button at the bottom of the grid.

#### Permanent session
Finally, you can create a permanent session corresponding to your current selections in the portal

* Go back to the IHEC Data Portal tab.
* Make a selection of datasets and click on the *Save session* button at the bottom of the grid.
* You now have a nicer and permanent view of the data you have selected
   * You can use this ID and assocaited web address (e.g. http://epigenomesportal.ca/ihec/IHECDP00000092) and share it with your collaborators or in publications
* A permanent session also has links to all the raw datasets
* Is is as easy that access that data?

### 2- ENCODE Data Portal

TODO

### 3- GTEx Data Portal

TODO

### Congrats, you're done!

