/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.renderer
{
    import com.gamecook.frogue.renderer.MapBitmapRenderer;

    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.managers.TileInstanceManager;
    import com.gamecook.minutequest.tiles.BaseTile;
    import com.gamecook.minutequest.tiles.TileTypes;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class MQMapBitmapRenderer extends MapBitmapRenderer
    {
        private var tileMap:TileTypes;
        private var instances:TileInstanceManager;
        private var currentTileID:int;
        public function MQMapBitmapRenderer(target:BitmapData, spriteSheet:SpriteSheet, tileMap:TileTypes, instances:TileInstanceManager)
        {
            this.instances = instances;
            this.tileMap = tileMap;
            super(target, spriteSheet);
        }


        override protected function renderTile(j:int, i:int, currentTile:String, tileID:int):void
        {
            currentTileID = tileID;
            super.renderTile(j, i, currentTile, tileID);



        }


        override protected function tileBitmap(value:String):BitmapData
        {
            var bitmapData:BitmapData = spriteSheet.getSprite(tileMap.getTileSprite(" "), tileMap.getTileSprite(value));

            var isPlayer:Boolean = value == "@";
            if(instances.hasInstance(currentTileID.toString()) || isPlayer)
            {
                var tile:BaseTile = instances.getInstance(isPlayer ? "@" : currentTileID.toString());
                if(tile is IFight)
                {
                    var fighterTile:IFight = tile as IFight;
                    var life:Number = fighterTile.getLife() / fighterTile.getMaxLife();
                    if(life != 1)
                    {
                        bitmapData = bitmapData.clone();
                        var xOffset:int = bitmapData.width-2;

                        var bg:BitmapData = new BitmapData(2,bitmapData.height,false, 0xff0000);

                        var lifeBarHeight:Number = bitmapData.height * life -1;
                        var lifeBarY:Number = Math.round( bitmapData.height - lifeBarHeight);
                        if(lifeBarHeight <=0) lifeBarHeight = 1;
                        var bar:BitmapData = new BitmapData(2,lifeBarHeight,false, 0x00ff00);

                        var matrix:Matrix = new Matrix();
                        matrix.translate(xOffset, 0);
                        bitmapData.draw(bg, matrix);

                        matrix.translate(0, lifeBarY);
                        bitmapData.draw(bar, matrix);
                    }
                }
            }

            return bitmapData;
        }
    }
}
