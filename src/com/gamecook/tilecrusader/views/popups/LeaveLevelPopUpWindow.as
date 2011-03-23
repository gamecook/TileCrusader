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
 * Date: 2/27/11
 * Time: 9:51 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views.popups
{
    import com.gamecook.tilecrusader.views.*;
    import com.gamecook.tilecrusader.activities.StartActivity;
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.gamecook.tilecrusader.views.popups.BasePopUp;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class LeaveLevelPopUpWindow extends BasePopUp
    {
        private var onAcceptCallback:Function;
        public function LeaveLevelPopUpWindow(onAcceptCallback:Function)
        {
            this.onAcceptCallback = onAcceptCallback;
        }

        override protected function init():void
        {

            var warning:String = "Do you really want to leave this dungeon?\n\nYou have not finished the quest yet. When you leave a dungeon you do not get an bonuses for completing a level and you will not be able to replay this level." ;

            var tf:TextField = addChild(UIFactory.createTextField(0,0,warning)) as TextField;
            tf.multiline = true;
            tf.wordWrap = true;
            tf.width = 600;
            tf.autoSize = TextFieldAutoSize.LEFT;

            var btnLayout:StackLayout = new StackLayout(5, StackLayout.HORIZONTAL);


            var closeBtn:Button = btnLayout.addChild(UIFactory.createTextFieldButton(onClose, 0, tf.y + tf.height+30, "No Thanks.")) as Button;
            closeBtn.x = (tf.width - closeBtn.width) * .5;

            var btn:Button = btnLayout.addChild(UIFactory.createTextFieldButton(onAccept, 0, tf.y + tf.height+30, "Let Me Out!")) as Button;

            btnLayout.x = tf.width - (btnLayout.width+10);
            btnLayout.y = tf.y + tf.height;

            addChild(btnLayout);
            paddingTop = -5;
            paddingLeft = -5;
            paddingRight = 0;
            paddingBottom = 10;

            super.init();

        }

        private function onClose():void
        {
            close();
        }

        public function onAccept():void
        {

            onAcceptCallback();
            close();
        }

    }
}
