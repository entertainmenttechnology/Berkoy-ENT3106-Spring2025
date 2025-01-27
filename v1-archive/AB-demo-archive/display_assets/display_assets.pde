
////////////////////////////////////////////////////////////////////////////////////////////////////
/*
MULTI-DISPLAY TEST WITH ASSETS
 Triple-display output: laptop screen, monitor, projector 
 Riffing off of Alberto's sketch.
 
 NOTES: 
 Calibrate display arrangement in system preferences. Drag output window to align.
 Uses Minim Library for sound. Install from Processing Contributed Libraries.
 Reference at http://code.compartmental.net/minim/ under AudioPlayer
 */
////////////////////////////////////////////////////////////////////////////////////////////////////

import processing.video.*;
import ddf.minim.*;

//display dimensions
int display1_width = 1920;
int display2_width = 1920;
int display_height = 1080; //display heights must match
int display_width = display1_width + display2_width; //total width

Minim minim; //Minim object

//create objects for sample assets
PImage face1, face2, face3;
PImage back1, back2, back3, back4, back5;
Movie video1;
Movie video2;
Movie video3;
AudioPlayer sound1;
AudioPlayer sound2;

//object for current sound loaded
AudioPlayer sound; 

//what's displayed
PImage display1_image;  //image on display 1
PImage display2_image;  //image on display 2 
Movie display1_video; //video on display 1
Movie display2_video;  //video on display 2
//to display or not to display
boolean display1_image_visible=false;
boolean display2_image_visible=false;
boolean display1_video_visible=false;
boolean display2_video_visible=false;


void setup() {
  size(3840, 1080);  //enter number parameters ****************

  minim = new Minim(this); //assigns new minim object

  //load sample images
  face1 = loadImage("data/sample_assets/faces/smiley1.png");
  face2 = loadImage("data/sample_assets/faces/smiley2.png");
  face3 = loadImage("data/sample_assets/faces/smiley3.png");
  back1 = loadImage("data/sample_assets/backgrounds/back1.jpg");
  back2 = loadImage("data/sample_assets/backgrounds/back2.jpg");
  video1= new Movie(this, "sample_assets/videos/video1.mp4");
  video2= new Movie(this, "sample_assets/videos/video2.mov");
  video3= new Movie(this, "sample_assets/videos/video3.mp4");
  sound1 = minim.loadFile("sample_assets/music/music1.wav");
  sound2 = minim.loadFile("sample_assets/music/music3.wav");

  //assign initial assets but do not display or play
  display1_image= back1;
  display2_image= face1;
  display1_video= video1;
  display2_video= video2;
  sound= sound1;
}


void draw() {

  if (display1_image_visible== true) {
    //display 1
    image (display1_image, 0, 0);
  }
  if (display2_image_visible== true) {
    //display 2 : sample face test
    image (display2_image, display1_width, 0);
  }
  if (display1_video_visible== true) {
    if (display1_video.available()) {
      display1_video.read();
    }
    image (display1_video, 0, 0);
  }
  if (display2_video_visible== true) {
    if (display2_video.available()) {
      display2_video.read();
    }
    image (display2_video, display1_width, 0);
  }
}

void keyPressed() {

  //SAMPLE SOUNDS
  if (key== 'y') {
    sound.pause();
    sound= sound1;
    sound.rewind();
    sound.play();
  } 
  if (key=='u') {
    sound.pause();
    sound= sound2;
    sound.rewind();
    sound.play();
  } else if (key== 'i'){  //stop sound
    sound.pause();
  }
  

  //SAMPLE IMAGES
  if (key== 'q') {
    //blue on display 1, red on display 2
    clearDisplay ("display1", 0, 0, 255);
    clearDisplay ("display2", 255, 0, 0);
  } else if (key== 'w') {
    clearDisplay("display1", 0, 0, 0);
    clearDisplay("display2", 255, 255, 255);
    display1_image_visible= true;
    display2_image_visible= true;
    display1_image= back1;
    display2_image= face1;
  } else if (key== 'e') {
    clearDisplay("display1", 0, 0, 0);
    display1_image_visible= true;
    display1_image= back2;
  } else if (key== 'r') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video1;
    video1.play();
  } else if (key== 't') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video2;
    video2.play();
  }
}


//to clear display of image 
void clearDisplay(String whichDisplay, int r, int g, int b) { 
  fill (r, g, b);
  if (whichDisplay== "display1") {
    display1_image_visible= false;
    display1_video_visible= false;
    rect (0, 0, display1_width, display_height);
  } else if (whichDisplay== "display2") {
    display2_image_visible= false;
    display2_video_visible= false;
    rect(display1_width, 0, display2_width, display_height);
  }
}
