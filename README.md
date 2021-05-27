# hemocytometerMATLAB
Hemocytometer is a manual cell counting device typically used by cell biologists. The  MATLAB program written here aims to take images from bright-field microscope images and automate cell counting.

The `hemocytometerMain` program is ran from the MATLAB command prompt which calls upon `FindROI` - Find the region of interest (ROI), `hemocytometerCellSeg` - highlight cells on image and export the cell count to an Excel document, `.xlsx`. Additionally `hemocytometerSeparationComparison` - designed to compare two data sets and export in an Excel sheet with a relative difference between the data.

Work in progress:

* Finialisation of the MATLAB code
* Wiki on changable values for optimising cell detection by manipulating ROI
* Adding examples for testing
