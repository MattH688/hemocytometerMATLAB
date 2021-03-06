# hemocytometerMATLAB
Hemocytometer is a manual cell counting device typically used by cell biologists. The  MATLAB program written here aims to take images from bright-field microscope images and automate cell counting. The process has been somewhat optimised for a smartphone taking images down an eye-piece but should be applicable to other image inputs.

The `hemocytometerMain` program is ran from the MATLAB command prompt which calls upon `FindROI` - Find the region of interest (ROI), `hemocytometerCellSeg` - highlight cells on image and export the cell count to an Excel document, `.xlsx`. Additionally `hemocytometerSeparationComparison` - designed to compare two data sets and export in an Excel sheet with a relative difference between the data.

Work in progress:

* Finialisation of the MATLAB code - Known error `.png` is rotated anti-clockwise, 90 degrees during processing.
* Wiki on changable values for optimising cell detection by manipulating ROI.
* ~~Adding examples for testing.~~ 
* Incorporating colour detection for Trypan Blue live dead staining.


<p float="left">
  <img src="https://github.com/MattH688/hemocytometerMATLAB/blob/main/ExampleData/75ulI/20190918_113157.jpg" height="450">
  <img src="https://github.com/MattH688/hemocytometerMATLAB/blob/main/ExampleData/75ulI/20190918_113157.png" height="450">
  <img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Hemocytometer.jpg" height="500">
</p>
