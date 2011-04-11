/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/14/11
 * Time: 8:18 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tools.generator {
import com.gamecook.frogue.sprites.SpriteSheet;
import com.gamecook.tilecrusader.serialize.ISerializeToObject;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;

public class CharacterGenerator implements ISerializeToObject{

        private static const SPRITE_SIZE:Rectangle = new Rectangle(0,0,32,32);

        [Embed(source="../../../../../../build/assets/sprites/body_sprites.png")]
        public static var BodySprites:Class;
        [Embed(source="../../../../../../build/assets/sprites/face_sprites.png")]
        public static var FaceSprites:Class;
        [Embed(source="../../../../../../build/assets/sprites/outfit_sprites.png")]
        public static var OutfitSprites:Class;

        private var bitmapData:BitmapData;
        private var bodySpriteSheet:SpriteSheet;
        private var faceSpriteSheet:SpriteSheet;
        private var outfitSpriteSheet:SpriteSheet;
        private var bodySpriteID:String = "Sprite0";
        private var faceSpriteID:String = "Sprite0";
        private var outfitSpriteID:String = "Sprite0";

        public function CharacterGenerator()
        {

            bitmapData = new BitmapData(SPRITE_SIZE.width, SPRITE_SIZE.height, true, 0);
            bodySpriteSheet = createSpriteSheet(new BodySprites() as Bitmap);
            faceSpriteSheet = createSpriteSheet(new FaceSprites() as Bitmap);
            outfitSpriteSheet = createSpriteSheet(new OutfitSprites() as Bitmap);
        }

        private function createSpriteSheet(bitmap:Bitmap):SpriteSheet
        {
            var spriteSheet:SpriteSheet = new SpriteSheet(bitmap.bitmapData);
            var rect:Rectangle = SPRITE_SIZE.clone();

            var total:int = bitmap.width/rect.width;
            var i:int;

            for(i = 0; i < total; i ++)
            {
                rect.x = rect.width * i;
                spriteSheet.registerSprite("Sprite"+i, rect.clone());
            }

            return spriteSheet;
        }

        public function changeBody(value:String):void
        {
            if(bodySpriteSheet.hasSprite(value))
                bodySpriteID = value;

        }

        public function changeFace(value:String):void
        {
            if(faceSpriteSheet.hasSprite(value))
                faceSpriteID = value;
        }

        public function changeOutfit(value:String):void
        {
            if(outfitSpriteSheet.hasSprite(value))
                outfitSpriteID = value;
        }

        public function generateBitmapData():BitmapData
        {

            bitmapData.fillRect(SPRITE_SIZE, 0);
            bitmapData.draw(bodySpriteSheet.getSprite(bodySpriteID));
            bitmapData.draw(outfitSpriteSheet.getSprite(outfitSpriteID));
            bitmapData.draw(faceSpriteSheet.getSprite(faceSpriteID));
            return bitmapData.clone();
        }

        public function parseObject(value:Object):void
        {
            if(value.hasProperty("body"))
                changeBody(value.body);
            if(value.hasProperty("face"))
                changeBody(value.face);
            if(value.hasProperty("outfit"))
                changeBody(value.outfit);
        }

        public function toObject():Object
        {
            return {body:bodySpriteID, outfit:outfitSpriteID, face:faceSpriteID};
        }

        public function getBodySpriteNames():Array
        {
            return bodySpriteSheet.spriteNames.slice();
        }

        public function getOutfitSpriteNames():Array
        {
            return outfitSpriteSheet.spriteNames.slice();
        }

        public function getFaceSpriteNames():Array
        {
            return faceSpriteSheet.spriteNames.slice();
        }
    }
}
