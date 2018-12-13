class Color{
 public color c; 
 
 public Color(color c){
   this.c = c; 
 } 
}


class Brush{
  public PImage brush; 
  public PVector loc; 
  public color tint;
  public float rot;
 
  
  public Brush(PVector loc){
    this.brush = loadImage("brushstroke.png").copy();
    int img_size = (int) random(20,40);
    this.brush.resize(img_size, img_size);
    this.loc = loc; 
    rot = radians(noise(loc.x, loc.y) * 360);
  }
  
  public void display(color c){
     pushMatrix(); 
     translate(loc.x, loc.y); 
     rotate(rot); 
     tint(c);
     image(this.brush,0,0);
     popMatrix();
  }
  
  
  
}

 
