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
void setup()
{
  //Create a canvas size 640 by 480
  size(640, 480);
  //initialize the object
  kinect = new SimpleOpenNI(this);
  //enable the depth sensor on the Kinect
  kinect.enableDepth();
  //Turns on user tracking for the kinect
  kinect.enableUser();
}
//Runs continuously
void draw() {
  //Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  //Calls the depth image to the point 0,0
  image(kinect.depthImage(), 0, 0);
  //Creates a variable called userList to store the user IDs. This
  //variable is declared as an IntVector. This is a special type of variable provided
  //by OpenNI specifically to store lists of integers representing user IDs.
  IntVector userList = new IntVector();
  //puts all of the user IDs that OpenNI knows about into the 
  //IntVector that’s passed into it
  kinect.getUsers(userList);
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
    // draw an ellipse at the x and y position of each person's center of mass
    ellipse(position.x, position.y, 25, 25);
  }
}
