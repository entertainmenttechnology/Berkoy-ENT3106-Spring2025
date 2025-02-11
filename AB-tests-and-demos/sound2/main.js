/*
/////////////////////////////////////////////////////////////////////////////////
P5.js SOUND LIBRARY

Another example of loading and triggering sound files.

Notes:
* Include and set path to sound files, similar to image files.
* Include sound library in index.html file (as included in this demo).
* Due to browser security, sounds may be blocked from playing automatically at
  sketch start up. Include "user gesture" to trigger sound, such as mouse click,	
  key press, etc. 

See reference for p5.SoundFile methods and examples: 
https://p5js.org/reference/p5.sound/ 

Click on 'sample 1' and 'sample 2' buttons to loop sound from start of sample.

(Sound samples by Helado Negro and Arlt.) 

Demo by Prof Berkoy
/////////////////////////////////////////////////////////////////////////////////
*/


//declare p5.SoundFile objects
let sample1;
let sample2;
let currentSound; // this will hold different p5.SoundFile objects

//declare variables for buttons and set to false by default
let button1= false;
let button2= false;

//Use function preload() before setup() to load sound files
function preload() {
	let path = "assets/";
	sample1 = loadSound(path + "sample1.ogg");
	sample2 = loadSound(path + "sample2.ogg");
}

function setup() {
	createCanvas(600,600);
	textSize(44);
	rectMode(CENTER);
	textAlign(CENTER,CENTER);
	currentSound= sample1; //assigning a sound file here as a placeholder
}

function draw() {
	background(255);

	//top button	
	rect(width/2, height/2-100, 200, 50);
	text("sample 1", width/2, height/2 - 100);
	
	//bottom button
	rect(width/2, height/2+100, 200, 50);
	text("sample 2", width/2, height/2 + 100);
}

function mousePressed() {
	//in boundaries of top button?
	if(mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height/2 - 125 && mouseY < height/2 -75){
		print("button1");
		button1= true;
	//in boundaries of buttom button?
	} else if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height/2 + 75 && mouseY < height/2 + 125){
		print("button2");
		button2= true;
	}
	handleSound();
}

function handleSound(){
	if (button1){
		currentSound.stop(); //stops sound and "rewinds" playhead
		currentSound= sample1; //assign sample1
		currentSound.loop(); //loop
		button1 = false; // reset button trigger
	} else if (button2){
		currentSound.stop();
		currentSound= sample2;
		currentSound.loop();
		button2 = false;
	} else {
		// do nothing 
	}
}
