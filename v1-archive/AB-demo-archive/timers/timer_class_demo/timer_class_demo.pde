/*
////////////////////////////////////////////////////////
 Demo on timers, using Timer Class
 
 Moves through "intro", "middle", and "end" states via timers. 
 ////////////////////////////////////////////////////////
 */


//Create Timer Objects
Timer timerIntro;
Timer timerMiddle;
Timer timerEnd;

String state = "intro";

void setup() {
  //assign timer values in milliseconds
  timerIntro= new Timer (3000);  
  timerMiddle= new Timer (7000);
  timerEnd= new Timer (5000);

  timerIntro.start();
  println ("intro is starting");
}

void draw() {
  if (state == "intro") {
    if (timerIntro.isFinished()) {
      println ("intro is finished. now it's the middle.");
      state= "middle"; 
      timerMiddle.start();
    }
  } else if (state == "middle") {
    if (timerMiddle.isFinished()) {
      println ("middle is finished. now this is the ending.");
      state= "end";
      timerEnd.start();
    }
  } else if (state == "end") {
    if (timerEnd.isFinished()) {
      println ("the ending is done. there is no more.");
      state= "done";
    }
    //println (state);
  }
}
