/*
///////////////////////////////////////////////////////////////
OBJECT ORIENTED PROGRAMMING

This sketch creates an array of objects from the Icecream 
class created in the prior demo. 

Press '1' and '2' keys to expand and contract the scoop size.

Demo by Prof Berkoy
///////////////////////////////////////////////////////////////
*/


let icecreams = [];  //declare object array 
icecreams.length = 100; //set array length

function setup() {
	createCanvas(800, 800);
	//initialize objects by calling the constructor with a for loop
	for (let i = 0; i < icecreams.length; i++) {
		icecreams[i] = new Icecream(random(width), random(-200, height + 200), 65);
	}
}

function draw() {
	background(255);
	//call methods on the objects 
	//the for loop increments through each object in the array
	for (let i = 0; i < icecreams.length; i++) {
		icecreams[i].display();
		icecreams[i].fall();
		icecreams[i].grow();
	}
}

class Icecream {

	//**constructor**
	//like setup() function within class
	//constructor arguments are temporary and used to initialize values inside object
	constructor(tempX, tempY, tempDiameter) {
		this.x = tempX;
		this.y = tempY;
		this.diameter = tempDiameter;
		this.move = random(0.1,1); 
	}

	//**methods** 
	//these are functions for the object
	display() { //method
		triangle(this.x, this.y, this.x + 50, this.y, this.x + 25, this.y + 100);
		ellipse(this.x + 25, this.y, this.diameter, this.diameter);
	}

	fall() { //method
		if (this.y > height + 100) {
			this.y = -100;
		} else {
			this.y+= this.move;
		}
	}

	grow() { //method
		this.diameter = constrain(this.diameter, 0, width);
		if (keyIsPressed) {
			if (key === '1') {
				this.diameter++;
			} else if (key === '2') {
				this.diameter--;
			}
		}
	}
}