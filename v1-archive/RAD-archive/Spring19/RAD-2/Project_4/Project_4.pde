/*
  Project - 4 : A wireless tape measure
  "Making Things See", page 69
  
  ==============================
  
  Author: Greg Borenstein
*/

//Import the library
import SimpleOpenNI.*;
//Create an object called Kinect
SimpleOpenNI kinect;
//Runs once
void setup()
{
//Create a canvas size 640 by 480
  size(640, 480);
  //initialize the object
  kinect = new SimpleOpenNI(this);
  //enable the depth sensor on the Kinect
  kinect.enableDepth();
}
//runs continuously 
void draw()
{
//Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  //Create a PImage called depthImage to hold the Kinects Depth Image
  //This is so we can call it later on
  PImage depthImage = kinect.depthImage();
  //Calls the depth image to the point 0,0
  image(depthImage, 0, 0);
}
//Called when the mouse is pressed
void mousePressed() {
  //assigns the values given from the kinect to an array called depthvalues
  int[] depthValues = kinect.depthMap();
  //clickposition shows where on the screen the user has clicked
  int clickPosition = mouseX + (mouseY * 640);
  //clicked depth takes the value of the depth at the certain click position
  int clickedDepth = depthValues[clickPosition];
  //calculates the number of inches given from the depth sensor
  float inches = clickedDepth / 25.4;
  //prints to the console # of inches
  println("inches: " + inches);
}
