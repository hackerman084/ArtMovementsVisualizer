import processing.video.*;
import controlP5.*;
import java.util.HashMap; 
Capture cam; 
PImage img; 
PImage brush ; 
HashMap<String, Color> skin;
int skinThreshold; 
color skinColor;
HashMap<String, Color> palette;
ArrayList<PVector> dots = new ArrayList<PVector>();
ArrayList<Brush> brushes = new ArrayList<Brush>();
ArrayList<PImage> brushset; 
float size = 1000;
ControlP5 controlP5;
DropdownList p1;
float chosen_option = -1.0; 

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
 brushset = new ArrayList<PImage>();
 brushset.add(loadImage("brushstroke.png"));
 brushset.add(loadImage("brushstroke2.png"));
 brushset.add(loadImage("brushstroke3.png"));
 brushset.add(loadImage("brushstroke4.png"));
 brushset.add(loadImage("brushstroke5.png"));
 brushset.add(loadImage("brushstroke6.png"));
 brushset.add(loadImage("brushstroke7.png"));
 brushset.add(loadImage("brushstroke8.png"));

 for(PImage a : brushset){
  a.resize(40,40); 
 }


 for(int i = 0; i < 20000; i++){
    int x = (int)  random(width); 
    int y = (int) random(height);
    dots.add(new PVector(x,y));
 }

 
 controlP5 = new ControlP5(this);
  p1 = controlP5.addDropdownList("MovementSelect",width/2-50,100,100,120);
  customize(p1);
 cam.start();  
}

void customize(DropdownList ddl) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.addItem("Pop Art", 0); // give each item a value, in this example starting from zero
  ddl.addItem("Pointilism", 1);
  ddl.addItem("Impressionism", 2);

  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255,128));
  //ddl.enableCollapse();
  ddl.setItemHeight(20);
  //ddl.actAsPulldownMenu(true);
}

void controlEvent(ControlEvent theEvent) {
  // if the event is from a group, which is the case with the dropdownlist
  if (theEvent.isGroup()) {
    // if the name of the event is equal to ImageSelect (aka the name of our dropdownlist)
   
  } else if(theEvent.isController()) {
    // not used in this sketch, but has to be included
     if (theEvent.isFrom("MovementSelect")) {
      // then do stuff, in this case: set the variable selectedImage to the value associated
      // with the item from the dropdownlist (which in this case is either 0 or 1)
      println("CONTROL: "+theEvent.getValue()); 
      chosen_option = int(theEvent.getValue());
    }
  }
}

void draw(){
 background(0, 0, 100);

 if (chosen_option == 0){
  image(img,0,0);
  popArt(); 
 }
 else if (chosen_option == 1){
  pointilism();
 }
 else if (chosen_option == 2){
    impressionism();

   
 }
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
void popArt() {
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

void impressionism(){
  for(int i = 0; i < dots.size(); i++){
    PVector dot = dots.get(i);
    tint(img.get((int) dot.x, (int) dot.y), noise(dot.x, dot.y)*300);
    
    image(brushset.get((int) random(8)), dot.x, dot.y); 
  }
}



void captureEvent(Capture cam) {
  cam.read();
  img = cam;
}
