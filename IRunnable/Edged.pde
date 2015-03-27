class Edged implements IRunnableEffect {
  PImage run(PImage img1, float xPerc, float yPerc) {
    ArrayList<PVector> points = edgeDetect(img1,(int)map(xPerc,0,100,1,80));
    Log("I have "+points.size()+" points");
    if ( yPerc > 50 ) {
      PImage tmpImg = createImage(img1.width,img1.height,RGB);
      img1= drawPoints(tmpImg,points,color(255)); 
    }else{
      img1= drawPoints(img1,points,color(255));
    }
    return img1;
  }

  ArrayList<PVector> edgeDetect(PImage img, int sensitivity) { 
  img.loadPixels();
  ArrayList<PVector> result = new ArrayList<PVector>();
  for ( int y = 1, h=img.height; y<h-1; y++) { //skip 1 for the edges (can't compare to values beyond the edge ;))
   for ( int x = 1, w=img.width; x<w-1; x++) { 
     color p = img.pixels[ x + y*w ];
     color tl = img.pixels[ (x-1) + (y-1)*w ];
     color t = img.pixels[ x + (y-1)*w ];
     color tr = img.pixels[ (x+1) + (y-1)*w ];
     color l = img.pixels[ (x-1) + y*w ];
     color r = img.pixels[ (x+1) + y*w ];
     color bl = img.pixels[ (x-1) + (y+1)*w ];
     color b = img.pixels[ x + (y+1)*w ];
     color br = img.pixels[ (x+1) + (y+1)*w ];
     color[] tests = { tl, t, tr, l, r, bl, b, br };
     for (int i = 0; i<tests.length; i++) { 
       if ( abs(brightness(p)-brightness(tests[i])) > sensitivity ) { 
         //print("F: "+i+"!! x:"+x+", y:"+y+", diff:"+abs(brightness(p)-brightness(tests[i]))+", ");
        result.add(new PVector(x,y,0));
        i=tests.length; // already a point, skipping to next
       }      
       //println( ""+i+": "+x+"x"+y+": "+abs( p - tests[i] ) );
     }

   }
  } 
     //println("got "+result.size()+" points");
     return result; 
 
  }


  PImage drawPoints(PImage img, ArrayList<PVector> pts, color c) { 
  img.loadPixels();
  for ( int i = 0; i<pts.size(); i++) { 
    int pos = (int)(pts.get(i).x+pts.get(i).y*(img.width)); 
    if ( pos < img.pixels.length ) {
     img.pixels[pos] = c;
    }
  } 
  img.updatePixels();
  return img;
  
  }



}
