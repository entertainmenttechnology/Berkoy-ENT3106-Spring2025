/*
////////////////////////////////////////////////////////
 DEMO FOR TEXT-TO-SPEECH
 
 Press key to test.
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 ////////////////////////////////////////////////////////
 */

import java.util.*;
Figure figure;  //creates new object from Figure class
String voice= "fred"; //keep voice as "fred" if no other voices installed
boolean silence= true; 

void setup() {
  figure = new Figure(voice, 100); //input installed voice name and speed
}

void draw() {
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
