/*
  Center of Mass
  "Making Things See", page 260
  
  ==============================
  
  Author: Greg Borenstein
*/

//Import the library
import SimpleOpenNI.*;
//Create an object called Kinect
SimpleOpenNI kinect;
//Runs once

int Xrect=280;  
int Yrect=340;
float masksizex;
float masksizey;
//boolean issitting=false;
//boolean anotherboolean;
PImage mask;

void setup()
{
  //imageMode(CENTER);
  //Create a canvas size 640 by 480

  size(640, 480);
  //initialize the object
  kinect = new SimpleOpenNI(this);
  //enable the depth sensor on the Kinect
  kinect.enableDepth();
  kinect.enableRGB();
  //Turns on user tracking for the kinect
  kinect.enableUser();
PFont font;
font = createFont("Times New Roman", 20);
textFont(font);
//img

mask = loadImage("mask01.png");

}


//Runs continuously

void draw() {
  
  //Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  
  //Calls the depth image to the point 0,0
  image(kinect.rgbImage(), 0, 0);
  
  /*Creates a variable called userList to store the user IDs. This
  variable is declared as an IntVector. This is a special type of variable provided
  by OpenNI specifically to store lists of integers representing user IDs.*/
  IntVector userList = new IntVector();
  
  /*puts all of the user IDs that OpenNI knows about into the 
  IntVector that’s passed into it*/
  kinect.getUsers(userList);
  noFill();
  stroke(5);
  rect(Xrect, Yrect, 100, 100);
// A for loop that runs for however many users there are in the scene
  for (int i=0; i<userList.size(); i++) { 
    int userId = userList.get(i); //Pulls the value of the user list that the loop is up to
    PVector position = new PVector(); //Sets a new vector to locate the position of each person detected in the scene
    kinect.getCoM(userId, position); //Call this to get the CoM, which stands for Center of Mass
    kinect.convertRealWorldToProjective(position, position); //converts center of mass to coordinates on the processing screen
    fill(255, 0, 0); // change the color to red
    
    float newMaskZ = position.z/17;
    float masksize = 20;
    //maskpositionx
    //float masksize = map(position.z, 2000, 3000, 50, 30);
    float maskpositionx=map(position.x, 0, 640, -25, 615);
    float maskpositiony=map(position.z, 2000, 3000, newMaskZ, newMaskZ);
    println(maskpositiony + " = mask y");
    ellipse(maskpositionx, maskpositiony,masksize,masksize);
    ellipse(position.x,position.y,20,20);
    println(int(position.z));
    
    //position.z ====== maskposition.y
  }
}
