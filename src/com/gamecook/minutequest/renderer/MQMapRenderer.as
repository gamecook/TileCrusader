/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.renderer
{
    import com.gamecook.frogue.renderer.MapDrawingRenderer;

    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.managers.TileInstanceManager;
    import com.gamecook.minutequest.tiles.BaseTile;
    import com.gamecook.minutequest.tiles.MonsterTile;
    import com.gamecook.minutequest.tiles.TileTypes;

    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public class MQMapRenderer extends MapDrawingRenderer
    {
        private var tileMap:TileTypes;
        private var instances:TileInstanceManager;

        public function MQMapRenderer(target:Graphics, tileSize:Rectangle, tileMap:TileTypes, instances:TileInstanceManager)
        {
            this.instances = instances;
            this.tileMap = tileMap;
            super(target, tileSize);
        }


        override protected function renderTile(j:int, i:int, currentTile:String, tileID:int):void
        {
            super.renderTile(j, i, currentTile, tileID);

            var isPlayer:Boolean = currentTile == "@";
            if(instances.hasInstance(tileID.toString()) || isPlayer)
            {
                var tile:BaseTile = instances.getInstance(isPlayer ? "@" : tileID.toString());
                if(tile is IFight)
                {
                    var fighterTile:IFight = tile as IFight;
                    var life:Number = fighterTile.getLife() / fighterTile.getMaxLife();
                    if(life != 1)
                    {
                        var xOffset:int = tileRect.x+tileRect.width-2;
                        target.beginFill(0xff0000);
                        target.drawRect(xOffset, tileRect.y+1, 2, tileRect.height-1);

                        var lifeBarHeight:Number = tileRect.height * life -1;
                        var lifeBarY:Number = Math.round((tileRect.y + tileRect.height) - lifeBarHeight);
                        target.beginFill(0x00ff00);
                        target.drawRect(xOffset, lifeBarY, 2, lifeBarHeight);

                        target.endFill();
                    }
                }
            }

        }

        override protected function tileColor(value:String):uint
        {
            return tileMap.getTileColor(value);
        }
    }
}
