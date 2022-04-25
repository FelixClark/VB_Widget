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
           	var info = Activity.getActivityInfo();
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


 

        var spacing = 4;
        var appIcon = WatchUi.loadResource(Rez.Drawables.VB_Stubbie);
        var bitmapWidth = appIcon.getWidth();
        var bitmapHeight = appIcon.getHeight();
        
        //var bitmapX = (dc.getWidth() - (bitmapWidth + spacing)) / 2;
        //var bitmapY = (dc.getHeight() - appIcon.getHeight()) / (3);
        //var bitmapY = (dc.getHeight() * 2)/3;
        //dc.drawBitmap(bitmapX, bitmapY, appIcon);
        //vbEarnt=10;
        var temp = 0;
        for (var i = 0; i < vbEarnt.toLong(); i++) 
        {
           //var x = random(bitmapWidth,dc.getWidth()-bitmapWidth);
           //var y = random(bitmapHeight,dc.getHeight()-bitmapHeight);
           var x = 40 + i*(bitmapWidth+spacing);
           var y = 0;
           if(x < dc.getWidth()-bitmapWidth-30)
           {
               y = (dc.getHeight()*1)/3 - 40;
               temp = i;
           }
           else
           {
               x = 40 + (i-temp-1)*(bitmapWidth+spacing);            
               y = (dc.getHeight()*2)/3 - 20;
           }

           dc.drawBitmap(x, y, appIcon);
        }       
        
            mMessage = "YOU'VE EARNT "+ vbEarnt.format("%.1f") + " VB's";
	        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_TINY, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);   

        //View.onUpdate(dc);
    }

    const RAND_MAX = 0x7FFFFFF;

    // return a random value on the range [n, m]
    function random(n, m) 
    {
    //return m + Math.rand() / (RAND_MAX / (n - m + 1) + 1);
        return (Math.rand() % m + n);
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
