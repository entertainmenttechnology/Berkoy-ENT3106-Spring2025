/*
///////////////////////////////////////////////////////////////
OBJECT ORIENTED PROGRAMMING

Creating objects and classes. 

This sketch rewrites the icecream function sketch from our 
earlier demo on functions and adds additional methods.
Refer back to that sketch and explore how it might be 
restructured with OOP. 

Press '1' and '2' keys to expand and contract the scoop size.

***************************************************************

BASIC OOP PSEUDOCODE:

declare the object
(let objectName;)

function setup(){
  create new instance of the object from constructor
	(objectName = new ClassName(optional arguments));
}

function draw(){
  call methods on the object
}

class ClassName{  //class name is capitalized
  constructor() //constructs the object, like setup()
	methods() // like functions for the class
}

***************************************************************

Demo by Prof Berkoy
///////////////////////////////////////////////////////////////
*/


//set up objects
let icecream1;
let icecream2;

function setup() {
  createCanvas (500, 500);
  //initialize objects in setup() by calling the constructor
  //nameOfObject= new ClassName();
  icecream1= new Icecream(100, 250, 65);
  icecream2= new Icecream(300, 350, 75);
}

function draw() {
  background(255);
  //call methods on the object from within draw()
  icecream1.display(); 
  icecream2.display();
  icecream1.fall();
  icecream2.fall();
  icecream1.grow();
  icecream2.grow();
}

//define the class outside of setup() and draw()
//typically placed below draw or as a separate file tab
//name of class gets capitalized

class Icecream {
  
  //**constructor**
  //like setup() function within class
  //constructor arguments are temporary and used to initialize values inside object
  constructor(tempX, tempY, tempDiameter) {
    this.x= tempX;
    this.y= tempY;
    this.diameter= tempDiameter;
  }

  //**methods** 
  //these are like functions for the object
  display() { //method
    triangle(this.x, this.y, this.x+50, this.y, this.x+25, this.y+100);
    ellipse(this.x+25, this.y, this.diameter, this.diameter);
  } 

  fall() { //method
    if (this.y>height+100) {
      this.y=-100;
    } else {
      this.y++;
    }
  }

  grow() { //method
    this.diameter=constrain(this.diameter, 0, width); //constrains values of this.diameter between 0 and width
    if (keyIsPressed) {
      if (key=== '1') {
        this.diameter++;
      } else if (key==='2') {
        this.diameter--;
      }
    }
  }
}