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
 * Date: 3/1/11
 * Time: 7:45 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
import com.bit101.components.Label;
import com.bit101.utils.MinimalConfigurator;
import com.jessefreeman.factivity.activities.BaseActivity;
import com.jessefreeman.factivity.managers.IActivityManager;

import flash.events.MouseEvent;

public class MinimalCompsTestActivity extends BaseActivity
    {
        public var myLabel:Label;

        public function MinimalCompsTestActivity(stateManager:IActivityManager, data:*)
        {
            super(stateManager, data);
        }

        override public function onStart():void
        {
            super.onStart();

            var xml:XML = <comps>
            <HBox x="10" y="10" scaleX="3" scaleY="3">
                <PushButton label="File" width="60"/>
                <PushButton label="Edit" width="60"/>
                <PushButton label="View" width="60"/>
                <PushButton label="Settings" width="60"/>
                <PushButton label="Help" width="60"/>
            </HBox>
        </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);
        }

        public function onClick(event:MouseEvent):void
        {
            myLabel.text = "You did it";
        }
    }
}
