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
}