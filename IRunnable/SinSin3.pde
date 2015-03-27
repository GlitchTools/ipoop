class SinSin3 implements IRunnableEffect { 
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
