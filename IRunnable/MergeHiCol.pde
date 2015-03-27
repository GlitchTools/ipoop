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
}