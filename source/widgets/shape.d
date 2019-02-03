module widgets.shape;

import gtk.DrawingArea;
import cairo.Context;
import gtk.Widget;

public class Shape : DrawingArea {

public:
	/**
		Params:
			lineThickness = Thickness of the line duh
			r = Red value of color
			g = Green value of color
			b = Blue value of color
			a = Alpha value of color
	*/
	this(int lineThickness, double r, double g, double b, double a) {
		this.lineThickness = lineThickness;
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
		addOnSizeAllocate(&onSizeAllocate);
	}

	/// Get text that will be rendered inside the shape.
	@property string text() {return m_text;}
	/// Set text that will be rendered inside the shape.
	@property string text(string value) {return m_text = value;}

private:
	string m_text;
	void onSizeAllocate(GtkAllocation* allocation, Widget _) {
		width = allocation.width;
		height = allocation.height;
	}

protected: 
	int lineThickness;
	double r,g,b,a;
	int width, height;
	@property double border() {return lineThickness / 2.0;}
}
