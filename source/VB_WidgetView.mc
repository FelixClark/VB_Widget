import Toybox.Graphics;
import Toybox.WatchUi;

class VB_WidgetView extends WatchUi.View {
	var logo;
	hidden var mMessage = "";

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.MainLayout(dc));
                mMessage = "";
        logo = WatchUi.loadResource(Rez.Drawables.LauncherIcon);  
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_GREEN);
        dc.clear();
            //var info = ActivityMonitor.getInfo();
            var info = ActivityMonitor.getInfo();
           	var calories = null;
            var vbEarnt = -1;
        
            if(info != null)
            {
                calories = info.calories;
                if(calories != null)
                {
                    vbEarnt = calories/142.0; //142 Calories in a VB
                }
            }


            mMessage = "YOU'VE EARNT "+ vbEarnt.format("%.1f") + " VB's";
	        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_TINY, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);    

        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function dummy()
    {
    
    }

}
