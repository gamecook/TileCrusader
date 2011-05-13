/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 5/12/11
 * Time: 12:17 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.factories.SpriteSheetFactory;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.activities.IActivityManager;
    import com.jessefreeman.factivity.managers.SingletonManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ColorSwapTest extends BaseActivity
    {

        public function ColorSwapTest(activityManager:IActivityManager, data:*)
        {
            super(activityManager, data);
        }


        override public function onStart():void
        {
            super.onStart();

            var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet) as SpriteSheet
            SpriteSheetFactory.parseSpriteSheet(spriteSheet);

            var bitmap:Bitmap = new Bitmap(spriteSheet.getSprite("sprite24"));

            //bitmap.bitmapData.paletteMap(bitmap.bitmapData,new Rectangle(0,0,bitmap.width, bitmap.height), new Point(), redArray, greenArray);
            //ColorUtil.replaceColor(bitmap.bitmapData, 0xffa6a6a6, 0xffff0000);
            //addChild(bitmap);


            var myBitmapData:BitmapData = new BitmapData(80, 80, false, 0x00FF0000);
            myBitmapData.fillRect(new Rectangle(20, 20, 40, 40), 0x0000FF00);

            var redArray:Array = new Array(256);
            var greenArray:Array = new Array(256);

            for (var i:uint = 0; i < 255; i++)
            {
                redArray[i] = 0x00000000;
                greenArray[i] = 0x00000000;
            }

            redArray[0xFF] = 0x0000FF00;
            greenArray[0xFF] = 0x00FF0000;

            var bottomHalf:Rectangle = new Rectangle(0, 0, 100, 40);
            var pt:Point = new Point(0, 0);
            myBitmapData.paletteMap(myBitmapData, bottomHalf, pt, redArray, greenArray);

            var bm1:Bitmap = new Bitmap(myBitmapData);
            addChild(bm1);
        }
    }
}
