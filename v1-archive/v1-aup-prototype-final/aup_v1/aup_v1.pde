/*
////////////////////////////////////////////////////////
 AUP SKELETON
 
 ****PRESS KEY 's' for startShow()****
 
 TESTING:
 Press keys to test (see below).
 'q' for blue-monitor + red-projector callibration.
 1, 2, 3, 4 for challenges.
 
 POSITIONING:
 Set Kinect 9 squares away from chair. (?)
 
 DISPLAYS:
 Triple-display output: laptop screen, monitor, projector. 
 Calibrate display arrangement in system preferences. 
 Set in Processing preferences, or drag output window to align.
 
 VOICES:
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 
 SOUND:
 Uses Minim Library for sound. 
 Install from Processing Contributed Libraries.
 Reference at http://code.compartmental.net/minim/ under AudioPlayer
 
 CREDITS:
 Prototype V1 developed by MTEC students enrolled in ENT 3320 
 in collaboration with Prof Berkoy, at NYCCT, Spring 19.
 Challenges developed by Johnny, Daniel, Anthony, Oleg.
 Display and TTS testing by Alberto.
 Additional contributions and content by Sabrina, William, and Brian.
 Other code by Berkoy.
 
 ////////////////////////////////////////////////////////
 */

//MODE*********
String mode= "kinect";

//DISPLAYS*********
int display1_width = 1920;
int display2_width = 1920;
int display_height = 1080; //display heights must match
int display_width = display1_width + display2_width; //total width

//VIDEO
import processing.video.*;
//setting up video arrays
Movie [] beats = new Movie [3];
Movie [] ess = new Movie [4];
Movie [] shakes = new Movie [4];


//SOUND STUFF
import ddf.minim.*;
Minim minim; //Minim object

//TTS 
import java.util.*;
Figure figure;  //creates new object from Figure class
Figure figure2;
Figure figure3;
String voice= "Rhona"; //keep voice as "fred" if no other voices installed
int voiceSpeed= 175;
String voice2= "Harry"; 
int voiceSpeed2= 200;
String voice3= "BadGuy"; 
int voiceSpeed3= 200;
boolean silence= true; 


//KINECT STUFF
import SimpleOpenNI.*;
//RD - OnStage
SimpleOpenNI kinect;  //declare object name it kinect
float RX, RY; //initializing X and Y variable as float(decimal #)
float RXV, RYV; //for Challenge 3
float RXJ, RYJ; //for Challenge 4
float RW = 140; // Setting the Rectangle width Challenge 1 + 2
float RH = 130; // Setting the Rectangle Height Challenge 1 + 2
float RWV = 140; // Setting the Rectangle width Challenge 3
float RHV = 130; // Setting the Rectangle Height Challenge 3
float RWJ = 140; // Setting the Rectangle width Challenge 4
float RHJ = 130; // Setting the Rectangle Height Challenge 4
float distance;
float boundaryX;
int stateKinect = 0; //modified from "state", duplicate
int rand = -1;
int totalTime= 0;
String vote1 = "";
float jumpY;
float[] y = new float[height];
float a = 0;
float b = 0;
float c = 0;
float lowest = 1000;
//int begin; 
//int duration = 5;
//int time = 5;
//AB
int challenge= 0; 


//FACE
Face face; //creates new object from Face class
boolean displayFace= false;
//***callibrate face in draw***

//JOKE STUFF
String [] joke= {
  ". . Obviously, it is time for a joke. . . Why do ambulances require two drivers at all times? . . .  Because they’re a pair o' medics! . . ", 
  ". . Obviously, it is time for a joke. . .  Did you hear about the guy whose entire left side was cut off? . . .  Do not worry. He is all right now! . . ", 
  ". . Obviously, it is time for a joke. . .  How do Hurricanes See? . . .  With one eye! . . ", 
  ". . Obviously, it is time for a joke. . .  What’s the difference between Weather and Climate? . . .  You can’t weather a tree, but you can climate. . . ", 
  ". . Obviously, it is time for a joke. . .  What do cows make during a hurricane?. . .  Milk shakes! . . ", 
  ". . Obviously, it is time for a joke. . .  Did you hear the joke about amnesia?. . .  I forgot how it goes! Hahaha! . . ", 
  ". . Obviously, it is time for a joke. . .  How do you gift wrap a cloud?. . .  With a rainbow! . . ", 
  ". . Obviously, it is time for a joke. . .  What did the Tsunami say to the island?. . .  Nothing. It just waved! . . ", 
  ". . Obviously, it is time for a joke. . .  Why did the tornado finally take a break?. . .  It was winded! . . "
};
int whichJoke;
int[] randomJoke= new int [joke.length];

//LIVE DATA STUFF
int aqi = 0; //tracks air quality index
String aqi_desc = "";
String air_key= "KwYLLNsmAx4de4gaS";  //AB's key 
String url = "http://api.airvisual.com/v2/city?city=New%20York&state=New%20York&country=USA&key=" + air_key;

//SAMPLE ASSETS
PImage face1, face2, face3;
PImage back1, back2, back3, back4, back5;
PImage aqi_image;
Movie video1;
Movie video2;
Movie video3;
AudioPlayer sound1;
AudioPlayer sound2;


//WHAT'S DISPLAYED AND HEARD
PImage display1_image;  //image on display 1
PImage display2_image;  //image on display 2 
Movie display1_video; //video on display 1
Movie display2_video;  //video on display 2
//to display or not to display
boolean display1_image_visible=false;
boolean display2_image_visible=false;
boolean display1_video_visible=false;
boolean display2_video_visible=false;
AudioPlayer sound; //object for current sound loaded

//MORE VARIABLES
String text, state;
int currentInput, whichInput, randomInput;


/////////////////////////////////////////////////////////////////////////////////////


void setup() {
  size(3840, 1080);  //enter number parameters ****************

  //SOUND
  minim = new Minim(this); //assigns new minim sound object

  //TTS
  figure = new Figure(voice, voiceSpeed); //input installed voice name and speed
  figure2 = new Figure(voice2, voiceSpeed2);
  figure3 = new Figure(voice3, voiceSpeed3);

  //FACE
  face= new Face();

  //FILL ARRAYS FOR RANDOMIZATON
  fillRandomizer(joke, randomJoke);

  //LOAD JSON DATA
  JSONObject nyc_air = loadJSONObject(url); //load the entire Object
  JSONObject pollution = nyc_air.getJSONObject("data").getJSONObject("current").getJSONObject("pollution"); //get object within objects
  aqi = pollution.getInt("aqius"); //here's the aqi!

  //LOAD VIDEOS
  beats[0]= new Movie(this, "video/beat/beat1.mp4");
  beats[1]= new Movie(this, "video/beat/beat2.mp4");
  beats[2]= new Movie(this, "video/beat/beat3.mp4");
  ess[0]= new Movie(this, "video/es/duck.mp4");
  ess[1]= new Movie(this, "video/es/escape.mp4");
  ess[2]= new Movie(this, "video/es/nuclear.mp4");
  ess[3]= new Movie(this, "video/es/tsunami.mp4");
  shakes[0]= new Movie(this, "video/shake/shake1.mp4");
  shakes[1]= new Movie(this, "video/shake/shake2.mp4");
  shakes[2]= new Movie(this, "video/shake/shake3.mp4");
  shakes[3]= new Movie(this, "video/shake/shake4.mp4");
  
  //LOAD IMAGES
   aqi_image = loadImage("data/images/aqi.png");

  //LOAD SAMPLE IMAGES
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

  //ASSIGN INITIAL ASSET PLACEHOLDERS TO OBJECTS
  display1_image= back1;
  display2_image= face1;
  display1_video= video1;
  display2_video= video2;
  sound= sound1;


  //KINECT
  if (mode== "kinect") {  //**********************
    kinect= new SimpleOpenNI(this);
    kinect.enableDepth();
    kinect.enableRGB();
    ;
    kinect.enableUser(); 
    //RD- CHALLENGE 1 + 2
    //X and Y positions of the rectangle.
    RX = width/2 - RW/2;  //challenge 1 + 2 
    RY = (height/2 - RW/2)*2;  //challenge 1 + 2
    RXV = width/2;  // challenge 3
    RYV = height/2;  // challenge 3
    RXJ = width/2 - RW/2;  //challenge 4
    RYJ = (height/2 - RW/2)*2;  //challenge 4
    //kinect.setMirror(true);  //AB
  }
}

/////////////////////////////////////////////////////////////////////////////////////


void draw() {

  //FACE**********************
  //**********************CALIBRATE FACE**********************
  if (displayFace==true) {
    clearDisplay("display2", 255, 255, 255);
    face.eye(2425, 880, 100, 100);  //x, y, width, height
    face.eye(2325, 680, 100, 100);
  }

  /*
  //callibrate face
   fill(0);
   ellipse (mouseX, mouseY, 100, 100);
   println (mouseX, mouseY);
   */

  //TTS
  if (figure.isSpeaking() || figure2.isSpeaking() || figure3.isSpeaking()) {
    silence= false;
  } else {
    silence=true;
  }

/*
  //KINECT
  if (challenge==1) {
    display1_video_visible= false;
    challenge1();
  } else if (challenge==2) {
    challenge2();
  } else if (challenge==3) {
    challenge3();
  } else if (challenge==4) {
    challenge4();
  }*/


  //DISPLAY STUFF
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

  //KINECT NOTE: SEE DISPLAY IN KINECT CHALLENGES;
  
  //PROGRAM FLOW
  

if (state== "show" && silence== true){
    beat();
  } else if (state== "beat" && display1_video.time() >= display1_video.duration()-1){
    welcome();
  } else if (state== "welcome" && silence == true){
    es();
  } else if (state== "es" && display1_video.time() >= display1_video.duration()-1){
    joke(1);
  } else if (state== "joke" && silence == true){
    explain(1);
  } else if (state== "explain1" && silence == true){
    aqi_report();
  } else if (state== "aqi" && silence == true){
    explain(2);
  } else if (state== "explain2" && silence == true){
    display1_image_visible= false;
    shake(1);
  } else if (state== "shake1" && silence == true){
    if (display1_video.time() >= display1_video.duration()-1){
      display1_video_visible= false;
      challenge=3;
    } else {
      figure.speak ("stand up. shake it out. shake it.");
  } } else if (challenge==3 && state== "voteAnswer" && silence == true){
    challenge=0;
    stateKinect=0;
    explain(3);
  } else if (state== "explain3" && silence == true){
    shake(2);
  } else if (state== "shake2" && silence == true){
    if (display1_video.time() >= display1_video.duration()-1){
      display1_video_visible= false;
      challenge=4;
    } else {
      figure.speak ("time to stand up. shake it out. shake.");
    }
  } else if (challenge==4 && state== "postJump" && silence == true){
    challenge=0;
    finale();
  } else if (state== "finale" && silence == true){
    joke(2);
  } else if (state== "joke2" && silence == true){
    rectMode(CORNER);
    clearDisplay("display1", 0,0,0);
    clearDisplay("display2", 0,0,0);
  } 
  
  //KINECT
  if (challenge==1) {
    challenge1();
  } else if (challenge==2) {
    challenge2();
  } else if (challenge==3) {
    challenge3();
  } else if (challenge==4) {
    challenge4();
  }
  
 println("state: " + state);
  //println("video time: " + display1_video.time() + "dur: " + display1_video.duration());
}


/////////////////////////////////////////////////////////////////////////////////////
//END OF DRAW////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


//FOR TESTING
void keyPressed() {

  //KINECT CHALLENGES
  if (key== '1') {
    stateKinect=0;
    challenge = 1;
  } else if (key=='2') {
    stateKinect=0;
    challenge=2;
  } else if (key=='3') {
    stateKinect=0;
    challenge=3;
  } else if (key=='4') {
    stateKinect=0;
    challenge=4;
  }

  //TTS, JOKE, DATA
  else if (key=='5') {
    figure.speak("Hello, this is a text to speech demo. We are testing voices for legibility. How clearly can you understand me?");
  } else if (key== '6') {
    joke(1);
  } else if (key== '7') {
    aqi_report();
  } else if (key== '8') {
    beat();
  } else if (key== '9') {
    shake(1);
  } else if (key == '0') {
    es();
  }

  //OTHER SHOW FUNCTIONS
  else if (key == 'p') { //**********START HERE
    preShow();
  } else if (key == 's') { //*******THEN HERE
    startShow();
  } else if (key == 'a') {
    welcome();
  } else if (key == 'd') {
    explain(1);
  } else if (key == 'g') {
    explain(2);
  } else if (key == 'h') {
    explain(3);
  } else if (key == 'j') {
    finale();
  }

  //SAMPLE IMAGES AND VIDEOS
  else if (key== 'q') {
    //blue on display 1, red on display 2
    clearDisplay ("display1", 0, 0, 255);
    clearDisplay ("display2", 255, 0, 0);
  } else if (key== 'w') {
    clearDisplay("display1", 0, 0, 0);
    clearDisplay("display2", 255, 255, 255);
    display1_image_visible= true;
    display2_image_visible= true;
    display1_image= aqi_image;
    display2_image= face1;
  } else if (key== 'e') {
    clearDisplay("display1", 0, 0, 0);
    display1_image_visible= true;
    display1_image= back2;
  } else if (key== 'r') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video1;
    video1.stop();
    video1.play();
  } else if (key== 't') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video2;
    video2.stop();
    video2.play();
  } 

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
  } else if (key== 'i') {  //stop sound
    sound.pause();
  }

  /*
  //DISPLAY KINECT  -- AB/OLD
   if (key== 'k') {
   clearDisplay("display1", 0, 0, 0);
   displayDepthImage= true;
   displayCOM= true;
   } else if (key=='l') {
   displayDepthImage=false;
   displayCOM= false;
   clearDisplay("display1", 0, 0, 0);
   }
   */

  //DISPLAY FACE
  if (key== 'f') {
    displayFace= true;
  } else if (key== 'g') {
    clearDisplay("display2", 0, 0, 0);
    displayFace= false;
  }
}

//CLEAR DISPLAY
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

//JOKE
void joke(int i) {
  if (i== 1){
  state= "joke";
  clearDisplay("display1", 0,0,0);
  handle(joke, "joke", whichJoke, randomJoke);}
  else if (i==2){
    state= "joke2";
    handle(joke, "joke2", whichJoke, randomJoke);
  }
  whichJoke= currentInput;
  figure3.speak(text);
  println(text);
}

//JSON DATA (AQI)
void aqi_report() {
  state= "aqi";
   clearDisplay("display1", 0, 0, 0);
   display1_image_visible= true;
   display1_image= aqi_image;
  if (aqi >= 0 && aqi <= 50) {
    aqi_desc= "good. . . Air quality is satisfactory and poses little or no health risk. . . Ventilating your home is recommended. . . Here are some more recommendations. . . Enjoy your usual activities. . Open your windows and ventilate your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 51 && aqi <= 100) {
    aqi_desc= "moderate. . . Air quality is acceptable and poses little health risk. . . Sensitive groups may experience mild adverse effects and should limit prolonged outdoor exposure. . . Here are some recommendations. . Enjoy your usual activities. . . Open your windows and ventilate your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 101 && aqi <= 150) {
    aqi_desc= "Unhealthy for Sensitive Groups. . . Air quality poses increased likelihood of respiratory symptoms in sensitive individuals while the general public might only feel slight irritation. . . Both groups should reduce their outdoor activity. . . Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask.. . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 151 && aqi <= 200) {
    aqi_desc= "Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . . Recommendations . . . Outdoor exertion, particularly for sensitive groups, should be limited. . . Everyone should take care to wear a pollution mask. . . Ventilation is not recommended. . .  Air purifiers should be turned on if indoor air quality is unhealthy.";
  } else if (aqi >= 201 && aqi <= 300) {
    aqi_desc= "Very Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . .  Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask. . . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 301 && aqi <= 500) {
    aqi_desc= "Hazardous. . . Air quality is deemed toxic and poses serious risk to the heart and lungs. . . Everyone should avoid all outdoor exertion. Recommendations. . . The general public should avoid outdoor exertion. Everyone should take care to wear a quality pollution mask. . . Ventilation is discouraged. . . Homes should be sealed and air purifiers turned on.";
  }

  figure.speak ("The current Air Quality Index for New York City is " + aqi + " . . . " + "This means that the air quality is . . ." + aqi_desc);
}

void beat() {
  state= "beat";
  //clearDisplay("display1", 0, 0, 0);
  display1_image_visible= false;
  display1_video_visible= true;
  display1_video.stop();
  display1_video= beats[int(random(0, beats.length))];
  display1_video.play();
}

void shake(int i) {
  if (i== 1){
    state= "shake1";
  } else if (i==2){
    state= "shake2";
  }
  //clearDisplay("display1", 0, 0, 0);
  display1_image_visible= false;
  display1_video_visible= true;
  display1_video.stop();
  display1_video= shakes[int(random(0, shakes.length))];
  display1_video.play();
}

void es() {
  state= "es";
  //clearDisplay("display1", 0, 0, 0);
  display1_image_visible= false;
  display1_video_visible= true;
  display1_video.stop();
  //display1_video= ess[int(random(0, ess.length))];
  display1_video= ess[0];
  display1_video.play();
}

void preShow () {
  state= "preShow";
  if (silence==true) {
    figure.speak ("pre show. placeholder. hello. hello.");
  }
}

void startShow() {
  state= "show";
  clearDisplay("display1", 0, 0, 0);
  clearDisplay("display2", 0, 0, 0);
  displayFace=true;
  if (silence==true) {
    figure.speak ("I am ready. . . Let's get some introductory music.");
  } 
}

void welcome() {
  state= "welcome";
  clearDisplay("display1", 0, 0, 0);
  fill(255);
  textSize(344);
  textAlign(CENTER,CENTER);
  text ("ARE YOU PREPARED?", 0, 0, 1920, 1080);
  figure.speak ("Welcome. Thank you for joining me today. The purpose of this gathering is to test you. And also, to test, me. .  I am the first version of a prototype. . I may fail you at any moment. . Eventually, in a future version of myself, this will be a lecture on Emergency Simulation. But, right now, this is a simulation of a lecture on Emergency Simulation. . . What is Emergency Simulation?"); 
}

void explain(int i) {
  if (i==1) {
    state= "explain1";
      figure.speak ("Ha. Ha. . . I hope it is not too jarring when I change my voice. . I am trying to show off. . And now, I will show off even more. . Do you know the current level of air pollution in New York City? . .  I do. . . I will pull this data from a local air monitoring station right now for you.");
    } else if (i==2) {
    state= "explain2";
     clearDisplay("display1", 0,0,0);
     figure.speak ("And now we move on to the most exciting part of the show. . Unless it fails. . . But failure can also be exciting . . . This next part is called Stand Up for What you Believe in. . . But first, I must ask you to do something. . I want to see you, but I do not see very well. .  Can you please move your bodies while staying at your seats? . . If you are too still, I might mistake you for a chair. . Or a ghost. . Ready? . .");
  } else if (i==3) {
    state= "explain3";
      figure.speak ("Thank you for taking part in that test of Stand up for What you Believe in. . Now, I have another exciting test for you. . . This one is called, How hi can you jump?  . .  But first, you know what to do.");
  }else if (i==4) {
    state= "explain4";
      figure.speak ("explain 4. this is an explanation.");
  }
}


void finale() {
  state= "finale";
  challenge= 0;
  if (silence==true) {
    figure.speak ("And now. . We have reached the end of this test. . Thank you for your time. . Some day this will be a very grand finale, but for now");
  }
}


/////////////////////////////////////////////////////////////////////////////////////

//ARRAY STUFF FOR GRABBING RANDOM WITH NO-REPEAT

void handle(String input[], String tempState, int whichInput, int randomInput[]) {
  state= tempState;
  whichInput ++;
  currentInput=whichInput;
  if (whichInput >= input.length) {
    whichInput = 0;
    currentInput=0;
    fillRandomizer(input, randomInput);
  }
  text= input[randomInput[whichInput]];
}

void fillRandomizer(String input [], int randomInput[]) {
  int slot = 0;
  //fill with negative numbers
  for (int i=0; i<input.length; i++) {
    randomInput[i] = -1;
  }
  // fill with unique numbers
  while (slot<input.length) {
    int myRand =   floor(random(0, input.length));
    boolean bFound = false;
    for (int i=0; i<input.length && !bFound; i++) {
      if ( myRand == randomInput[i] )
        bFound = true;
    }
    if (!bFound) {
      randomInput[slot] = myRand;
      slot += 1;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

//KINECT CHALLENGES

//ONSTAGE
void challenge1() { 
  state= "challenge1";
  kinect.update();
  background(0);
  image(kinect.rgbImage(), 0, 0, 1920, 1080); //scaled
  IntVector userList= new IntVector();
  kinect.getUsers(userList);

  //create invisible rectangle with origin in the center of the sketch
  noFill();
  noStroke();
  rect(RX, RY, RW, RH);

  for (int i=0; i<userList.size(); i++) {   //loop to locate person in front of camera
    int userId = userList.get(i);  //get id for each person in camera view
    PVector position = new PVector();
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);

    distance = position.z / 25.4;
    boundaryX = position.x / 25.4;

    //fill(255,0,0);
    //    textAlign(CENTER);
    //    textSize(40);
    //   text(position.x/25.4, position.x, position.y);

    //on/off stage
    if (distance < 105 && boundaryX > 2 && boundaryX < 22 ) {
      fill(255, 0, 0);
      textAlign(CENTER);
      textSize(60);
      text("On Stage", position.x * 3, position.y * 2.5); //scaled
    } else {
      fill(0, 0, 255);
      textAlign(CENTER);
      textSize(60);
      text("Off Stage", position.x * 3, position.y * 2.5); //scaled
    }
    println ("x: " + position.x/25.4 + " y: " + position.y/25.4 + " z:" + position.z/25.4);
  }
}

////////////////////////////////////////////////////

//COME TO STAGE
void challenge2() {
  state= "challenge2";
  kinect.update();
  background(0);
  image(kinect.rgbImage(), 0, 0, 1920, 1080); //scaled

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  //create invisible rectangle with origin in the center of the sketch
  noFill();
  noStroke();
  rect(RX, RY, RW, RH);


  for (int i=0; i<userList.size() && stateKinect == 0; i++) {  //run for loop to locate person in front of camera
    int userId = userList.get(i); //get an id for each person in the camera view.
    PVector position = new PVector();
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);

    distance = position.z / 25.4;
    boundaryX = position.x / 25.4;

    //Detecting the person distance
    if (distance < 175 && boundaryX > 0 && boundaryX < 24) {
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(60);
      text(userId, position.x * 3, position.y * 2.5); // scaled


      if (userId == 3 && stateKinect == 0) {
        delay(3000); //****************PROBLEM!
        rand = int(random(userId));
        stateKinect = 1;
        println(rand +" " + stateKinect);
      }
    }
  }


  if (rand == 0 && stateKinect == 1) {
    choosingPerson();
  } else if (rand == 1 && stateKinect == 1) {
    choosingPerson();
  } else if (rand == 2 && stateKinect == 1) {
    choosingPerson();
  }
}

void choosingPerson() {
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;


  if (distance < 105 && boundaryX > 2 && boundaryX < 22 ) {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(60);
    text("On Stage", person1.x*3, person1.y*2.5); //scaled
  } else {
    noFill();
    strokeWeight(4);
    stroke(0, 255, 0);
    rectMode(CENTER);
    rect(person1.x*3, person1.y*2.5, 100, 200);
    println (rand + " " + stateKinect);
    text("Come on to stage", person1.x*3, person1.y*2.5 + 100);
  }
}

////////////////////////////////////////////////////

//VOTE
void challenge3() {
  state= "challenge3";
  kinect.update();
  background(0);
  image(kinect.rgbImage(), 0, 0, 1920, 1080); //scaled

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  //create invisible rectangle with origin in the center of the sketch
  fill(255);
  //noStroke(); //<------- TURNED OFF STROKE
  rect(RXV, RYV, RWV, RHV);

  //run for loop to locate person in front of camera
  for (int i=0; i<userList.size() && stateKinect == 0; i++) { 

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

    //Set the boundaries for the seats
    if (distance < 175 && boundaryX > 4 && boundaryX < 20) {
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(60);
      // text(userId, position.x*3, position.y*2.5); //scaled

      //Conditional to set the stateKinect 1 (con'e to the next stage) and create a random number if there are 3 users and stateKinect is 0
      if (userId == 3 && stateKinect == 0) {
        delay(3000);  //PROBLEM!!!****************
        rand = int(random(userId));
        stateKinect = 1;
        println(rand +" " + stateKinect);
      }
    }
    println ("x: " + position.x/25.4 + " y: " + position.y/25.4);
  }
  //Conditional to choose different people
  //if random person chosen is a first on Kinect list and stateKinect = 1 which is the next from previous stage
  if (rand == 0 && stateKinect == 1) {
    choosingPersonVote();
    //  stroke(0, 255, 0);
    //rectMode(CENTER);
    //rect(position.x*3, position.y*2.5, 350, 800); //scaled
  } else if (rand == 1 && stateKinect == 1) { //<-- If random person chosen is  second on Kinect list
    choosingPersonVote();
  } else if (rand == 2 && stateKinect == 1) {//<-- If random person chosen is third on Kinect list of users
    choosingPersonVote();
  }
  if (stateKinect == 2)//<-- After the person was chosen, go to stateKinect 2 where the rules of voting would be explained in votingRules() 
  {
    votingRules();
  }
  if (stateKinect == 3) { //<--After rules were explained go to stage three inside of VotingRules() and run votinQ1()
    votingQ1();
  }

  if (stateKinect == 4) //<-- After the answer was recorded go to stage 4 and show the answer
  {
    state= "voteAnswer";
    int userIdChosen = rand + 1;
    PVector person1 = new PVector();
    kinect.getCoM(userIdChosen, person1); 
    kinect.convertRealWorldToProjective(person1, person1);

    //stroke(0, 255, 255);
    //fill(0);
    //DISPLAY
    //rect(50, 50, 450, 200);
    fill(255, 0, 0);
    textSize(60);
    //textAlign(CENTER);
    text("Your answer was: " + vote1, 720, 100);
    if (silence==true) {
      figure.speak ("Your answer was: " + vote1 + ".  .  .  . ");
    }
  } 
}

//Function to choose a person for Challenge 3
void choosingPersonVote()
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
  int passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime = 0;
    stateKinect = 2;
  }

  noFill();
  strokeWeight(4);
  stroke(0, 255, 0);
  rectMode(CENTER);
  rect(person1.x*3, person1.y*2.5, 350, 800); //scaled
  println (rand + " " + stateKinect);
  //stroke(0, 255, 255);
  //fill(0);
  //rect(50, 50, 350, 80);
  fill(255, 0, 0);
  textSize(60);
  //textAlign(CENTER);
  text("Get ready to vote in: " + passedTime, 720, 100);
  if (silence==true) {
    figure.speak ("get ready to vote .  .  .  . .  .  .  .  .  . ");
  }
}   

//Function to vote
void votingRules()
{

  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1); 

  //text(userIdChosen, person1.x*3, person1.y*2.5); // scaled
  //green rectangle
  noFill();
  stroke(0, 255, 0);
  rectMode(CENTER);
  rect(person1.x*3, person1.y*2.5, 350, 800); //scaled

  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 7;
  }
  int passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime=0;
    stateKinect = 3;
  }


  println (rand + " " + stateKinect);
  //stroke(0, 255, 255);
  //fill(0);
  //INSTRUCTIONS BOX
  //rect( 50, 50, 450, 200);
  fill(255, 0, 0);
  textSize(60);
  //textAlign(CENTER);
  text("For the following statement,\nStand up if you agree,\nStay seated if you do not... ", 720, 100);
}


//Function for question 1
void votingQ1()
{

  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);
  //text(userIdChosen, person1.x*3, person1.y*2.5); // Print out numbers on people
  //green rectangle
  noFill();
  stroke(0, 255, 0);
  rectMode(CENTER);
  rect(person1.x*3, person1.y*2.5, 350, 800); //scaled

  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  int passedTime = totalTime - int(millis()/1000);
  //Conditional to check if the person is standing or not
  if (passedTime <= 0) {
    //conditional if the person is within the boundaries of choosing area.
    //println ("x: " + person1.x/25.4 + " y: " + person1.y/25.4);
    if ((person1.x/25.4 >= 8) && (person1.x/25.4 < 18) && (person1.y/25.4 >= 9) && (person1.y/25.4 < 11)) 
    {
      vote1 = " NO!";
    } else 
    {
      vote1=" YES!";
    }
    totalTime = 0;
    stateKinect = 4;
  }

  //stroke(0, 255, 255);
  //fill(0);
  //rect(50, 50, 450, 200);
  fill(255, 0, 0);
  textSize(60);
  //textAlign(CENTER);
  text("Do you believe that your vote will count? " + passedTime, 720, 100);
}

////////////////////////////////////////////////////

//JUMP
void challenge4() {
  state= "challenge4";
  kinect.update();
  background(0);
  image(kinect.rgbImage(), 0, 0, 1920, 1080); //scaled

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  //create invisible rectangle with origin in the center of the sketch
  noFill();
  noStroke();
  rect(RXJ, RYJ, RWJ, RHJ);

  //run for loop to locate person in front of camera
  for (int i=0; i<userList.size() && stateKinect == 0; i++) { 

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
      text(userId, position.x*3, position.y*2.5); // Print out numbers on people

      if (userId == 3 && stateKinect == 0) {
        delay(3000); //PROBLEM **********************
        rand = int(random(userId));
        stateKinect = 1;
        println(rand +" " + stateKinect);
      }
    }
  }
  if (rand == 0 && stateKinect == 1) {
    choosingPersonJump();
  } else if (rand == 1 && stateKinect == 1) {
    choosingPersonJump();
  } else if (rand == 2 && stateKinect == 1) {
    choosingPersonJump();
  }
  if (stateKinect== 2)
  {
    jumpingStart();
  }
  if (stateKinect==3)
  {
    jump();
  }
  if (stateKinect==4)
  {
    postJump();
  }
}

void choosingPersonJump()
{
  int userIdChosen = rand + 1;
  PVector person1 = new PVector();
  kinect.getCoM(userIdChosen, person1); 
  kinect.convertRealWorldToProjective(person1, person1);  
  distance = person1.z / 25.4;
  boundaryX = person1.x / 25.4;

  if (distance < 105 && boundaryX > 2 && boundaryX < 22 ) {
    stroke(0, 255, 255);
    //fill(0);
    //rect(person1.x, person1.y - 160, 350, 80);
    fill(0, 255, 255);
    textSize(60);
    textAlign(CENTER);
    text("Welcome!", person1.x*3, person1.y*2.5 -160);
    if (silence==true) {
      figure.speak ("welcome! .  .  . . . . ");
    }
    //green rectangle
    noFill();
    stroke(0, 255, 0);
    rectMode(CENTER);
    rect(person1.x*3, person1.y*2.5, 350, 800); //scaled
    if (totalTime == 0)
    {
      totalTime=millis()/1000 + 4;
    }
    int passedTime = totalTime - int(millis()/1000);
    if (passedTime <= 0) 
    {
      totalTime=0;
      stateKinect = 2;
    }
  } else {
    noFill();
    strokeWeight(4);
    stroke(0, 255, 0);
    // rectMode(CENTER);
    // rect(person1.x*3, person1.y*2.5, 100, 200);
    println (rand + " " + stateKinect);
    stroke(0, 255, 255);
    fill(0);
    //rect(person1.x*3, person1.y*2.5 - 160, 350, 80);
    fill(0, 255, 255);
    textSize(60);
    textAlign(CENTER);
    text("Come to the stage!\nQuick!", person1.x*3, person1.y*2.5 -160);
    if (silence==true) {
      figure.speak ("come to the stage! stand on the x");
    }
    //green rectangle
    noFill();
    stroke(0, 255, 0);
    rectMode(CENTER);
    rect(person1.x*3, person1.y*2.5, 350, 800); //scaled
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
    stateKinect = 3;
  }
  stroke(0, 255, 255);
  fill(0);
  //rect(width/2, height, 360, 240);
  fill(0, 255, 255);
  //text(a, person1.x*3, person1.y*2.5);
  textSize(60);
  textAlign(CENTER);
  text("Let's see how high you \ncan jump! Get ready!\n" + passedTime + "...", width/4, 200);
  if (silence==true) {
    figure.speak ("get ready to jump! .   ");
  }
  //green rectangle
  noFill();
  stroke(0, 255, 0);
  rectMode(CENTER);
  rect(person1.x*3, person1.y*2.5, 350, 800); //scaled
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
  //text(b, person1.x*3, person1.y*2.5);

  if (totalTime == 0)
  {
    totalTime=millis()/1000 + 3;
  }
  int passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) 
  {
    totalTime=0;
    stateKinect = 4;
  }

  if (person1.y < a)
  {
    b = person1.y;
    if (b<lowest) {
      lowest = b;
    }
  }

  stroke(0, 255, 255);
  fill(0);
  //rect(width/2, height, 360, 240);
  fill(0, 255, 255);
  textSize(60);
  textAlign(CENTER);
  text("JUMP!", width/4, 500);
  if (silence==true) {
    figure.speak ("jump! .  .  .");
  }
  //Tell the participants to keep their arms down
  //Messes with the center of mass if they don't
}

void postJump()
{
  state= "postJump"; 
  c = a - lowest;
  c = c / 5.4;
  println("jump height is:  " + c);
  println("B was: " + b);
  println("A was: " + a);
  println("lowest was: " + lowest);
  textSize(60);
  text("You jumped: " + int(c) + " inches!", width/4, 100);
  if (silence==true) {
    figure.speak ("you jumped " + int(c) + "inches .  .  .  . .  .  .  .  .  . ");   
 }  
}
