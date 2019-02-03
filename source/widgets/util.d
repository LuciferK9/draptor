module widgets.util;

import cairo.Context;

struct Point {
	double x,y;
	this(double x, double y){
		this.x = x;
		this.y = y;
	}
}

public:
void drawHorizontalArrow(
	Point start,
	Point bodySize, Point relativeHeadSize,
	Context cr
){
	alias headSize=relativeHeadSize;
	immutable double centerY = start.y+(bodySize.y+headSize.y)/2.0;
	cr.moveTo(start.x, start.y+headSize.y/2.0);
	cr.lineTo(start.x+bodySize.x, start.y+headSize.y/2.0);
	cr.lineTo(
		start.x+bodySize.x, 
		start.y,
	);
	cr.lineTo(
		start.x+bodySize.x+headSize.x,
		centerY
	);
	cr.lineTo(start.x+bodySize.x, start.y+bodySize.y+headSize.y);
	cr.lineTo(start.x+bodySize.x, start.y+bodySize.y+headSize.y/2.0);
	cr.lineTo(start.x, start.y+bodySize.y+headSize.y/2.0);
	cr.closePath();
	cr.stroke();
}	
double getXFromY(Point p1, Point p2, double y) {
	double m = (p2.y-p1.y)/(p2.x-p1.x);
	return ((y-p1.y)/m)+p1.x;
}

