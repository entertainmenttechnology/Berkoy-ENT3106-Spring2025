/*
//////////////////////////////////////////////////////////////////////
 TTS CLASS
 
 Adapted from Eric Mika:
 http://www.frontiernerds.com/text-to-speech-in-processing 
 
 //////////////////////////////////////////////////////////////////////
 */

import java.io.IOException;

static class TextToSpeech extends Object {

  // sample voice
  //static final String ALEX = "Alex";

  // this sends the "say" command to the terminal with the appropriate args
  public static Process say(String script, String voice, int speed) {
    try {
      return Runtime.getRuntime().exec(new String[] {
        "say", "-v", voice, "[[rate " + speed + "]]" + script
      }
      );
    }
    catch (IOException e) {
      System.err.println("IOException");
      return null;
    }
  }
}
