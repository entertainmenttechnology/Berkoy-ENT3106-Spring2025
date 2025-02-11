/*
///////////////////////////////////////////////////////////////
OBJECT ORIENTED PROGRAMMING

Another OOP demo.
Creates a row of 5 ellipse objects.
When hovering mouse over ellipse, each one fades and falls.

Demo by Prof Berkoy
///////////////////////////////////////////////////////////////
*/


let magnet = []; //declare object array
magnet.length = 5; //sets length of array

function setup() {
	createCanvas(500, 500);
	//initialize each object by calling constructor
	for (let i = 0; i < magnet.length; i++) {
		magnet[i] = new Magnet(i * 100 + 50, 100); //pass ellipse x,y position into each object
	}
}

function draw() {
	background(255);
	for (let i = 0; i < magnet.length; i++) {
		magnet[i].display();
		magnet[i].fall();
	}
}

class Magnet {
	//constructor
	constructor(tempX, tempY) {
		this.x = tempX;
		this.y = tempY;
		this.dist = 50;
		this.fade = 0;
		this.drop = 0;
		this.goFall = false;
	}

	//methods
	display() {
		fill(this.fade);
		ellipse(this.x, this.y + this.drop, this.dist, this.dist);
	}

	fall() {
		if (mouseX > this.x - this.dist / 2 && mouseX < this.x + this.dist / 2 && mouseY > this.y - this.dist / 2 && mouseY < this.y + this.dist / 2) {
			this.goFall = true;
		}
		if (this.goFall === true) {
			if (this.fade < 255) {
				this.fade++;
			}
			if (this.drop < height + this.dist) {
				this.drop++;
			}
		}
	}
}