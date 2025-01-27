// Modification from Daniel Shiffman's Learning Processing ex 10-5

class Timer {
  int savedTime; // when timer started
  int timerDuration; //how long timer should last

  Timer (int tempTimerDuration) {
    timerDuration = tempTimerDuration;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds
    savedTime = millis();
  }

  boolean isFinished() {
    // Check how much time has passed
    int passedTime = millis() -savedTime;
    if (passedTime > timerDuration) {
      return true;
    } else {
      return false;
    }
  }
}
