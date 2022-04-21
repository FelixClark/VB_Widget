using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System as Sys;
using StockData as Data;

(:glance)
class VB_GlanceView extends WatchUi.GlanceView 
{
    function initialize() 
    {
      	GlanceView.initialize();
    }
    
	// Restore the state of the app and prepare the view to be shown
    function onShow() 
    {
		/*
    	if(Data.isDataStale())
    	{
    		Data.requestDataFromServer(method(:newDataAvailable));
    	}
    	else
    	{
    		Data.restoreCachedData();
    	}*/
    }
    
    function newDataAvailable(responseCode, data)
    {		/*
    	if (responseCode == 200) 
        {
        	System.println("Data received!");
			if (data instanceof Array)
	        {
	        	Data.setDataFromWebRequest(data);
	        }
	        else
	        {
	        	System.println("Unknown reponse data:" + data);
	        }  
        }
        else 
        {
            	System.println("Data Error! Code:" + responseCode);
        }
    	WatchUi.requestUpdate();
		*/
    }
    
    
    function onUpdate(dc) 
    {
    	 var message = "HARD EARNED!";
     	 var title = "VB Thirst Status";
    	 dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	 dc.drawText(5, dc.getHeight()/2 - 15, Graphics.FONT_TINY, title, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
		 dc.drawText(5, dc.getHeight()/2 + 10, Graphics.FONT_XTINY, message, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

		/*
    	 var x = Data.StockList.size();
	    	if(Data.StockList.size() >0)
	    	{
	    		var Stock = Data.StockList[Data.StockCodes[0]];
				var code = Stock.Code;
	         	var change = Stock.ChangePercent.toFloat();
	         	var price = Stock.Close;    	
	         	message = code + ": $" + price + " (" + change.format("%.2f") + "%)";
	         	if(change > 0)
	         	{
	         	    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
	         	}
	         	else if (change < 0)
	         	{
	         		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	         	}
	         	else
	         	{
	         	    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	         	}
		     }
		  */
    } 
}
