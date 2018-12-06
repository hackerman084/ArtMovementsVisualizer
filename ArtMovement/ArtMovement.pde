import processing.video.*;
import controlP5.*;
import java.util.HashMap; 
Capture cam; 
PImage img; 
HashMap<String, Color> skin;
int skinThreshold; 
color skinColor;
HashMap<String, Color> palette;

void setup(){
 size(640, 480); 
 colorMode(HSB, 360, 100,100);
 skin = new HashMap<String, Color>();
 palette = new HashMap<String, Color>();

 //default skin tones for the pop art. Purposefully wanted it to be same hue / saturation 
 skin.put("white", new Color(color(39,47,99))); 
 skin.put("tan", new Color(color(39,47,69))); 
 skin.put("brown", new Color(color(39, 47,29)));
 palette.put("yellow", new Color(color(57,100,100))); 
 palette.put("cyan", new Color(color(184,100,100)));
 palette.put("red", new Color(color(355,100,100))); 

 cam = new Capture(this, width, height, 30); //x,y resolution, freq of capture in frames per second
 img = new PImage(width, height); 
 cam.start();  
}

void draw(){
 background(255);
 image(img,0,0);
 popArt(4);
}

color nearestSkinColor(color c){
  //near enough the skin tones to check if it's one
  if (hue(c) > 0 && hue(c) < 60 && saturation(c) > 20 && saturation(c) < 90){
    //check skintones
     if (brightness(c) > 80){
       return skin.get("white").c; 
     }
     else if (brightness(c) > 50){
       return skin.get("tan").c; 
     }
     else{
      return skin.get("brown").c; 
     }
  }
  else{
    //map the color to the palette
    if (hue(c) < 60){
     return palette.get("yellow").c;  
    }
    else if (hue(c) < 200){
     return palette.get("cyan").c; 
    }
    else{
     return palette.get("red").c; 
    }
    
  }
}
void popArt(int rangeSize) {
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    pixels[i] = nearestSkinColor(pixels[i]);
  }
  updatePixels();
}

void captureEvent(Capture cam) {
  cam.read();
  img = cam;
}
