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
 * Date: 3/5/11
 * Time: 12:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.gamecook.tilecrusader.states.ActiveGameState;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.activities.IActivityManager;

    public class FinishMapActivity extends BaseActivity
    {
        private var activeGameState:ActiveGameState;

        public function FinishMapActivity(stateManager:IActivityManager, data:*)
        {
            super(stateManager, data);
        }


        override protected function onCreate():void
        {
            activeGameState = new ActiveGameState();

            trace("Finish Map Success", data.success);
            loadState();

            super.onCreate();

            var message:Label = new Label(this, 0, 0, "You have escaped the map.");

            //activeGameState.clearMapData();
            startNextActivityTimer(RandomMapGeneratorActivity, 1, data);
        }


        override public function loadState():void
        {
            activeGameState.load();
        }

        override public function saveState():void
        {
            activeGameState.save();

        }
    }
}
