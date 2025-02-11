/*
////////////////////////////////////////////////////////////////////////
ARRAY

Using for loops to fill and iterate through arrays.

Demo by Prof Berkoy
////////////////////////////////////////////////////////////////////////
*/


let pointX = []; //declare array called pointX
pointX.length = 100; //set length of pointX array to 100

let pointY = []; //declare array called pointY
pointY.length = 100; //set length of pointY array to 100

let move = 1.25; // variable for ellipse movement


function setup() {
	createCanvas(800, 800);

	//initializing the array with for loop and random numbers
	for (let i = 0; i < pointX.length; i++) {
		pointX[i] = random(width);
		pointY[i] = random(height);
	}
}

function draw() {
	background(0);

	//draw ellipses
	stroke(100);
	noFill();

	//iterate through array and draw ellipses
	for (let i = 0; i < pointX.length; i++) {
		ellipse(pointX[i] + move, pointY[i], 20, 20);
	}

	//draw lines
	stroke(255, 0, 0);
	for (let i = 0; i < pointX.length; i++) {
		line(pointX[i], pointY[i], mouseX, mouseY);

		//if ellipses go off canvas, move the other direction
		if (pointX[i] + move > width * 2 || pointX[i] + move < -width) {
			move = -move;
		} else {
			pointX[i] += move;
		}
	}
}