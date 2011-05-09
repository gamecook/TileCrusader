/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/20/11
 * Time: 10:07 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.events.MouseEvent;
    import flash.net.SharedObject;

    public class OptionsActivity extends RandomMapBGActivity
    {
        public function OptionsActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            mapViewPortWidth = fullSizeWidth - 80;
            mapViewPortHeight = 120;
            mapViewPortX = 40;
            mapViewPortY = fullSizeHeight - 160;

            super.onCreate();


            var xml:XML = <comps>

                <VBox x="20" y="20">

                    <PushButton id="clearMapFilter" label="Clear Random Map Filter" width="200" event="click:onClearRandomMapFilter"/>
                    <PushButton id="clearSavedGame" label="Clear Saved Game" width="200" event="click:onClearSavedGame"/>
                    <PushButton id="back" label="Back" event="click:back"/>
                </VBox>

            </comps>

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);
        }

        public function onClearRandomMapFilter(event:MouseEvent):void
        {
            var mapOptionsSO:SharedObject = SharedObject.getLocal(ApplicationShareObjects.MAP_OPTIONS);
            mapOptionsSO.clear();
        }

        public function onClearSavedGame(event:MouseEvent):void
        {
            var so:SharedObject = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            so.clear();
        }

        override public function onBack():void
        {
            nextActivity(StartActivity);
        }
    }
}
