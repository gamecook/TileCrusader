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

    import com.gamecook.minutequest.managers.TileInstanceManager;
    import com.gamecook.minutequest.tiles.BaseTile;
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
            if(currentTile == "@")
            {
                trace("@ Tile ID", tileID);
            }
            // Check to see if tile has instance and render Tile UI
            /*var uiID:String = i+":"+j;
            if(instances.hasInstance(uiID))
            {
                var tile:BaseTile = instances.getInstance(uiID);
                trace("Render Tile");
                var xOffset:int = tileRect.x;
                target.beginFill(0x00ff00);
                target.drawRect(tileRect.x, tileRect.y, tileRect.width, tileRect.height);
                target.endFill();
                trace(tileRect);
            }*/

        }

        override protected function tileColor(value:String):uint
        {
            return tileMap.getTileColor(value);
        }
    }
}
