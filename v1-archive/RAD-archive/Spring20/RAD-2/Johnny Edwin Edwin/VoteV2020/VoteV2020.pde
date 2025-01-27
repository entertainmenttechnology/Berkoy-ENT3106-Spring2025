/*

 Voting Challenge 
 
 ==============================
 
 Authors: Johnny, Daniel, Anthony, Oleg
 
 */

//importing library
import SimpleOpenNI.*;

//declare object name it kinect
SimpleOpenNI kinect;


float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 340; // Setting the Rectangle width
float RH = 70; // Setting the Rectangle Height
float distance;
float boundaryX;
int state = -1; 
int rand = -1;

int totalTime = 0;
String vote1 = "";
int passedTime = 1;


//run setup
void setup() {

  // Size of the sketch
  size(640, 480);

  // intiate kinect object
  kinect = new SimpleOpenNI(this);

  //enables the method depth (IR camera)
  kinect.enableDepth();

  //enable rgb
  kinect.enableRGB();

  //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
  kinect.enableUser(); 

  rectMode(CENTER);
  //X and Y positions of the rectangle.
  RX = width/2;
  RY = height/2 +85;
}

//run draw loop
void draw() {
  println(state + " = state");
  println(RY);
  //update kinect for use depending on what we called (methods)
  kinect.update();
  background(0, 0, 0);

  //call and ask library for next available depth image and then place the image
  // on location xpos 0,ypos 0.
  image(kinect.rgbImage(), 0, 0);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  //create a rectangle with origin in the center of the sketch
  //give the rectangle no fill or stroke (invisible)
  noFill();
  noStroke();
  rect(RX, RY, RW, RH);

  //run for loop to locate person in front of camera

  if ( state == 0 ) {
    startingUp();
  }
  if (state == 1) {
    standingUp();
  }
  //Conditional to choose different people
  //if random person chosen is a first on Kinect list and state = 1 which is the next from previous stage
  if (state == 2) {
    choosingPerson();
  }
  if (state == 3)//<-- After the person was chosen, go to state 2 where the rules of voting would be explained in votingRules() 
  {
    votingRules();
  }
  if (state == 4) { //<--After rules were explained go to stage three inside of VotingRules() and run votinQ1()
    votingQ1();
  }

  if (state == 5) //<-- After the answer was recorded go to stage 4 and show the answer
  {
    displayAnswer1();
  }
  if (state==7)
  {
    text("No one found!", 0, 45);
  }
}


//Function to choose a person
void choosingPerson()
{
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;

  //use timer for total and current times
  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime = 0;
    passedTime=1;
    state = 3;
  }

  noFill();
  strokeWeight(4);
  stroke(0, 255, 0);
  rect(person1.x, person1.y, 100, 200);
  println (rand + " " + state);
  stroke(0, 255, 255);
  fill(0);
  rect(person1.x, person1.y - 160, 350, 80);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("Get ready to vote in: " + passedTime, person1.x, person1.y -160);
}

//Function to vote
void votingRules()
{

  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1); 

  text(userIdChosen, person1.x, person1.y); // Print out numbers on people

  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 7;
  }
  passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime=0;
    passedTime = 1;
    state = 4;
  }


  println (rand + " " + state);
  stroke(0, 255, 255);
  fill(0);
  rect(320, 50, 450, 200);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("For the following statement,\nStand up if you agree,\nStay seated if you do not... ", 320, 50);
}


//Function for question 1
void votingQ1()
{

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
    if (person1.y>RY) 
    {
      vote1 = " NO!";
    } else 
    {
      vote1=" YES!";
    }
    totalTime = 0;
    state = 5;
  }
  //
  //
  //
  //
  //
  //
  //
  stroke(0, 255, 255);
  fill(0);
  rect(320, 50, 450, 200);
  fill(0, 255, 255);
  textSize(30);
  textAlign(CENTER);
  text("Do you believe in strong \nsafety precautions in the \nworkplace? " + passedTime, 320, 50);
}
void startingUp() { 

  fill(0);
  rect(0, 0, 300, 100, 200);
  fill(255, 0, 0);
  textSize(52);
  text("Please stand up!", 0, 50);
  text(passedTime, 40, 100);
  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);

  if (passedTime <= 0) 
  {
    totalTime=0;
    passedTime = 1;
    state = 1;
  }
}
void standingUp()
{
  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  passedTime = totalTime - int(millis()/1000);

  for (int i=0; i<userList.size(); i++) { 

    //get an id for each person in the camera view.
    int userId = userList.get(i);
    PVector position = new PVector();

    //Get Center of Mass
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);

    //Find the distance between Kinect and an object in inches
    distance = position.z / 25.4;

    //Set an edge to the stage
    boundaryX = position.x / 25.4;

    //Set the boundaries for the stage
    if (distance < 175 && boundaryX > 4 && boundaryX < 20) {
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(40);
      text(userId, position.x, position.y);
    }
    // Print out numbers on people
    if (passedTime <= 0) 
    {
      totalTime=0;
      if (userList.size() > 0) {
        rand = int(random(userList.size()));
        println(rand + "random #");
        passedTime = 1;
        state = 2;
      }
    }
  }
  if (passedTime<= 0) {
    state = 7;
  }
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
}



void keyPressed() 
{
  if (key== ' ') 
  {
    state =0;
  }
}
