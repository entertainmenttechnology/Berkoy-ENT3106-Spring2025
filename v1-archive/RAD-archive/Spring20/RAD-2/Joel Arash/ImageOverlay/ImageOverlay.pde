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
boolean issitting=false;
boolean anotherboolean;
void setup()
{
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

}


//Runs continuously

void draw() {
  PImage img;
img = loadImage("mask01.png");
  //Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  //Calls the depth image to the point 0,0
  image(kinect.rgbImage(), 0, 0);
  //Creates a variable called userList to store the user IDs. This
  //variable is declared as an IntVector. This is a special type of variable provided
  //by OpenNI specifically to store lists of integers representing user IDs.
  IntVector userList = new IntVector();
  //puts all of the user IDs that OpenNI knows about into the 
  //IntVector that’s passed into it
  kinect.getUsers(userList);
  noFill();
  stroke(5);
  rect(Xrect, Yrect, 100, 100);
// A for loop that runs for however many users there are in the scene
  for (int i=0; i<userList.size(); i++) { 
//Pulls the value of the user list that the loop is up to
    int userId = userList.get(i);
    //Sets a new vector to locate the position of each person detected in the scene
    PVector position = new PVector();
    //Call this to get the CoM, which stands for Center of Mass
    kinect.getCoM(userId, position); 
    //converts center of mass to coordinates on the processing screen
    kinect.convertRealWorldToProjective(position, position);
    // change the color to red
    fill(255, 0, 0);
  
  
  
  

    if (position.x > Xrect && position.y > Yrect && position.x < Xrect + 100 && position.y < Yrect + 100){
      textAlign(CENTER);
      //text("Sitting", position.x, position.y-25);
      image(img, position.x-40, position.y-140,70,70);
            println(int(position.z));
    }
    else{
      //text("Not sitting", position.x, position.y-70);
            println(int(position.z));
      image(img, position.x-40, position.y-140, 70,70);
      //z1000 = img130px we need the x and y position
      //z2000 = img70px we need the x and y position
      //z4000
      //z5000
      //etc
    }


    
  }
}
