/*
////////////////////////////////////////////////////////////////////////////////////////
WORKING WITH IMAGE ASSETS
 
Image file named "cupcake.png" is added to project folder. 
Note the use of preload() in this sketch for loading assets before setup() is called. 

Demo by Prof Berkoy
////////////////////////////////////////////////////////////////////////////////////////
 */


//Create a p5.Image object to store image
let cupcake; //Declares p5.Image object called cupcake


//Load image assets into preload() to avoid asynchronous loading errors
function preload() {
	cupcake = loadImage("cupcake.png"); //Assign image asset to p5.Image object using loadImage() 
}

//setup() is called AFTER preload() is complete and runs one time only
function setup() {
	createCanvas(500, 500);
	background(255);
	imageMode(CENTER); //draws images from center point
}

//draw() runs continuously after preload() and setup() are complete
function draw() {
	background(255);

	//display image with image() 
	//image (name of image, x location, y location);
	image(cupcake, width / 2, height / 2); // center cupcake

	//optionally add 4th and 5th parameters to adjust size
	//image (name of image, x location, y location, width, height);
	//optionally call .width and .height to return original size 
	image(cupcake, width / 4, height - height / 3, cupcake.width / 2, cupcake.height / 2); //left cupcake
	image(cupcake, width - width / 4, height - height / 3, cupcake.width / 2, cupcake.height / 2); //right cupcake
}