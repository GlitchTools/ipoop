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
