/*
  Project - 3 : Looking at a Pixel
  "Making Things See", page 61
  
  ==============================
  
  Author: Greg Borenstein
*/

//Import the library to use simpleopenNi
import SimpleOpenNI.*;
//Create an Object called kinect
SimpleOpenNI kinect;
//Runs once
void setup()

{
//Canvas Size
  size(1280, 480);
  //Initialize the Kinect object
  kinect = new SimpleOpenNI(this);
  //Grabs the function of the Kinect that access the Depth image on the Kinect
kinect.enableDepth();
//Grabs the function of the Kinect that access the RGB color on the Kinect
kinect.enableRGB();
}

void draw()
{
  //Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  //Create a PImage to hold the data for  kinect.depthImage() that can be called later on
  PImage depthImage = kinect.depthImage();
  //Create a PImage to hold the data for  kinect.rgbImage() that can be called later on  
  PImage rgbImage = kinect.rgbImage();
  //Calls the depth image to point 0,0
  image(depthImage, 0, 0);
  //calls the rgb image to point 0,0
  image(rgbImage, 640, 0);
}
//Fire when the mouse is clicked
void mousePressed() {
  //Create a color variable called c. 
  //Assign c the RGB values at the x,y pixel that the mouse is located at
  color c = get(mouseX, mouseY);
  //Print in the console the values of the Red, the Green, and the Blue
  println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));
}
