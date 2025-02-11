/*
////////////////////////////////////////////////////////////////////////////////////////
ARRAY OF IMAGES

Loads images into an array and displays a random image with mouse press.

Note that the sketch shows TWO ways to load images into an array.
Use the individual method, or the loop method, but not both. 
 
Demo by Prof Berkoy
////////////////////////////////////////////////////////////////////////////////////////
 */


let cake= [];  // declares array named cake
cake.length= 6; // sets length of array

let whichCake=0; // creates variable for tracking position in cake array


function preload(){
    let path= "assets/"; 

  	//loading each image into array individually
    cake[0]= loadImage (path + "cake0.png");
    cake[1]= loadImage (path + "cake1.png");
    cake[2]= loadImage (path + "cake2.png");
    cake[3]= loadImage (path + "cake3.png");
    cake[4]= loadImage (path + "cake4.png");
    cake[5]= loadImage (path + "cake5.png");
 
    /*
    //loading images in with for loop 
    //(this only works if image files are named consistently and numbered)
    for (let i=0; i<cake.length; i++){
      cake[i]= loadImage (path + "cake" + [i] + ".png")
    }
    */
   
}

function setup() {
  createCanvas(500, 500); 
  imageMode(CENTER); 
}


function draw() {
  background(0);
  image(cake[whichCake], width/2, height/2, 200, 200);

  //print (whichCake);
}

function mousePressed() {
  whichCake=int(random(cake.length)); //note the need for int() conversion as random returns a floating decimal value
}