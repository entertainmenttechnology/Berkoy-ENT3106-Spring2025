/*
////////////////////////////////////////////////////////
TEXT-TO-SPEECH + FACE
 
 Press key to test.
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 ////////////////////////////////////////////////////////
 */

import java.util.*;
Figure figure;  //creates new object from Figure class
String voice= "fred"; //keep voice as "fred" if no other voices installed
int voiceSpeed= 100;

Face face; //creates new object from Face class
//***callibrate face in draw***


boolean silence= true; 

void setup() {
  size (800, 800);
  figure = new Figure(voice, voiceSpeed); //input installed voice name and speed
  face= new Face();
}

void draw() {
  background (255);
  fill (0);

  ///////////////////callibrate face////////////////////////////////
  face.eye(width/2, height/3, 50, 50);  //x, y, width, height
  face.eye(width/2 + 75, height/3, 50, 50);
  

  if (figure.isSpeaking()) {
    silence= false;
  } else {
    silence=true;
  }
}

void keyPressed() {
  if (key=='1') {
    figure.speak("Hello, this is a text to speech demo. We are testing voices for legibility. How clearly can you understand me?");
  }
}
