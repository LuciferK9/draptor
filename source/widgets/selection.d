module widgets.selection;

import widgets.shape;

import cairo.Context;
import gtk.Widget;

/// Widget to draw a selection shape
public class Selection : Shape {

public:
	/// Read widgets/shape.d
	this(int lineThickness, double r, double g, double b, double a) {
		super(lineThickness, r, g, b, a);
		addOnDraw(&onDraw);
	}

private:
	bool onDraw(Scoped!Context cr, Widget _) {
		cr.setSourceRgba(r,g,b,a);
		cr.setLineWidth(lineThickness);

		// Guys, check an image of the selection shape
		// it has like a head of an arrow on the left and right
		// idk how its called but its basically the length of that
		double peakLen;
		if(width < 120) {
			peakLen = width * 0.15;
		}else{
			peakLen = 30;
		}
		
		cr.moveTo(border, height/2.0);
		cr.lineTo(peakLen, border);
		cr.lineTo(width-peakLen, border);
		cr.lineTo(width-border, height/2.0);
		cr.lineTo(width-peakLen, height-border);
		cr.lineTo(peakLen, height-border);
		cr.lineTo(border, height/2.0);
		cr.closePath();
		cr.stroke();
		
		return true;
	}
}
