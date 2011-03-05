/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.renderer
{
    import com.gamecook.frogue.renderer.MapBitmapRenderer;

    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.combat.IFight;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.tiles.BaseTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class MQMapBitmapRenderer extends MapBitmapRenderer
    {
        private var tileMap:TileTypes;
        private var instances:TileInstanceManager;
        private var currentTileID:int;
        private var statsTF:TextField;
        private var statsMatrix:Matrix;

        public function MQMapBitmapRenderer(target:BitmapData, spriteSheet:SpriteSheet, tileMap:TileTypes, instances:TileInstanceManager)
        {
            this.instances = instances;
            this.tileMap = tileMap;
            super(target, spriteSheet);

            statsTF = new TextField();
            statsTF.autoSize = TextFieldAutoSize.LEFT;
            statsTF.embedFonts = true;
            statsTF.antiAliasType = AntiAliasType.ADVANCED;
            statsTF.thickness = 0;
            statsTF.sharpness = 100;
            var tfx:TextFormat = new TextFormat("system2", 8, 0xffffff);
            tfx.letterSpacing = -1.2;
            statsTF.defaultTextFormat = tfx;

            var outline:GlowFilter = new GlowFilter();
            outline.blurX = outline.blurY = 1;
            outline.color = 0x000000;
            outline.quality = BitmapFilterQuality.HIGH;
            outline.strength = 600;

            var filterArray:Array = new Array();
            filterArray.push(outline);
            statsTF.filters = filterArray;

            statsMatrix = new Matrix();
            statsMatrix.translate(-3, 12);
            //statsMatrix.scale(.8,.8);
        }


        override protected function renderTile(j:int, i:int, currentTile:String, tileID:int):void
        {
            currentTileID = tileID;
            super.renderTile(j, i, currentTile, tileID);
        }


        override protected function tileBitmap(value:String):BitmapData
        {
            var bitmapData:BitmapData = spriteSheet.getSprite(tileMap.getTileSprite(" "), tileMap.getTileSprite(value));

            if(tileMap.isMonster(value) || tileMap.isPlayer(value) || tileMap.isBoss(value))
            {
                var tile:IFight = instances.getInstance(tileMap.isPlayer(value) ? "@" : currentTileID.toString(), value) as IFight;
                bitmapData = bitmapData.clone();

                statsTF.htmlText = "<font color='#ffff00'>"+tile.getAttackRolls()+"</font> <font color='#ffffff'>"+tile.getDefenseRolls()+"</font>";

                bitmapData.draw(statsTF, statsMatrix);

                var life:Number = tile.getLife() / tile.getMaxLife();

                if(life < 1)
                {
                    var matrix:Matrix = new Matrix();

                    bitmapData = bitmapData.clone();
                    var xOffset:int = bitmapData.width-2;

                    var bg:BitmapData = new BitmapData(2,bitmapData.height,false, 0xff0000);

                    var lifeBarHeight:Number = Math.floor(bitmapData.height * life -1);
                    if(lifeBarHeight <=0) lifeBarHeight = 1;
                    var lifeBarY:Number = bitmapData.height - lifeBarHeight;
                    var bar:BitmapData = new BitmapData(2,lifeBarHeight,false, 0x00ff00);

                    matrix.translate(xOffset, 0);
                    bitmapData.draw(bg, matrix);

                    matrix.translate(0, lifeBarY);
                    bitmapData.draw(bar, matrix);

                }
            }

            return bitmapData;
        }


    }
}
