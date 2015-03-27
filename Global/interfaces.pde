interface IRunnableEffect { 
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

