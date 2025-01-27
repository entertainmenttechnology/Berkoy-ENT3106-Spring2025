/*
////////////////////////////////////////////////////////
 EMERGENCY JOKES
 
 Click mouse to select random joke.
 ////////////////////////////////////////////////////////
 */

//JOKE STUFF
String [] joke= {
  "Here we go. .  Joke One . . .  Punch line!", 
  "Here we go. .  Joke Two . . .  Punch line!", 
  "Here we go. .  Joke Three . . .  Punch line!", 
  "Here we go. .  Joke Four . . .  Punch line!", 
  "Here we go. .  Joke Five . . .  Punch line!"
};
int whichJoke;
int[] randomJoke= new int [joke.length];


//MORE VARIABLES
String text, state;
int currentInput, whichInput, randomInput;



void setup() {
  //FILL ARRAYS FOR RANDOMIZATON
  fillRandomizer(joke, randomJoke);
}

void draw() {
}

void mousePressed() {
  joke();
}

void joke() {
  handle(joke, "joke", whichJoke, randomJoke);
  whichJoke= currentInput;
  //figure.speak(text);
  println(text);
}



/////////////////////////////////////////////////////////////////////////////////////

//ARRAY STUFF FOR GRABBING RANDOM WITH NO-REPEAT

void handle(String input[], String tempState, int whichInput, int randomInput[]) {
  state= tempState;
  whichInput ++;
  currentInput=whichInput;
  if (whichInput >= input.length) {
    whichInput = 0;
    currentInput=0;
    fillRandomizer(input, randomInput);
  }
  text= input[randomInput[whichInput]];
}

void fillRandomizer(String input [], int randomInput[]) {
  int slot = 0;
  //fill with negative numbers
  for (int i=0; i<input.length; i++) {
    randomInput[i] = -1;
  }
  // fill with unique numbers
  while (slot<input.length) {
    int myRand =   floor(random(0, input.length));
    boolean bFound = false;
    for (int i=0; i<input.length && !bFound; i++) {
      if ( myRand == randomInput[i] )
        bFound = true;
    }
    if (!bFound) {
      randomInput[slot] = myRand;
      slot += 1;
    }
  }
}
