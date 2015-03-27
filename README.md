# ipoop
processing.org stuff
-- 
HOWTO
place IRunnable in the folder next to your sketch, and add something like this:
    
    PImage img;
    void setup() { 
    		  img = loadImage("img.jpg");
    		  IRunnableEffect fx = new Slicer();
    		  img = fx.run(img,random(30),random(80));
    		  size(img.width,img.height);
    		  noLoop();
    }
    void draw() { 
    		  if ( img != null ) image(img,0,0);
    }
    
    
    interface IRunnableEffect { 	PImage run(PImage img,float x, float y); }
