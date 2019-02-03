import gio.Application: GioApplication = Application;

import gtk.Application: GtkApplication = Application;
import gtk.ApplicationWindow;
import gtk.Builder;
import gtk.FlowBox;
import gtk.FlowBoxChild;
import gtk.Layout;

import widgets.output;

import std.stdio;
import std.format;
import core.stdc.stdlib;

/// Main app
class App {

public:
	/// Exception thrown when a object was not found in a glade file.
	class ObjectNotFoundException : Exception {
		/**
			Default constructor.

			Params:
				object = object that was not found in the glade file.
				gladeFile = glade file where the object was searched.
		*/
		this(string object, string gladeFile, string file = __FILE__, size_t line = __LINE__) {
			super(format!"%s could not be found in \"%s\" glade file"(object, gladeFile), file, line);
		}
	}

	/**
		Returns main app with a main window from a glade file.

		Params:
			gladePath = Path of the main glade file.
	*/
	this(string gladePath) {
		gtkApp = new GtkApplication("me.luciferk9.draptor", GApplicationFlags.FLAGS_NONE);

		void buildAndDisplay(GioApplication _) {
			builder = new Builder();
			if(!builder.addFromFile(gladePath)) {
				writeln(format!"Could not open glade file: %s"(gladePath));
				exit(1);
			}
			ApplicationWindow window = cast(ApplicationWindow)builder.getObject("window");
			if(window !is null) {
				window.setApplication(gtkApp);
				window.setTitle("DRaptor");
				setupSignals();

				Layout layout = cast(Layout)builder.getObject("layout");
				// TODO:Show widgets in layout

				layout.showAll();

				window.showAll();
			}else {
				throw new ObjectNotFoundException("window", gladePath);
			}
		}
		gtkApp.addOnActivate(&buildAndDisplay);
	}
	/// Runs main application
	auto run(string[] args) {
		return gtkApp.run(args);
	}

private:
	enum FlowchartShape {assignment, call, input, output, selection, loop}

	Builder builder;
	GtkApplication gtkApp;

	FlowchartShape selectedShape;

	void onFlowBoxChildActivated(FlowBoxChild child, FlowBox _) {
		switch(child.getIndex()) {
		case 0:
			selectedShape = FlowchartShape.assignment;
			break;
		case 1:
			selectedShape = FlowchartShape.call;
			break;
		case 2:
			selectedShape = FlowchartShape.input;
			break;
		case 3:
			selectedShape = FlowchartShape.output;
			break;
		case 4:
			selectedShape = FlowchartShape.selection;
			break;
		case 5:
			selectedShape = FlowchartShape.loop;
			break;
		default:
		}
	}

	void setupSignals() {
		FlowBox flowbox = cast(FlowBox) builder.getObject("flowchartShapes");
		flowbox.addOnChildActivated(&onFlowBoxChildActivated);
	}
}

int main(string[] args) {
	App app = new App("./gui/main.glade");
	return app.run(args);
}
