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
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.factory.SpriteSheetFactory;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.SoundManager;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.text.StyleSheet;
    import flash.text.TextField;

    public class TileCrusaderSplashActivity extends AdvancedActivity
    {

        [Embed(source="../../../../../build/assets/tc_logo.png")]
        public static var Logo:Class;

        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);

        public function TileCrusaderSplashActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {

            super.onCreate();

            var logo:Bitmap = new Logo();
            logo.x = (fullSizeWidth - logo.width) * .5;
            logo.y  = ((fullSizeHeight - logo.height) * .5);
            addChild(logo);

            startNextActivityTimer(WarningActivity, 3);

            SpriteSheetFactory.parseSpriteSheet(spriteSheet);

        }


    }
}
