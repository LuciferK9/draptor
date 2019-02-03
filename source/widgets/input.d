module widgets.input;

import widgets.shape;
import widgets.util;

import gtk.Widget;
import cairo.Context;

/// Widget to draw an input shape
class Input : Shape {

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
		// arrow will be pointing at
		double arrowY;
		if(width < 100) {
			inclination = width*0.2;
			arrowY = height * 0.1;
		}else{	
			inclination = 30;
			arrowY = 10;
		}	
		
		// Draw romboid
		cr.moveTo(inclination+border, border);
		cr.lineTo(width-border, border);
		cr.lineTo(width-inclination-border, height-border);
		cr.lineTo(border, height-border);
		cr.closePath();
		cr.stroke();

		// Top left point where the arrow position
		immutable Point arrowTopLeft = Point(border, border);

		// Get the X component where the arrow wil be
		// pointing at
		immutable double arrowX = getXFromY(
			Point(inclination+border, border),
			Point(border, height-border),
			arrowTopLeft.y + arrowY,
		);
		
		// The Y Size is arrowY because the arrow always
		// starts at 0,0 (actually border,border) but the
		// border uses the 0,0 pixel
		immutable Point arrowSize = Point(arrowX, arrowY);

		
		drawHorizontalArrow(
			arrowTopLeft,
			Point(arrowSize.x*0.7, arrowSize.y*0.6),
			Point(arrowSize.x*0.3, arrowSize.y*0.4),
			cr,
		);

		return true;
	}
}
