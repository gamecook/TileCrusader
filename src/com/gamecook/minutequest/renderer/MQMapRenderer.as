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

    import com.gamecook.minutequest.tiles.TileTypes;

    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public class MQMapRenderer extends MapDrawingRenderer
    {
        private var tileMap:TileTypes;

        public function MQMapRenderer(target:Graphics, tileSize:Rectangle, tileMap:TileTypes)
        {
            this.tileMap = tileMap;
            super(target, tileSize);
        }

        override protected function tileColor(value:String):uint
        {
            return tileMap.getTileColor(value);
        }
    }
}
