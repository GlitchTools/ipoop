class Recipe { 
	Recipe(){};
	Recipe(IRunnableEffect eff, float x, float y) { 
		this.RunnableEffect = eff;
		this.XPercent = x;
		this.YPercent = y;
	}
	String name = "";
	IRunnableEffect RunnableEffect = null;
	IRunnableMergeEffect RunnableMergeEffect = null;
	float XPercent;
	float YPercent;
	PImage run(PImage img1) { 
		return RunnableEffect.run(img1,XPercent,YPercent);
	}
	PImage run(PImage img1,PImage img2) { 
          return null;
	}
}interface IRunnableEffect { 
  PImage run(PImage img, float xPercent, float yPercent); 
}


interface IRunnableMergeEffect { 
  PImage run(PImage img1, PImage img2, float xPercent, float yPercent);
}


interface IMenuRunnable {
  String title();// = "iMenuRunnable";
  String group();
  Boolean saveHistory();// = false;
  Boolean savePreFxImage();// = false;
  void run(int rowidx, int btnidx, int xPerc, int yPerc);
}

ArrayList<Recipe> _recipes = new ArrayList<Recipe>();
PImage img1,img2;
int drawCounter = 0;
void setup() { 
	img1 = loadImage("img.jpg");
	//PImage bfr = createImage(800,600,RGB);
	//bfr.copy(img1,0,0,img1.width,img1.height,0,0,bfr.width,bfr.height);
	//img1 = bfr;
        size(img1.width,img1.height);
	background(color(0));
	frameRate(1);
	
}
void draw() { 
  if ( img1 == null ) return;

  // in it's most simple form:
  Recipe test = new Recipe();
  test.RunnableEffect = new Slicer();
  test.XPercent = 33.3;
  test.YPercent = 1.618;
  img1 = test.run(img1);
  image(img1,0,0);

  // or, for some automation: (uncomment the next block to enable :) 
_recipes.add(new Recipe(new Slicer(),random(10),random(100)));
_recipes.add(new Recipe(new Slicer(),random(20),random(100)));
_recipes.add(new Recipe(new SinWav(),random(100),random(100)));
_recipes.add(new Recipe(new Slicer(),random(40),random(100)));
_recipes.add(new Recipe(new SinSin(),random(50),random(100)));
_recipes.add(new Recipe(new Slicer(),random(60),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(70),random(100)));
_recipes.add(new Recipe(new Slicer(),random(80),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(90),random(100)));
_recipes.add(new Recipe(new Edged(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin3(),random(100),random(100)));
_recipes.add(new Recipe(new SinWav(),random(100),random(100)));
_recipes.add(new Recipe(new Horiz3(),random(100),random(100)));
/*
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
_recipes.add(new Recipe(new SinSin2(),random(100),random(100)));
*/

	if (img1 != null ) { 
                for (int i = drawCounter, l = _recipes.size(); i<l; i++) { 
		    if ( !( i % 10 == 0 ) ) continue;
                    Recipe recipe = _recipes.get(i);
  			if ( recipe.RunnableMergeEffect != null ) { 
				//kewl
			} else if ( recipe.RunnableEffect != null && random(100) > 50 ) { 
				img1 = recipe.run(img1);
				image(img1,0,0);
                                save("C:\\seq"+drawCounter+".png");
			}

		}
	}	
  

	drawCounter++;
int maxIterations = 30;
	if ( drawCounter >= _recipes.size() || drawCounter > maxIterations ) {  //impossible in current flow
		noLoop();
	}
	println(drawCounter);




}
	class Util { 
	ArrayList<PVector> bresenham(PVector p1, PVector p2) {
	   ArrayList<PVector> result = new ArrayList<PVector>();
	   int x1 = (int)p1.x;
	   int x2 = (int)p2.x;
	   int y1 = (int)p1.y;
	   int y2 = (int)p2.y;
	   int dx = abs(x2-x1);
	   int dy = abs(y2-y1);
	   int sx = (x1 < x2 ) ? 1 : -1;
	   int sy = (y1 < y2 ) ? 1 : -1;
	   int err = dx-dy;
	   while (!((x1==x2) && (y1==y2))) {
	     result.add(new PVector(x1,y1)); 
	     int err2 = 2*err;
	     if (err2 >-dy) { 
	        err -= dy;
	        x1 += sx;
	     }
	     if (err2 < dx) { 
	        err += dx;
	        y1 += sy;
	     }   
	   }
	   return result;
	  
	}
}

void Log(String msg) { 
}
class BlendImage implements IRunnableMergeEffect {
PImage run(PImage img, PImage simg, float xp, float yp ) {
PImage mimg = simg; //fixme: this is bumpmapish
  img.loadPixels();
  simg.loadPixels();
  mimg.loadPixels();
  for ( int y = 0, h = img.height; y<h; y++) { 
    for ( int x = 0, w = img.width; x<w; x++) { 
      int sw = simg.width, mw = mimg.width, sh = simg.height, mh = mimg.height;
      int sx = (int)map(x,0,w,0,sw);
      int mx = (int)map(x,0,w,0,mw);
      int sy = (int)map(y,0,h,0,sh);
      int my = (int)map(y,0,h,0,mh);
      int pos = x + y * w;
      int spos = sx + sy * sw;
      int mpos = mx + my * mw;
      color c = img.pixels[pos];
      color sc = simg.pixels[spos];
      color mc = mimg.pixels[mpos];
      int opaq = (int)brightness(mc);
      c = color(red(c),green(c),blue(c),(opaq));
      sc = color(red(sc),green(sc),blue(sc),255-opaq);
      img.pixels[pos] = blendColor(c,sc,BLEND);
    }
  }
  img.updatePixels();
  return img; 
}
}class Edged implements IRunnableEffect {
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
class Horiz3 implements IRunnableEffect { 
PImage run(PImage img, float xp, float yp) { 
 img.loadPixels();
 int diff = (int)map(xp,0,100,1,60);
 color pc = color(0), pr = color(0), pg = color(0), pb = color(0);
 for ( int i = img.pixels.length-1, l = img.pixels.length; i>=0; i--) { 
   int pos = i;
   color c = img.pixels[pos];
    if ( abs(brightness(c)-brightness(pc)) > diff )
      pc = c;
    if ( abs(red(c)-red(pr)) > diff )
      pr = c;
    if ( abs(green(c)-green(pg)) > diff )
      pg = c;
    if ( abs(blue(c)-blue(pr)) > diff )
      pb = c;
    img.pixels[pos] = color(red(pr),green(pg),blue(pb));
 }
 img.updatePixels();
 return img; 
}

}
class MergeHiCol implements IRunnableMergeEffect { 
  PImage run(PImage img, PImage mapImg, float xp,float yp) { 
    PImage result = createImage(img.width,img.height,RGB);
    img.loadPixels();
    result.loadPixels();
    int maxc = max(img.pixels);
    int minc = min(img.pixels);
    mapImg.loadPixels();
    if ( yp <= 33 ) 
      mapImg.pixels = reverse(mapImg.pixels);
    else if (yp > 66 )
      mapImg.pixels = sort(mapImg.pixels);  
    mapImg.updatePixels();
    int thresh = (int)map(xp,0,100,minc,maxc);
    int ml = mapImg.pixels.length;
    for ( int i = 0, l = img.pixels.length; i<l; i++) {
      int mpos = (int)map(i,0,l,0,ml);
      color c = img.pixels[i];
      //println("c "+c+"< thresh "+thresh+" = "+( c < thresh )+""); 
      if ( c < thresh ) { 
         result.pixels[i] = img.pixels[i]; 
      } else { 
        result.pixels[i] = mapImg.pixels[mpos];
      }
    }
    result.updatePixels();
    return result;
  }
}class SinSin implements IRunnableEffect { 
PImage run(PImage img, float xp, float yp) { 
   img.loadPixels();
   float theta = 0;
   PImage result = createImage(img.width, img.height, RGB);
   result.loadPixels();
   for ( int y = 0; y < img.height; y++ ) { 
     for ( int x = 0; x < img.width; x++ ) { 
       float direction = sin(theta);//(int)map(sin(theta),-1,1,0,1);
       int posy = (int)(y*direction);
       int dy = y;
       if ( posy >= 0 && posy < img.height ) dy = posy;
       int pos = x + y * img.width;
       int sp = pos;
       int pospos = x + dy * img.width;
       if ( pospos >= 0 && pospos < img.pixels.length ) sp = pospos;
       result.pixels[sp] = img.pixels[pos];
       
       theta += TWO_PI/60;
     }
   }
   result.updatePixels();
   return result;
}
}
class SinSin2 implements IRunnableEffect { 
PImage run(PImage img, float xp, float yp) { 
   img.loadPixels();
   float theta = 0;
   color c = color(0), pc = color(0);
   int diff = 10;
   PImage result = createImage(img.width, img.height, RGB);
   result.loadPixels();
   for ( int y = 0; y < img.height; y++ ) { 
     for ( int x = 0; x < img.width; x++ ) { 
       int pos = x + y * img.width;
       if ( abs(brightness(img.pixels[pos])-brightness(pc)) > diff ) { 
         pc = c = img.pixels[pos];
       }  
       float direction = sin(theta);//(int)map(sin(theta),-1,1,0,1);
       int posy = (int)(y*direction);
       int dy = y;
       if ( posy >= 0 && posy < img.height ) dy = posy;
       int sp = pos;
       int pospos = x + dy * img.width;
       if ( pospos >= 0 && pospos < img.pixels.length ) sp = pospos;
       result.pixels[sp] = c;
       
       theta += TWO_PI/60;
     }
   }
   result.updatePixels();
   return result;
}
}class SinSin3 implements IRunnableEffect { 
PImage run(PImage img, float xp, float yp) { 
   img.loadPixels();
   float theta = 0;
   color c = color(0), pc = color(0);
   int diff = 30;
   PImage result = createImage(img.width, img.height, RGB);
   result.loadPixels();
   for ( int y = 0; y < img.height; y++ ) { 
     for ( int x = 0; x < img.width; x++ ) { 
       int pos = x + y * img.width;
       c = img.pixels[pos];
       float direction = sin(theta);//(int)map(sin(theta),-1,1,0,1);
       int posy = (int)(10*y*direction);
       int dy = y;
       if ( posy >= 0 && posy < img.height ) dy = posy;
       int sp = pos;
       int pospos = x + dy * img.width;
       if ( pospos >= 0 && pospos < img.pixels.length ) sp = pospos;

       if ( abs(brightness(c)-brightness(pc)) > diff ) { 
         pc = c;
       }  
       result.pixels[sp] = c;
       
       theta += TWO_PI/60;
     }
   }
   result.updatePixels();
   return result;
}

}
class SinWav implements IRunnableEffect {  
PImage run(PImage img, float xp, float yp) { 
  int ctr = 0;  
  img.loadPixels();
  float ylength = map(xp,0,100,1,100);
  float xlength = map(yp,0,100,1,100);
  PImage result = createImage(img.width,img.height,RGB);
  for ( int y =0, h = img.height; y<h; y++) { 
    for ( int x = 0, w = img.width; x<w;x++, ctr++) {
      int pos = x + y * w;
      color c = img.pixels[pos];
      int epos = (int)(( x + sin(y/ylength)*xlength)+ y * w);
      if ( epos < result.pixels.length )
        result.pixels[epos] = c;
      else
        result.pixels[pos] = c;
    }
  }
  result.updatePixels();
  return result;   
}
}
class Slicer implements IRunnableEffect { 
  PImage run(PImage img,float xp, float yp) 
  {
    img.loadPixels();
    int y = (int)map(yp,0,100,0,img.height);//(img.height*yp/100);
    int x = (int)map(xp,100,0,0,img.width);//(img.width*xp/100);
    PImage result = createImage(img.width,img.height,RGB);
    result.copy(img,0,0,img.width,y,0,0,result.width,y);
    result.copy(img,x,y,img.width-x,img.height-y,0,y,result.width-x,result.height-y);
    result.copy(img,0,y,x,img.height-y,img.width-x,y,x,result.height-y);
    return result;//
  }
}

class TriangleHelper { 
	Boolean isInTriangle(PVector pt, PVector tp1, PVector tp2, PVector tp3) {
	  // from stack: http://stackoverflow.com/questions/14669614/finding-whether-a-point-is-within-a-triangle
	  float x = pt.x, y = pt.y;
	  float x1 = tp1.x, y1 = tp1.y;
	  float x2 = tp2.x, y2 = tp2.y;
	  float x3 = tp3.x, y3 = tp3.y;
	
	  // no need to divide by 2.0 here, since it is not necessary in the equation
	  double ABC = Math.abs (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2));
	  double ABP = Math.abs (x1 * (y2 - y) + x2 * (y - y1) + x * (y1 - y2));
	  double APC = Math.abs (x1 * (y - y3) + x * (y3 - y1) + x3 * (y1 - y));
	  double PBC = Math.abs (x * (y2 - y3) + x2 * (y3 - y) + x3 * (y - y2));
	
	  boolean isInTriangle = ABP + APC + PBC == ABC;
	
	  return isInTriangle;
	}
}
	
