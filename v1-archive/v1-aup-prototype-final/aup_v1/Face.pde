
//modified masks to move left to right for vertical projection

class Face {
  int x, y, w, h;
  float move;
  String eye;
  int timer= 6000;  
  int currentTime=0; 
  int savedTime=0;


  Face () {
  }


  void eye(int x, int y, int w, int h) {
    fill (0);
    ellipse (x, y, w, h);
    noStroke();
    rectMode(CENTER);
    // fill(255, 0, 0); // testing 
    fill(255);

    currentTime= millis();
    if ((currentTime- savedTime) > timer) {
      eye= "right";
      //println ("timer triggered");
      savedTime= currentTime;
      timer= int(random(4000, 12000));
    }

    rect (x-w-10+move, y, w+10, h+10);
    if (x-w-10+move< x-w-10) {
      eye= "still";
    }
    if (x-w+move>x) {
      eye="left";
    } 
    if (eye =="right") {
      move+=.8;
    }
    if (eye== "left") {
      move-=.8;
    }
    if (eye== "still") {
      move=0;
    }
     rectMode(CORNER);
  }
}
