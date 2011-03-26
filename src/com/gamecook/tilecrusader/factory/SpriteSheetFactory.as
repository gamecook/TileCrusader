/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/24/11
 * Time: 11:55 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.factory {
    import com.gamecook.frogue.sprites.SpriteSheet;

    import com.gamecook.tilecrusader.utils.ColorUtil;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;


    public class SpriteSheetFactory {

        [Embed(source="../../../../../build/assets/tc_sprite_sheet.png")]
        public static var SpriteSheetImage:Class;

        private static const TILE_SIZE:int = 32;


        public static function parseSpriteSheet(spriteSheet:SpriteSheet):void
        {
            spriteSheet.clear();

            // create sprite sheet
            var bitmap:Bitmap = new SpriteSheetImage();
            spriteSheet.bitmapData = bitmap.bitmapData;
            var tileSize:int = 32;
            var i:int;
            var total:int = Math.floor(bitmap.width / tileSize);
            var spriteRect:Rectangle = new Rectangle(0, 0, tileSize, tileSize);
            for (i = 0; i < total; ++i)
            {
                spriteRect.x = i * tileSize;
                spriteSheet.registerSprite("sprite" + i, spriteRect.clone());
            }

            createDarknessTiles(spriteSheet);
            cacheCoreSprites(spriteSheet);

        }

        private static function cacheCoreSprites(spriteSheet:SpriteSheet):void
        {
            //TODO loop through sprites and remove bitmap data when done
        }

        private static function createDarknessTiles(spriteSheet:SpriteSheet):SpriteSheet
        {
            var i:int = 0;
            var total:int = 10;
            var bitmapData:BitmapData = new BitmapData(TILE_SIZE, TILE_SIZE, true, 0xFF000000);
            var rect:Rectangle = new Rectangle(0, 0, TILE_SIZE, TILE_SIZE);

            for (i = 0; i < total; i ++)
            {
                bitmapData.fillRect(rect, ColorUtil.returnARGB(0x000000, i * 20));
                spriteSheet.cacheSprite("light"+i, bitmapData.clone());
            }

            // Black Tile
            bitmapData.fillRect(rect, 0x00000000);
            spriteSheet.cacheSprite("light10", bitmapData.clone());

            return spriteSheet;

        }


    }
}
