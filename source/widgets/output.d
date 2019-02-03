module widgets.output;

import widgets.shape;
import widgets.util;

import gtk.Widget;
import cairo.Context;
import pango.PgCairo;
import pango.PgLayout;
import pango.PgFontDescription;

/// Widget to draw an input shape
class Output: Shape {

public:
	/// Read widgets/shape.d
	this(int lineThickness, double r, double g, double b, double a) {
		super(lineThickness, r, g, b, a);
		addOnDraw(&onDraw);
	}

private:
	bool onDraw(Scoped!Context cr, Widget _) {
		cr.setSourceRgba(r,g,b,a);

		// how much space will incline the "rectangle"
		// to make it a romboid
		double inclination;

		// The Y component of the point where the
		// arrow will start
		double arrowY;
		if(width < 100) {
			inclination = width*0.2;
			arrowY = height * 0.9;
		}else{	
			inclination = 30;
			arrowY = height-10;
		}	
		
		cr.moveTo(0,0);
		
		// Draw romboid
		cr.moveTo(inclination+border, border);
		cr.lineTo(width-border, border);
		cr.lineTo(width-inclination-border, height-border);
		cr.lineTo(border, height-border);
		cr.closePath();
		cr.stroke();

		immutable double arrowX = getXFromY(
			Point(width-border, border),
			Point(width-border-inclination, height-border),
			arrowY,
		);

		// Top left point of the arrow position
		immutable Point arrowTopLeft = Point(arrowX, arrowY);
		
		immutable Point arrowSize = Point(
			width-arrowTopLeft.x-border, 
			height-arrowY-border,
		);

		
		drawHorizontalArrow(
			arrowTopLeft,
			Point(arrowSize.x*0.7, arrowSize.y*0.6),
			Point(arrowSize.x*0.3, arrowSize.y*0.4),
			cr,
		);

		return true;
	}
}
