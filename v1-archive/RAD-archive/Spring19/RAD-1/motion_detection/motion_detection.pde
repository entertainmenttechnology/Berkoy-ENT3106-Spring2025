/* --------------------------------------------------------------------------
 * Example 16-12
 * --------------------------------------------------------------------------
 * Motion Detection
 * --------------------------------------------------------------------------
 * prog:  Daniel Shifman
 * ----------------------------------------------------------------------------
 */
import processing.video.*; //<-- import library
// Variable for capture device
Capture video; // <--create a Capture object named video
// Previous Frame
PImage prevFrame; // <-- create a PImage named prevFrame
//reference: https://processing.org/reference/PImage.html
// How different must a pixel be to be a "motion" pixel
float threshold = 50;
String[] listOfCameras;//<-- create a list of available cameras

void setup() { //<-- create a function setup to run it once
  size(320, 240); //<-- set the size of a canvas to 320X240
  // Using the default capture device
  video = new Capture(this, width, height); //<--initialize the video as a new Capture object with parent this and width and height
  listOfCameras = Capture.list();//<-- assign the list of cameras from Capture object to variable listOfCameras
  for(int i = 0; i < listOfCameras.length; i++){//<--for loop to print the list of cameras
    println(listOfCameras[i]);
  }

  video.start(); //<-- starting the capturing of frames from available camera
  // Create an empty image the same size as the video
  prevFrame = createImage(video.width, video.height, RGB); //<-- create a PImage and assign to prevFrame variable as a format RGB
  //reference: https://processing.org/reference/createImage_.html
  //println(video.pixels);
}
  // New frame available from camera
void captureEvent(Capture video) {
  // Save previous frame for motion detection!!
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width,video.height);
  prevFrame.updatePixels();
   //println(prevFrame.pixels);
  //reference: https://processing.org/reference/updatePixels_.html
  video.read(); // <-- reads the current video frame
}

void draw() {
  background(0); //<-- update background with a black color
  // If you want to display the videoY
  // You don't need to display it to analyze it!
  imageMode(CENTER);
  image(video, width/2, height/2); //<--add image of video frame to canvas at point 0, 0. 
  loadPixels(); //<-- function to load snapshot of image into pixels[].
  //reference: https://processing.org/reference/loadPixels_.html
  video.loadPixels();//<-- same as before, it is just this time to load into video.
  prevFrame.loadPixels();//<-- same as before, but into prevFrame
  // Begin loop to walk through every pixel
  // Start with a total of 0
  float totalMotion = 0; //
  
  // Sum the brightness of each pixel
  for (int i = 0; i < video.pixels.length; i++) {
    color current = video.pixels[i]; //<-- choose color in pixels array of object video and assign to color variable named current
    // Step 2: What is the current color?
    color previous = prevFrame.pixels[i]; //<-- do the same thing as above, but choose prevFrame.
    // Step 3: What is the previous color?
    // Step 4: Compare colors (previous vs. current)
    float r1 = red(current); 
    float g1 = green(current);
    float b1 = blue(current);
    float r2 = red(previous);
    float g2 = green(previous);
    float b2 = blue(previous);
    float diff = dist(r1, g1, b1, r2, g2, b2); //Dist calculates the distance between r1 -> r2, g1 -> g2, b1 -> b2.
    totalMotion += diff; //totalMotion is cumulated by diff float.
  }
  
  float avgMotion = totalMotion / video.pixels.length; //<-- avgMotion we need to draw a circle
  //println(avgMotion);
  
  // Draw a circle based on average motion
  
  float r = avgMotion * 2;//radius of a circle
  fill(r, r, r);//fill of a circle
  ellipse(width/2, height/2, r, r);//circle
}
