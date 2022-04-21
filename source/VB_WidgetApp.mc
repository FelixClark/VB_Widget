import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class VB_WidgetApp extends Application.AppBase {

    hidden var mView;
    function initialize() 
    {
         AppBase.initialize();    
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() 
    {
        mView = new VB_WidgetView();
        return [mView, new VB_OverviewDelegate(mView.method(:dummy))];
    }
    
    (:glance) 
    function getGlanceView() 
    {
        return [ new VB_GlanceView() ];
    }

}

function getApp() as VB_WidgetApp {
    return Application.getApp() as VB_WidgetApp;
}

