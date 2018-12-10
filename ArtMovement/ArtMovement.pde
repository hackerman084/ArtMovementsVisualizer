import processing.video.*;
import controlP5.*;
import java.util.HashMap; 
Capture cam; 
PImage img; 
HashMap<String, Color> skin;
int skinThreshold; 
color skinColor;
HashMap<String, Color> palette;
ArrayList<PVector> dots = new ArrayList<PVector>();
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
 palette.put("black", new Color(color(0,0,0)));
 palette.put("white", new Color(color(0,100,100)));
 
 cam = new Capture(this, width, height, 30); //x,y resolution, freq of capture in frames per second
 img = new PImage(width, height); 
 
 for(int i = 0; i < 20000; i++){
    int x = (int)  random(width); 
    int y = (int) random(height);
    dots.add(new PVector(x,y));
  }
  
 cam.start();  
}

void draw(){
 background(255);
 //image(img,0,0);
 //popArt(4);
 
 pointilism();
 //noLoop();
}

color nearestSkinColor(color c){
  //near enough the skin tones to check if it's one
  if ((hue(c) % 360) > 0 && (hue(c) % 360) < 60 && saturation(c) > 0 && saturation(c) < 60){
    //check skintones
     if (brightness(c) > 60){
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
    if (hue(c) > 0 && hue(c) < 70){ 
      if (brightness(c) > 80){
        if (saturation(c) >= 20){
          return palette.get("yellow").c; 
        }
        else{
          return palette.get("white").c;
        }
      }
      else if (brightness(c) > 40) {
          if (saturation(c) <= 50) {
              return palette.get("white").c;
          }
          else{
            return palette.get("black").c;
          }
      }
      else{
        if (saturation(c) <= 50) {
              return palette.get("white").c;
          }
          else{
            return palette.get("black").c;
          }
      }
    }
    else if (hue(c) >= 70 && hue(c) < 260){
      if (brightness(c) > 50){
        if (saturation(c) > 30){
          return palette.get("cyan").c; 
        }
        else{
          return palette.get("black").c; 
        }
      }
      else{
        if (saturation(c) > 20){
          return palette.get("cyan").c; 
        }
        else{
          return palette.get("black").c;
        }
        
      }
    }
    else {
      if (brightness(c) > 50){
        if (saturation(c) > 70){
          return palette.get("red").c; 
        }
        else{
          return palette.get("white").c;
        }
      }
      else{
        if (saturation(c) > 40){
          return palette.get("red").c;
        }
        else{
          return palette.get("black").c;
        }
      }
      
    } 
  }
  
}
void popArt(int rangeSize) {
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    pixels[i] = nearestSkinColor(pixels[i]);
  }
  updatePixels();
  
  for(int x = 0; x < width; x+=15){
  for(int y = 0; y < width; y+= 15){
   noStroke(); 
   fill(255, 255);
   ellipse(x,y,7,7);
  }
  }
}

void pointilism(){
  for(PVector dot : dots){
    noStroke();
    fill(img.get((int) dot.x,(int) dot.y), noise(dot.x, dot.y) * 300);
    float point = noise(dot.x, dot.y) * 20;
    ellipse(dot.x, dot.y, point, point);
  }
}

void captureEvent(Capture cam) {
  cam.read();
  img = cam;
}
