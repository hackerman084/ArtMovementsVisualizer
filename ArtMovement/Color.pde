class Color{
 public color c; 
 
 public Color(color c){
   this.c = c; 
 } 
}


class Brush{
  public PImage brush = loadImage("brushstroke.png"); 
  public PVector loc; 
  public color tint; 
  
  public Brush(color c, PVector loc){
    loc = this.loc; 
    this.tint = c; 
  }
  
  public void display(){
     pushMatrix(); 
     translate(loc.x, loc.y); 
     rotate(radians(noise(loc.x, loc.y) * 360));
     scale(int(random(0,2)));
     image(brush, 0,0); 
     popMatrix(); 
  }
  
  
  
}

 
