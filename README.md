## PhyloguidesR

The 16S rRNA gene has been key to sequence-based phylogenetic microbial
community analyses for over 30 years. Since the full length 16S gene
(~1500 base pairs) is longer than what short-read sequencing
technologies can typically capture, researchers must target a portion of
the gene, or variable region, typically ~250 base pairs in length.

Prior work has shown that the accuracy of phylogenetic trees built from
microbial short read data are more accurate if they are built in context
of full length guide sequences, which allow for a scaffold to improve
phylogenetic context of microbial short read data while building trees.
Later, after the tree is built, the researcher can drop the full length
guides, leaving a phylogenetic tree constructed from short read data
alone.

<img src="images/GuideUsePicture.png" alt="Descriptive alt text" width="400"/>

This publication is currently in the review processes, and I will link
to it when it becomes available. For the meantime, here is the graphical
abstract.

    cat('<embed src="../../manuscript/manuscript_figures/Experimental Overview.png" type="application/png" width="100%" height="600px"/>')

    ## <embed src="../../manuscript/manuscript_figures/Experimental Overview.png" type="application/png" width="100%" height="600px"/>

The prupose of the phyloguidesR package and this tutorial is to provide
you with some helper functions to build trees with full length guide
sequences.

    summary(cars)

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

## Including Plots

You can also embed plots, for example:

![](README_files/figure-markdown_strict/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
