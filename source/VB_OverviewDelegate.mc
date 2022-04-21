using Toybox.Communications;
using Toybox.WatchUi;
//using StockData as Data;
using Toybox.Timer;

class VB_OverviewDelegate extends WatchUi.BehaviorDelegate
{
    var notify;
    
     // Set up the callback to the view
    function initialize(handler) 
    {
        WatchUi.BehaviorDelegate.initialize();
        notify = handler;
    }
    
	function onShow()
	{
	
	}

    // Handle menu button press
    function onMenu() 
    {
        //makeRequest();
        return true;
    }


    function onSelect() 
    {
     // Generate a new Menu with a drawable Title
        var menu = new WatchUi.Menu2({:title=>new DrawableMenuTitle()});
	    
	    menu.addItem(new WatchUi.MenuItem("Refresh", null, "refresh", null));
        /*
        if(Data.StockList instanceof Dictionary)
        {
	        for(var i=0; i< Data.StockList.size(); i++)
	        {
	        	var code = Data.StockCodes[i];
	            var change = Data.StockList[code].ChangePercent.toFloat();
	            var sign = "";
	            if(change > 0)
	            {
	            	sign = "+";
	            }
	            
	        	var subLabel = "$" + Data.StockList[code].Close + "  " + sign + Data.StockList[code].ChangePercent + "%";
	        	menu.addItem(new WatchUi.MenuItem(Data.StockList[code].Code, subLabel, Data.StockList[code].Code, null));
	        }
        }
        WatchUi.pushView(menu, new StockSpecificMenuDelegate(), WatchUi.SLIDE_UP );*/
        return true;
    }
   
   
    function onKey(keyEvent)
    {
		/*
        System.println("HERE Down");
    	var key = keyEvent.getKey();
    	if (key == KEY_DOWN) 
    	{
    	    System.println("Key Down");
    	    System.println("Overview Display ONKEY:" + overviewDisplayQty);
    	    //if(pageIdx < (Data.StockList.size()-1)/3)
    	    if(pageIdx < (Data.StockList.size()-1)/overviewDisplayQty)
    	    {
    	   	 	pageIdx += 1;
    	    }
    	    else
    	    {
    	       	pageIdx = 0; 
    	    }
    	    WatchUi.requestUpdate();
    	    return true;		
    	}
    	else if(key == KEY_UP)
    	{
    		System.println("Key Up");
    		if(pageIdx > 0)
    		{
    			pageIdx -= 1;
    		}
    		else
    		{
	   			//pageIdx = (Data.StockList.size()-1)/3;
    			pageIdx = (Data.StockList.size()-1)/overviewDisplayQty;
    		}
    		WatchUi.requestUpdate();
    		return true;		
    	}
    	else
    	{
    		System.println("Unknown Key");
    	}
    	return false;
			*/
    }

}

// This is the custom drawable we will use for our main menu title
class DrawableMenuTitle extends WatchUi.Drawable 
{
    var mIsTitleSelected = false;

    function initialize() {
        Drawable.initialize({});
    }

    function setSelected(isTitleSelected) {
        mIsTitleSelected = isTitleSelected;
    }

    // Draw the application icon and main menu title
    function draw(dc) {
		
        var spacing = 2;
        var appIcon = WatchUi.loadResource(Rez.Drawables.LauncherIcon);
        var bitmapWidth = appIcon.getWidth();
        var labelWidth = dc.getTextWidthInPixels("Menu", Graphics.FONT_MEDIUM);

        var bitmapX = (dc.getWidth() - (bitmapWidth + spacing + labelWidth)) / 2;
        var bitmapY = (dc.getHeight() - appIcon.getHeight()) / 2;
        var labelX = bitmapX + bitmapWidth + spacing;
        var labelY = dc.getHeight() / 2;

        var bkColor = mIsTitleSelected ? Graphics.COLOR_BLUE : Graphics.COLOR_BLACK;
        dc.setColor(bkColor, bkColor);
        dc.clear();

        dc.drawBitmap(bitmapX, bitmapY, appIcon);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(labelX, labelY, Graphics.FONT_MEDIUM, "Menu", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
		
    }
}