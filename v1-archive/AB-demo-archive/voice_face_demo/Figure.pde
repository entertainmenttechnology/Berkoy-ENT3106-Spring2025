class Figure {
  int voiceSpeed;
  String voiceName;
  Process lastVoiceProcess;
  boolean speakingNow;
  
  Figure(String voice, int speed) {
    voiceSpeed = speed;
    voiceName = voice;
    speakingNow = false;
  }
  
  void speak(String script) {
    (new TimerThread(this, script)).start();
  }
  
  boolean isSpeaking() {
    return speakingNow;
  }
  
  void threadedSpeak(String script) {
    try {
      lastVoiceProcess = TextToSpeech.say(script, voiceName, voiceSpeed);
      speakingNow = true;
      lastVoiceProcess.waitFor();
      speakingNow = false;
    }
    catch (InterruptedException e) {
      System.err.println("InterruptedException");
    }
  }
}

private static class TimerThread extends Thread {
  Figure figure;
  String script;
  TimerThread(Figure f, String s) {
    figure = f;
    script = s;
  }
  public void run() {
    figure.threadedSpeak(script);
  }
}
