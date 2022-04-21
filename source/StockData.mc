using Toybox.System;
using Toybox.Application;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Lang;

(:glance)
module StockData
{
	var StockList = {};
	var StockCodes = new[100];
	var lastUpdateTime;
	var refreshRate = 1200; //20minutes
	var forceRefreshFlag = false;
	var requestPending = false;
	
	function parseJSONData(data)
    {
        for(var i=0; i<data.size();i++)
        {
            var entry = data[i];
            if (entry instanceof Lang.Dictionary) 
                {
	          		var codeFull = entry["code"];
	          		var code = codeFull.substring(0,codeFull.length()-3);
		            var close = entry["close"].toFloat().format("%.3f");
		            var changePercent = entry["change_p"].toFloat().format("%.2f");
		            var change = entry["change"].toFloat().format("%.3f");
		            var high = entry["high"].toFloat().format("%.3f");
		            var low = entry["low"].toFloat().format("%.3f");
		            var volume = entry["volume"];
		              
		            var record = new StockRecord(code,close,changePercent,change,high,low,volume);
		            StockList[code] = record;    
		            StockCodes[i] = code; 
            	}
        	}
        	forceRefreshFlag = false;
    }
    
    //https://forums.garmin.com/developer/connect-iq/f/discussion/2327/string-to-array
    function splitCSVStringToArray(text, delimiter)
	{
		var dict = {};
		var len = text.length();
		var delLen = delimiter.length();
		var idx = 0;
		
		while (len > 0)
		{
			var iend = text.find(delimiter);
			iend = iend != null? iend : len;
		    var str = text.substring(0, iend);
			dict.put(idx, str);
			idx++;
			
			text = text.substring(iend + delLen, len);
			len -= iend + delLen;
		}
		return dict.values();
	}	
	
	function getRequestURL()
	{
	    var key = "5cecd089210818.21345123";
        //Application.getApp().setProperty("codes_prop","GRMN.US,MSFT.US,BHP.AU");
        var propString = Application.getApp().getProperty("codes_prop");
        var codeArray = splitCSVStringToArray(propString,",");	   
        var stockCode = codeArray[0]; //Initial code for the request
        var extra = "&s=";
        for(var i=1; i<codeArray.size();i++)
        {
        	extra+= codeArray[i];
        	if(i != codeArray.size() -1) //If not the last one, add a comma
        	{
        		extra += ",";
        	}
        }

        return "https://eodhistoricaldata.com/api/real-time/" + stockCode + "?api_token=" + key + "&fmt=json" + extra;
	}

    function requestDataFromServer(callback) 
    {
    	requestPending = true;
       	StockList = {};
        var params = 
        {
        };

        var options = 
        {
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :headers => { "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED}
        };
        
		var URL = getRequestURL();
		
        System.println("Request URL:" + URL);
        //var callable = new Lang.Method($, :onReceive); //https://forums.garmin.com/developer/connect-iq/f/discussion/167914/could-not-find-symbol-method
		Communications.makeWebRequest(URL, params, options, callback);
    }
    
    function isDataStale()
    {
    	var lastRefresh = Application.Storage.getValue("lastRefresh");
         
         if(lastRefresh == null || forceRefreshFlag == true)
         {
         	return true;
         }
         else
         { 
             	var timeNow = Time.now().value();
             	var duration =  timeNow - lastRefresh.toNumber();

        		if(duration > refreshRate)
        		{
        		    System.println("Duration: " + duration + "s greater than refreshRate: " + refreshRate + "s. Requesting new data...");
        		    return true;
        		}
        		else
        		{
        		    System.println("Duration: " + duration + "s less than refreshRate: " + refreshRate + "s. Using cached data");
        		}
        }
        return false;
    }
    
    function restoreCachedData()
    {		
   	    System.println("Restoring cached Data");
   	    var data = Application.Storage.getValue("JSON_Data");
   	    if(data != null)
   	    {
   	    	parseJSONData(data);    
   	    }
    }
    
    function setDataFromWebRequest(data)
    {		
   	    System.println("Setting data from web");
   	    var time = Time.now().value();
        Application.Storage.setValue("lastRefresh", time);
	    Application.Storage.setValue("JSON_Data",data);
   	    parseJSONData(data);    
    }
     
    
    function getNextStockCode(currentCode)
    {  	
    	for(var i=0; i<StockList.size(); i++)
    	{
    		if(StockList[StockCodes[i]].Code == currentCode) //Found the current index
    		{
    			if(i == StockList.size()-1) //If you're on the last one, return the first one
    			{
    				return StockList[StockCodes[0]].Code;
    			}
    			else
    			{
    				return StockList[StockCodes[i+1]].Code;
    			}
    		}
    	}
    	return currentCode;
    }
    
    function getPreviousStockCode(currentCode)
    {  	
    	for(var i=StockList.size()-1; i>=0; i--)
    	{
    		if(StockList[StockCodes[i]].Code == currentCode) //Found the current index
    		{
    			if(i == 0) //If you're on the first one, return the last one
    			{
    				return StockList[StockCodes[StockList.size()-1]].Code;
    			}
    			else
    			{
    				return StockList[StockCodes[i-1]].Code;
    			}
    		}
    	}
    	return currentCode;
    }
}