class Color{
 public color c; 
 
 public Color(color c){
   this.c = c; 
 } 
}


class Brushes{
  public PImage brush = loadImage("brushstroke.png"); 
  public PVector loc; 
  public color tint; 
  ArrayList<PImage> brushes;
  
  
  public Brushes(){
    ArrayList<PImage> brushes = new ArrayList<PImage>();
    float size = 10; 
    for(int i = 0; i < size; i++){
       int img_size = (int) random(20,40);
       img.resize(img_size, img_size);  
       brushes.add(img); 
    }
  }
  
  public void display(){
     
  }
  
  
  
}

 
