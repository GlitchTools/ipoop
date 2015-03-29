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
