/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 5/1/11
 * Time: 7:56 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.trackers
{
    import com.google.analytics.GATracker;
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.v4.Configuration;
    import com.jessefreeman.factivity.analytics.ITrack;

    import flash.display.DisplayObject;

    public class GoogleTracker extends GATracker implements ITrack
    {

        public function GoogleTracker(a:DisplayObject, a2:String, a3:String = "AS3", a4:Boolean = false, a5:Configuration = null, a6:DebugConfiguration = null)
        {
            super(a, a2, a3, a4, a5, a6);
        }

        override public function trackPageview(a:String = ""):void
        {
            super.trackPageview(a);
        }

        public function track(type:String, ... arguments)
        {
        }
    }
}