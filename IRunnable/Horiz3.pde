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
