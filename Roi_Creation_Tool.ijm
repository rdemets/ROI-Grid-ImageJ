///////////////////////////////////////////////////////////////////////////////////////
// Macro highly inspired from the Click Coordinates Tool
//------------------- C l i c k   C o o r d i n a t e s   T o o l  -------------------
//
// On each click into an image, the x, y coordinates of the point are 
// written into the "Results" window. 4 boxes are displayed around each new center
// in the NSEW coordinates. Right click on the toolbar logo allows to change parameters
// Macro author R. De Mets
// Version : 0.0.1, 02/08/2022




var direction_distance = 500;
var box_distance = 50;
var box_Size = 100;

macro "Click Coordinates Tool - C000P515335150P5a595775950D46D64P88ab0D8bDa8Pe8cc0Pc8c90D9fDbfDdf" {
	requires("1.37e");
	roiManager("reset")
	getCursorLoc(x, y, z, flags);
	getPixelSize(unit, pw, ph, pd);
	offsetX = 100;
	offsetY = 100;
	distances = split(direction_distance, ",");
	for (n = 0; n < distances.length; n++) {

		for (i = 0; i < 4; i++) {
			if (i==0) { // East
				new_x = x + distances[n];
				new_y = y;
			}
			if (i==1) { // West
				new_x = x - distances[n];
				new_y = y;
			}	
			if (i==2) { // North
				new_x = x;
				new_y = y - distances[n];
			}	
			if (i==3) { // South
				new_x = x;
				new_y = y + distances[n];
			}					

			makeRectangle(new_x+box_distance, new_y-box_distance-box_Size, box_Size, box_Size); // top right
			roiManager("Add");
			makeRectangle(new_x+box_distance, new_y+box_distance, box_Size, box_Size); // bottom right
			roiManager("Add");
			
			makeRectangle(new_x-box_distance-box_Size, new_y-box_distance-box_Size, box_Size, box_Size); // top left
			roiManager("Add");
			makeRectangle(new_x-box_distance-box_Size, new_y+box_distance, box_Size, box_Size); // bottom left
			roiManager("Add");
		}
	}

	
	setResult("X", nResults, x);
	setResult("Y", nResults-1, y);
	updateResults();
	roiManager("Show All");
}

macro "Click Coordinates Tool Options..." {
	requires("1.37e");
	Dialog.create("Roi selection tools");
	Dialog.addString("Distance from the centre separated with coma ? (in microns) ", "500");
	Dialog.addNumber("Distance between boxes ? (in microns) ", "50");
	Dialog.addNumber("Box size in microns", "100");
	Dialog.show();
	direction_distance = Dialog.getString();
	box_distance = Dialog.getNumber();
	box_Size = Dialog.getNumber();




}