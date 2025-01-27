/*
  Come to Stage Challenge
 ==============================
 Author: Johnny, Daniel, Anthony, Oleg
 Author: Johnny, Edwin C, Edwin S
 */

import SimpleOpenNI.*;  //importing library
SimpleOpenNI kinect;  //declare object name it kinect
//SET KINECT 9 SQUARES AWAY FROM CHAIR

float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 140; // Setting the Rectangle width
float RH = 130; // Setting the Rectangle Height
float distance;
float boundaryX;
int stageState = -1; 
int rand = -1;
int totalTime = 0;
int passedTime = 1;
// Do not know what the following 3 lines of Code are use for or their purpose.
//int begin; 
//int duration = 5;
//int time = 5;

//run setup
void setup() {
  size(640, 480);  // Size of the sketch
  kinect = new SimpleOpenNI(this);  // intiate kinect object
  kinect.enableDepth();  //enables the method depth (IR camera)
  kinect.enableRGB();  //enable rgb
  kinect.enableUser();  //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
  RX = width/2 - RW/2;  //X and Y positions of the rectangle.
  RY = (height/2 - RW/2)*2;
}
void draw() {  //run draw loop
  // the following three lines of code can be useKinect() function because we use this a lot in other modules.
  kinect.update();  //update kinect for use depending on what we called (methods)
  background(0, 0, 0);
  image(kinect.rgbImage(), 0, 0);  //call and ask library for next available depth image and then place the image on location xpos 0,ypos 0.

  println(passedTime + " passed time");
  println(totalTime + " total time");
  println(stageState + " stageState");

  if (stageState == 0) {
    startingUp();
  }
  // println(passedTime);

  if (stageState == 1) {
    standingUp();
  }
  if (stageState == 2) {
    choosingPerson();
  }
  if (stageState == 3) {
    text("No one found!", 0, 45);
  }
}
// phase 1
void startingUp() { 
  fill(0);
  rect(0, 0, 300, 100, 200);
  fill(255, 0, 0);
  textSize(52);
  text("Please stand up!", 0, 50);
  text(passedTime, 40, 100);
  if (totalTime == 0) {
    totalTime=millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);
  
  if (passedTime <= 0) {
    totalTime=0;
    passedTime = 1;
    stageState = 1;
  }
}
// phase 2
void standingUp() {
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  //give the rectangle no fill or stroke (invisible)
  noFill();
  noStroke();
  rect(RX, RY, RW, RH);  //create a rectangle with origin in the center of the sketch
  if (totalTime == 0) {
    totalTime=millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);

  //run for loop to locate person in front of camera
  for (int i=0; i<userList.size() && stageState == 1; i++) { 
    //get an id for each person in the camera view.
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);
    distance = position.z / 25.4;
    boundaryX = position.x / 25.4;

    if (distance < 175 && boundaryX > 4 && boundaryX < 20) {
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(40);
      text(userId, position.x, position.y); // Print out numbers on people
    }
    println(userList.size() + " Users");
    if (passedTime <= 0) {
      totalTime=0;
      if (userList.size() > 0) {
        rand = int(random(userList.size()));
        println(rand + "random #");
        passedTime = 1;
        stageState = 2;
      }
    }
  }
  if (passedTime<= 0) {
    stageState = 3;
  }
}
// phase 3
void choosingPerson() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;

  if (distance < 128 && boundaryX > 2 && boundaryX < 21.5 ) {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(40);
    text("On Stage", person1.x, person1.y);
  }
  //
  else {
    noFill();
    strokeWeight(4);
    stroke(0, 255, 0);
    rectMode(CENTER);
    rect(person1.x, person1.y, 100, 200);
    println (rand + " " + stageState);
    text("Come on to stage", person1.x, person1.y + 100);
  }
}

void keyPressed() {
  if (key== ' ') {
    stageState = 0; // allows the module to be started or restarted.
  }
}   
