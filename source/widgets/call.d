module widgets.call;

import cairo.Context;

import gtk.Widget;

import widgets.shape;

import std.stdio;

/// Widget to draw a call shape
public class Call : Shape {

public:
	/// Read widgets/shape.d
	this(int lineThickness, double r, double g, double b, double a) {
		super(lineThickness, r, g, b, a);
		addOnDraw(&onDraw);
	}
	private:
		bool onDraw(Scoped!Context cr, Widget _) {
			cr.setLineWidth(lineThickness);
			cr.setSourceRgba(r,g,b,a);

			//////////////
			// RECTANGLE
			/////////////
			double rectWidth;
			if (width >= 100) {
				rectWidth = width - 30;
			}else {
				rectWidth = width * 0.8;
			}

			// corners position
			double[2] tl = [border, border];
			double[2] tr = [rectWidth-border, border];
			double[2] br = [rectWidth-border, height-border];
			double[2] bl = [border, height-border];

			cr.moveTo(tl[0], tl[1]);
			cr.lineTo(tr[0], tr[1]);
			cr.lineTo(br[0], br[1]);
			cr.lineTo(bl[0], bl[1]);
			cr.lineTo(tl[0], tl[1]);
			cr.stroke();

			//////////
			// ARROW
			/////////
			double bodyThickness;
			double headThickness;
			if(height <= 100) {
				bodyThickness = height * 0.08;
				headThickness = bodyThickness * 0.8;
			}else {
				bodyThickness = 8;
				headThickness = 5;
			}

			// move to center then leave space for arrow
			const centerY = height*0.5;

			// it's like mirroring the arrow in the y axis
			double[2] startArrowY = [centerY-bodyThickness*0.5, centerY+bodyThickness*0.5];

			const startHeadX = rectWidth + ((width-rectWidth)*0.6);

			cr.moveTo(rectWidth, startArrowY[0]);
			cr.lineTo(startHeadX, startArrowY[0]);
			cr.lineTo(startHeadX, startArrowY[0]-headThickness);
			cr.lineTo(width-border, centerY);
			cr.lineTo(startHeadX, startArrowY[1]+headThickness);
			cr.lineTo(startHeadX, startArrowY[1]);
			cr.lineTo(rectWidth, startArrowY[1]);
			cr.stroke();
			return true;
		}
}
