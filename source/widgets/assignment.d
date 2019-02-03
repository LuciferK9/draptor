module widgets.assignment;

import std.math;
import std.stdio;
import std.typecons;

import gtk.DrawingArea;
import gtk.Widget;

import cairo.FontOption;
import cairo.Context;
import cairo.Surface;
import cairo.ImageSurface;

import pango.PgCairo;
import pango.PgLayout;
import pango.PgFontDescription;
import widgets.shape;

/// Widget to draw an assignment shape
public class Assignment : Shape {

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

		// corners position
		auto tl = tuple(border, border);
		auto tr = tuple(width-border, border);
		auto br = tuple(width-border, height-border);
		auto bl = tuple(border, height-border);
		cr.moveTo(tl[0], tl[1]);
		cr.lineTo(tr[0], tr[1]);
		cr.lineTo(br[0], br[1]);
		cr.lineTo(bl[0], bl[1]);
		cr.lineTo(tl[0], tl[1]);
		cr.stroke();

		return true;
	}

}
