/*  Voting Challenge 
 ==============================
 Authors: Johnny, Daniel, Anthony, Oleg
 AuthorsV2: Johnny, Edwin, Edwin
 */

import SimpleOpenNI.*; //importing library
SimpleOpenNI kinect; //declare object name it kinect
// ===================================================
float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 340; // Setting the Rectangle width
float RH = 70; // Setting the Rectangle Height
float distance;
float boundaryX;
int voteState = -1; 
int rand = -1;
int totalTime = 0;
String vote1 = "";
int passedTime = 1;

//run setup
void setup() {
  size(640, 480);  // Size of the sketch
  kinect = new SimpleOpenNI(this);  // intiate kinect object
  kinect.enableDepth();  //enables the method depth (IR camera)
  kinect.enableRGB();  //enable rgb
  kinect.enableUser(); //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
  rectMode(CENTER);
  RX = width/2; //X and Y positions of the rectangle.
  RY = height/2 +35; //X and Y positions of the rectangle.
} // end setup

void draw() { //run draw loop
  println(voteState + " = voteState"); // monitoring the voteState changes
  println(RY);
  kinect.update();  //update kinect for use depending on what we called (methods)
  background(0, 0, 0); 
  image(kinect.rgbImage(), 0, 0);  //ask library for next rgbImage and place the image on location xpos 0,ypos 0.
  // 
  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  //give the rectangle no fill or stroke (invisible)
  noFill();
  noStroke();
  rect(RX, RY, RW, RH);  //create a rectangle with origin in the center of the sketch
  // After pressing the SpaceBar, the code is activated
  if ( voteState == 0 ) {
    startingUp();
  }
  if (voteState == 1) {
    standingUp();
  }
  if (voteState == 2) {
    choosingPerson();
  }
  //<-- After the person was chosen, go to voteState 2 where the rules of voting would be explained in votingRules() 
  if (voteState == 3) {
    votingRules();
  }
  if (voteState == 4) { //<--After rules were explained go to stage three inside of VotingRules() and run votinQ1()
    votingQ1();
  }

  if (voteState == 5) //<-- After the answer was recorded go to stage 4 and show the answer
  {
    displayAnswer1();
  }
  if (voteState==7)
  {
    text("No one found!", 0, 45);
  }
}

// Functions in order they are activated

/*
  After pressing the SpaceBar the code is activated.
 The instructions to stand up are given.
 */
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
    voteState = 1;
  }
} // end startingUp()

/*
  Following function is activated after people have stood up.
 The code sets a boundary as a stage. Anything Beyond that is off stage.
 */
void standingUp() {
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  if (totalTime == 0) {
    totalTime = millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);

  for (int i=0; i<userList.size(); i++) { 
    //get an id for each person in the camera view.
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position);   //Get Center of Mass
    kinect.convertRealWorldToProjective(position, position);
    distance = position.z / 25.4;  //Find the distance between Kinect and an object in inches
    boundaryX = position.x / 25.4;  //Set an edge to the stage
    //Set the boundaries for the stage
    if (distance < 175 && boundaryX > 4 && boundaryX < 20) {
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(40);
      text(userId, position.x, position.y);
    }
    // Print out numbers on people
    if (passedTime <= 0) {
      totalTime = 0;
      if (userList.size() > 0) {
        rand = int(random(userList.size()));
        println(rand + "random #");
        passedTime = 1;
        voteState = 2;
      }
    }
  }
  if (passedTime<= 0) {
    voteState = 7;
  }
} // end standingUp function


//Function to choose a person
void choosingPerson() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;
  //use timer for total and current times
  if (totalTime == 0) {
    totalTime = millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime = 0;
    passedTime = 1;
    voteState = 3;
  }
  noFill();
  strokeWeight(4);
  stroke(0, 255, 0);
  rect(person1.x, person1.y, 100, 200);
  println (rand + " " + voteState);
  stroke(0, 255, 255);
  fill(0);
  rect(person1.x, person1.y - 160, 350, 80);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("Get ready to vote in: " + passedTime, person1.x, person1.y -160);
}

//Function to vote
void votingRules() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1); 
  text(userIdChosen, person1.x, person1.y); // Print out numbers on people
  if (totalTime == 0) {
    totalTime=millis()/1000 + 7;
  }
  passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime=0;
    passedTime = 1;
    voteState = 4;
  }
  println (rand + " " + voteState);
  stroke(0, 255, 255);
  fill(0);
  rect(320, 50, 450, 200);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("For the following voteStatement,\nStand up if you agree,\nStay seated if you do not... ", 320, 50);
} // end of the votingRules function

//Function for question 1
void votingQ1() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);
  text(userIdChosen, person1.x, person1.y); // Print out numbers on people

  println(person1.y +" = Person1.y");
  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  int passedTime = totalTime - int(millis()/1000);
  //Conditional to check if the person is standing or not
  if (passedTime <= 0) {
    //conditional if the person is within the boundaries of choosing area.
    if (person1.y>RY) {
      vote1 = " NO!";
    } 
    //
    else {
      vote1=" YES!";
    }
    totalTime = 0;
    voteState = 5;
  }
  stroke(0, 255, 255);
  fill(0);
  rect(320, 50, 450, 200);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("Do you believe in strong \nsafety precautions in the \nworkplace? " + passedTime, 320, 50);
}

void displayAnswer1() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);
  stroke(0, 255, 255);
  fill(0);
  rect(320, 50, 450, 200);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("Your answer was: " + vote1, 320, 50);
} // end of displayAnswer function

void keyPressed() {
  if (key== ' ') 
  {
    voteState = 0;
  }
}
