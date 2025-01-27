import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import SimpleOpenNI.*; //Import the library
SimpleOpenNI kinect; //Create an object called Kinect
// minim

Minim minim;
AudioSample player;
int x1; // y-coordinate for 1st square
int x2;// y -coordinate for 2nd square
boolean chairOneSat = false;
boolean chairTwoSat = false;

int fart1;
int fart2;
void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);  //initialize the object
  kinect.enableDepth();  //enable the depth sensor on the Kinect
  kinect.enableUser();  //Turns on user tracking for the kinect
  kinect.enableRGB();
  textSize(50);
  x1=125;
  x2=350;
  minim = new Minim(this);
  player = minim.loadSample("fart.mp3");
}

void draw() {
  kinect.update();  
  image(kinect.rgbImage(), 0, 0); 
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  for (int i=0; i<userList.size(); i++) { 
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);
    textSize(50);
    fill(255, 255, 0, 50);    
    circle(position.x, position.y-50, 50);
    fill(255, 0, 0);
    
    // first chair
    fill(255, 0, 0, 50);
    rect(x1, 250, 100, 100);  //225 - 325 , 250 - 350    
    rect(x2, 250, 100, 100);  //350 - 450 , 250 - 350
    if ((position.x >= x1 && position.x <= x1 + 100) && (position.y < 351 && position.y > 249)) { // you are not jumping you are not in the box. if you jumped into the box it changes color
      chairOneSat = true;
    }
    if ((position.x >= x2 && position.x <= x2+ 100) && (position.y < 351 && position.y > 249)) { // you are not jumping you are not in the box. if you jumped into the box it changes color
      chairTwoSat = true;
    } else { // not jumping
      fill(255, 0, 0, 50);
    }
    if (chairOneSat == true) {
      fill(0, 255, 0, 50);
      rect(125, 250, 100, 100);
      fart1++;
      if(fart1 == 2){
        
      player.trigger();
      }
    }
    if (chairTwoSat == true) {
      fill(0, 255, 0, 50);
      rect(350, 250, 100, 100);

      if(fart1 == 2){
        
      player.trigger();
      }
    }
  }
}
