/*
///////////////////////////////////////////////////////////////
OBJECT ORIENTED PROGRAMMING

Another OOP demo with array of objects.

Demo by Prof Berkoy
///////////////////////////////////////////////////////////////
*/


let ellipses = []; // declares object array
ellipses.length = 111; // sets length of array

function setup() {
	createCanvas(800, 800);
	for (let i = 0; i < ellipses.length; i++) {
		ellipses[i] = new Movement(random(width), random(height), random(100), random(100));
	}
}

function draw() {
	background(200, 50, 150);
	for (let i = 0; i < ellipses.length; i++) {
		ellipses[i].display();
		ellipses[i].move();
	}
}

class Movement {
	constructor(tempX, tempY, tempW, tempH){
		this.x = tempX;
		this.y = tempY;
		this.w = tempW;
		this.h = tempH;
		this.xMove = random(3);
		this.ranStrokeWeight = random(20);
	}

	display() {
		strokeWeight(this.ranStrokeWeight);
		ellipse(this.x, this.y, this.w, this.h);
	}

	move() {
		this.x += this.xMove;
		if (this.x > width || this.x < 0) {
			this.xMove = -this.xMove;
		}
	}
}