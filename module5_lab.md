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

* Can you sort and re-organize the grid differently? Try sorting by tissue.

#### Visualizing the tracks

* Select the 3 H3K27ac ChIP-seq datasets in *B cells - Other*
   * Notice the importance of ontologies...

* Click on the button *Visualize in Genome Browser* just below the grid
   * You can see that the datasets are being displayed at a mirror of the UCSC Genome Browser. These are all peaks and signal for the chosen H3K427ac ChIP-Seq and RNA-seq datasets. In the Genome Browser, you can expand the tracks by changing visibility from "pack" to "full" and clicking the "Refresh" button.

* Now, type in the name of the gene CD79



* Select 3 RNA-seq datasets in *Adipocyte of omentum tissue*

* Select 3 RNA-seq datasets in *induced pluripotent stem cells*

* Click on the button *Correlate datasets* just below the grid, you should see something like:

[Solution](https://github.com/bioinformaticsdotca/Genomic_Med_2017/blob/master/img/correlation.jpeg)

#### Visualizing the tracks

* Select "Visualize in Genome Browser"
    * You can see that the datasets are being displayed at a mirror of the UCSC Genome Browser. These are all peaks and signal for the chosen muscle H3K427ac ChIP-Seq datasets. In the Genome Browser, you can expand the tracks by changing visibility from "pack" to "full" and clicking the "Refresh" button.

<img src="https://bioinformatics-ca.github.io/2016_workshops/epigenomics/img/module4_portal_fullTrackView.png" alt="IMG" width="750" />
    
* You can also download these tracks locally for visualization in IGV. (You can skip this step if you're comfortable with IGV already)
    * Go back to the IHEC Data Portal tab.
    * Click on the "Download tracks" button at the bottom of the grid.
    * Use the download links to download a few of the tracks.
    * Open them in IGV.

#### Tracks correlation
You can get a whole genome overview of the similarity of a group of tracks by using the Portal's correlation tool.

* From the filters at the bottom of the grid, add back datasets for all tissues.

* Select all ChIP-Seq marks for the cell type "Bone Marrow Derived Mesenchymal Stem Cell Cultured Cell".

<img src="https://bioinformatics-ca.github.io/2016_workshops/epigenomics/img/module4_portal_roadmap_chipseq.png" alt="IMG" width="750" />

* At the bottom of the grid, click on the button "Correlate tracks".

* You will see that tracks seem to correlate nicely, with activator marks clustering together and repressor marks forming another group. You can zoom out the view at the upper right corner of the popup.

* You can also use the correlation tool to assess whether datasets that are supposed to be similar actually are.
    * Activate the track hubs for all consortia.
    * Click on the grid cell for cell type "B Cell" and assay "H3K27ac".
    * Click on "Correlate tracks".
    * One dataset seems to be an outlier... This is either a problem with the quality of the dataset, or the underlying metadata can indicate that something is different (disease status or some other key element).

<img src="https://bioinformatics-ca.github.io/2016_workshops/epigenomics/img/module4_portal_BCell.png" alt="IMG" width="750" />

### 2- ENCODE Data Portal

TODO

### 3- GTEx Data Portal

TODO

### Congrats, you're done!

