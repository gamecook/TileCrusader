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
 * Time: 9:52 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.SoundManager;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.text.TextField;

    public class TileCrusaderSplashActivity extends AdvancedActivity
    {

        public function TileCrusaderSplashActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {

            super.onCreate();

            var tf:Label = new Label(this,0, 0, "Tile Crusader");
            tf.x = (fullSizeWidth - tf.width) * .5;
            tf.y  = (fullSizeHeight - tf.height) * .5;
            tf.scaleX = tf.scaleY = 2;

            startNextActivityTimer(WarningActivity, 3);
        }
    }
}
