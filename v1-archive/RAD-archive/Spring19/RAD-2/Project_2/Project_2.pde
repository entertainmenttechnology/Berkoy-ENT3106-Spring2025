/*
  Project - 2 - Your First Kinect Program
  "Making Things See", page 53
  
  ==============================
  
  Author: Greg Borenstein
*/

//Import the library that gives the ability to use the Kinect Sensor
import SimpleOpenNI.*;
//Create an object called Kinect
SimpleOpenNI kinect;
//Run this one time
void setup()
{
//Create the canvas size 1280 by 480
  size(1280, 480);
//Initialize the Kinect object within SimpleOpenNI
kinect = new SimpleOpenNI(this);
//Grabs the function of the Kinect that access the Depth image on the Kinect
kinect.enableDepth();
//Grabs the function of the Kinect that access the RGB color on the Kinect
kinect.enableRGB();

}
//Runs continuously
void draw()
{
//Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
//Calls the Kinect depth image to the point 0,0
image(kinect.depthImage(), 0, 0);
//Calls the Kinect RGB image to the point 640,0
image(kinect.rgbImage(), 640, 0);

}
