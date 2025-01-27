/*
Jump Challenge 
 
 ==============================
 
 Author: Johnny, Daniel, Anthony, Oleg
 
 CHANGE LOCATION OF FOR LOOP TO ONLY LOCATE THE RANDOM PERSON WHO IS SELECTED
 CHA 3 AND 4 NEEDED
 */

//importing library
import SimpleOpenNI.*;

//SET KINECT 9 SQUARES AWAY FROM CHAIR

//declare object name it kinect
SimpleOpenNI kinect;


float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 140; // Setting the Rectangle width
float RH = 130; // Setting the Rectangle Height
float distance;
float boundaryX;
float jumpY;
int state = 0; 
int rand = -1;

int totalTime=0;

float[] y = new float[height];
float a = 0;
float b = 0;
float c = 0;
float lowest = 1000;

//int begin; 
//int duration = 5;
//int time = 5;

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

  //X and Y positions of the rectangle.
  RX = width/2 - RW/2;
  RY = (height/2 - RW/2)*2;

  rectMode(CENTER);
}

//run draw loop
void draw() {

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
  for (int i=0; i<userList.size() && state == 0; i++) { 

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


      if (userId == 3 && state == 0) {
        delay(3000);
        rand = int(random(userId));
        state = 1;
        println(rand +" " + state);
      }
    }
  }


  if (rand == 0 && state == 1) {
    choosingPerson();
  } else if (rand == 1 && state == 1) {
    choosingPerson();
  } else if (rand == 2 && state == 1) {
    choosingPerson();
  }
  if (state== 2)
  {
    jumpingStart();
  }
  if (state==3)
  {
    jump();
  }
  if (state==4)
  {
    postJump();
  }
}

void choosingPerson()
{
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;

  if (distance < 128 && boundaryX > 2 && boundaryX < 21.5 ) {
    stroke(0, 255, 255);
    fill(0);
    rect(person1.x, person1.y - 160, 350, 80);
    fill(0, 255, 255);
    textSize(30);
    textAlign(CENTER);
    text("Welcome!", person1.x, person1.y -160);
    if (totalTime == 0)
    {
      totalTime=millis()/1000 + 4;
    }
    int passedTime = totalTime - int(millis()/1000);
    if (passedTime <= 0) 
    {
      totalTime=0;
      state = 2;
    }
  } else {
    noFill();
    strokeWeight(4);
    stroke(0, 255, 0);
    rectMode(CENTER);
    rect(person1.x, person1.y, 100, 200);
    println (rand + " " + state);
    stroke(0, 255, 255);
    fill(0);
    rect(person1.x, person1.y - 160, 350, 80);
    fill(0, 255, 255);
    textSize(30);
    textAlign(CENTER);
    text("Come to the stage!\nQuick!", person1.x, person1.y -160);
  }
}

void jumpingStart()
{
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;
  //jumpY = person1.y/5.4;

  a = person1.y;
  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 8;
  }
  int passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) 
  {
    totalTime=0;
    state = 3;
  }
  stroke(0, 255, 255);
  fill(0);
  rect(width/2, height, 360, 240);
  fill(0, 255, 255);
  text(a, person1.x, person1.y);
  textSize(28);
  textAlign(CENTER);
  text("Let's see how high you \ncan jump! Get ready!\n" + passedTime + "...", width/2, height-90);
}
void jump()
{
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;
  jumpY = person1.y/5.4;
  text(b, person1.x, person1.y);
  
  if (totalTime == 0)
    {
      totalTime=millis()/1000 + 3;
    }
    int passedTime = totalTime - int(millis()/1000);
    if (passedTime <= 0) 
    {
      totalTime=0;
      state = 4;
    }
    
    if(person1.y < a)
    {
      b = person1.y;
      if(b<lowest){
        lowest = b;
      }
      
    }
    
  stroke(0, 255, 255);
  fill(0);
  rect(width/2, height, 360, 240);
  fill(0, 255, 255);
  textSize(28);
  textAlign(CENTER);
  text("JUMP!", width/2, height-90);
  //Tell the participants to keep their arms down
  //Messes with the center of mass if they don't
}

void postJump()
{
  c = a - lowest;
  c = c / 5.4;
  println("jump height is:  " + c);
  println("B was: " + b);
  println("A was: " + a);
    println("lowest was: " + lowest);

}
