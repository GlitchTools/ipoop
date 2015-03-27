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
}