/* --------------------------------------------------------------------------
 * Example 16-1, 16-2 
 * --------------------------------------------------------------------------
 * Display Image, Manipulate Image
 * --------------------------------------------------------------------------
 * prog:  Daniel Shifman
 * ----------------------------------------------------------------------------
 */
int x = 0;
import processing.video.*; //<-- import video library 
Capture video; //<-- initialize a Capture object named video
void setup() { //<--- create function setup
  size(320, 240); //<-- create a canvas with width 320px by height 240px
  video = new Capture(this, 320, 240); 
  // <-- create new Capture with parent this, and requestWidth of 320 and requestHeight with 240
  video.start();//<-- function to start capturing frames
}

void captureEvent(Capture video) {//<--function to capture with a property video
  video.read(); //<-- read the current video frame
}

void draw() { //<--fucntion to draw on a canvas
  if (x==0) // <-- check to see what state the program is in
  {
    background(255); // <--background to white
    imageMode(CORNER); // <--Image mode set to start at the top left corner
    noTint(); // <-- turn off any tint to the video
    image(video, 0, 0); // <-- Display the video at the origin, 0,0
  }
  if (x==1) // <-- check to see what state the program is in
  {
    background(255); //<--create a white background 
    tint(mouseX, mouseY, 255);//<-- function to use mouseX and mouseY values to change rgb values of tint
    translate(width/2, height/2); //<-- function to replace starting points of image from 0,0 to width/2, height/2.
    imageMode(CENTER);//<-- Use CENTER as a manipulating point for an image
    rotate(PI/4); //<-- Rotate image to 45 degrees
    image(video, 0, 0, mouseX, mouseY); // <-- show image of a video on canvas with starting points 0, 0, and width and height of an image comparable to MouseX and MouseY
  }
  println(x); // <-- check to see what state the program is in
}

void mousePressed() //<-- check to see if the mouse is pressed
{
  if (x == 0) // <-- check to see what state the program is in
  {
    x = 1; // <-- change to the other state
  } else if (x== 1) // <-- check to see what state the program is in
  {
    x=0; // <-- change to the other state
  }
}
