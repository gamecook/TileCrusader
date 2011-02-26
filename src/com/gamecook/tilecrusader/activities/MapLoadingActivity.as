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
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.frogue.helpers.PopulateMapHelper;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.geom.Rectangle;

    public class MapLoadingActivity extends BaseActivity
    {
        [Embed(source="../../../../../build/assets/spritesheet_template.png")]
        public static var SpriteSheetImage:Class;

        private var splashScreen:Bitmap;
        private var spriteSheet:SpriteSheet;

        public function MapLoadingActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            parseSpriteSheet();

            //TODO need to clean this up so it covers up the display correctly.
            splashScreen = new Bitmap(spriteSheet.getSprite("splashScreen").clone());
            splashScreen.scaleX = splashScreen.scaleY = fullSizeWidth / splashScreen.width;
            splashScreen.y = (fullSizeHeight - splashScreen.height) * .5;

            addChild(splashScreen);

            createMap();

            startNextActivityTimer(GameActivity, 2, data);
        }

        private function createMap():void
        {
            var map:RandomMap = new RandomMap();
            TimeMethodExecutionUtil.execute("generateMap", map.generateMap, data.size);
            trace("Map Size", map.width, map.height, "was generated");




            data.map = map;

            data.monsters = ["1", "1", "1", "1", "2", "2", "2", "3", "3", "3", "4", "4", "4", "5", "5", "5", "6", "6", "6", "7", "7", "7", "8", "8", "9"];
            data.chests = ["T", "T", "T", "T", "T", "T", "T", "T", "T"];
            data.treasuePool = ["$","$","$","$","P","P","P","P"," "," "," "];



            var populateMapHelper:PopulateMapHelper = new PopulateMapHelper(map);
            populateMapHelper.populateMap.apply(this, data.monsters);
            populateMapHelper.populateMap.apply(this, data.chests);

            data.startPosition = populateMapHelper.getRandomEmptyPoint();

            data.cashPool = 100;
            data.cashRange = 10;
        }

        private function parseSpriteSheet():void
        {
            spriteSheet = SingletonManager.getClassReference(SpriteSheet);
            spriteSheet.clear();

            // create sprite sheet
            var bitmap:Bitmap = new SpriteSheetImage();
            spriteSheet.bitmapData = bitmap.bitmapData;
            spriteSheet.registerSprite("splashScreen", new Rectangle(0, 0, 800, 480));

            var i:int;
            var rows:int = Math.floor(bitmap.height / 20);
            var total:int = Math.floor((bitmap.width - 800) / 20) * (bitmap.height / 20);
            var spriteRect:Rectangle = new Rectangle(800, 0, 20, 20);
            for (i = 0; i < total; ++i)
            {
                spriteSheet.registerSprite("sprite" + i, spriteRect.clone());
                spriteRect.y += 20;
                if (i % rows == (rows - 1))
                {
                    spriteRect.x += 20;
                    spriteRect.y = 0;
                }
            }
        }
    }
}
