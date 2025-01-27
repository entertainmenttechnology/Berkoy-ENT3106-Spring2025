/*
  Sitting Chair Challenge
  "Making Things See", page 61
  
  ==============================
  
  Author: Greg Borenstein
*/

//importing library
import SimpleOpenNI.*;

//SET KINECT 9 SQUARES AWAY FROM CHAIR

//declare object name it kinect
SimpleOpenNI kinect;


float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 140; // Setting the Rectangle width
float RH = 130; // Setting the Rectangle Height

//run setup
void setup() {
 
 // Size of the sketch
 size(640, 480);
 
 // intiate kinect object
 kinect = new SimpleOpenNI(this);
 
 //enables the method depth (IR camera)
 kinect.enableDepth();
 
 //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
 kinect.enableUser(); 
 
 //X and Y positions of the rectangle.
 RX = width/2 - RW/2;
 RY = (height/2 - RW/2)*2;
 
}

//run draw loop
void draw() {
  
 //update kinect for use depending on what we called (methods)
 kinect.update();
 
 //call and ask library for next available depth image and then place the image
 // on location xpos 0,ypos 0.
 image(kinect.depthImage(), 0, 0);
 
 IntVector userList = new IntVector();
 kinect.getUsers(userList);
 
 //create a rectangle with origin in the center of the sketch
 //give the rectangle no fill or stroke (invisible)
 noFill();
 noStroke();
 rect(RX, RY, RW,RH);
 
 //run for loop to locate person in front of camera
 for (int i=0; i<userList.size(); i++) { 
 
 //get an id for each person in the camera view.
 int userId = userList.get(i);
 PVector position = new PVector();
 
 kinect.getCoM(userId, position); 
 kinect.convertRealWorldToProjective(position, position);
 
 //if person is within the boundaries
 if ((position.x >= RX) && (position.x < RX+RW) && (position.y >= RY) && (position.y < RY+RH)){
 
 //print "Sitting" in a red fill wherever the person is.   
 fill(255, 0, 0);
 textAlign(CENTER);
 textSize(40);
 text("Sitting", position.x, position.y);
 
 }
 
 //if not within those boundaries
 else{
   
 //print "Not Sitting" in a red fill wherever the person is.  
 fill(255, 0, 0);
 textAlign(CENTER);
 textSize(40);
 text("Not Sitting", position.x, position.y);
 }
 }

}
