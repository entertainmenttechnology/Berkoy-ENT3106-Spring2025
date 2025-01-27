

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
      eye= "down";
      //println ("timer triggered");
      savedTime= currentTime;
      timer= int(random(4000, 12000));
    }

    rect (x, y-h-10+move, w+10, h+10);
    if (y-h-10+move< y-h-10) {
      eye= "still";
    }
    if (y-h+move>y) {
      eye="up";
    } 
    if (eye =="up") {
      move-=.8;
    }
    if (eye== "down") {
      move+=.8;
    }
    if (eye== "still") {
      move=0;
    }
  }
}
