/*
/////////////////////////////////////////////////////////////////////////////////
P5.js SOUND LIBRARY

Example of loading and triggering sound files.

Notes:
* Include and set path to sound files, similar to image files.
* Include sound library in index.html file (as included in this demo).
* Due to browser security, sounds may be blocked from playing automatically at
  sketch start up. Include "user gesture" to trigger sound, such as mouse click,	
  key press, etc. 

See reference for p5.SoundFile methods and examples: 
https://p5js.org/reference/p5.sound/ 

Click mouse. One sound loops. Mouse click triggers single play of second sound.

Demo by Prof Berkoy
/////////////////////////////////////////////////////////////////////////////////
*/


//declare p5.SoundFile objects
let applause;
let water;

//Use function preload() before setup() to load sound files
function preload() {
	let path = "assets/"
	applause = loadSound(path + 'applause.mp3');
	water = loadSound(path + 'water.mp3');
}

function setup() {
	createCanvas(windowWidth, windowHeight);
	textSize(88);
	water.loop(); //calling .loop() method on p5.SoundFile object
}

function draw() {
	background(255);
	text("click", 0, windowHeight / 2);
}

function mousePressed() {
	if (!applause.isPlaying()) { // if the applause file is not playing
		applause.play(); //play the applause file one time
	}
}