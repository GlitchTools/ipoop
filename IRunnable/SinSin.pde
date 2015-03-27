class SinSin implements IRunnableEffect { 
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
