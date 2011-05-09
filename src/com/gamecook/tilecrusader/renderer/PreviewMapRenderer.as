/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 4/14/11
 * Time: 6:27 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.renderer
{
    import com.gamecook.frogue.renderer.MapDrawingRenderer;

    import flash.display.Graphics;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class PreviewMapRenderer extends MapDrawingRenderer
    {
        private var lastPlayerPosition:Point;

        public function PreviewMapRenderer(target:Graphics, tileSize:Rectangle)
        {
            super(target, tileSize);
        }

        override protected function tileColor(value:String):uint
        {
            switch (value)
            {
                case "#":
                    return 0x000000;
                case "T":
                    return 0x00FF00;
                case "@":
                    return 0xff0000;
                case "_":
                    return 0x999999;
                case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                return 0x0000ff;
                default:
                    return 0xffffff;
            }
        }

        override public function renderPlayer(j:int, i:int, tileType:String):void
        {
            if (lastPlayerPosition)
            {
                renderTile(lastPlayerPosition.x, lastPlayerPosition.y, "_", 0);
                lastPlayerPosition.x = j;
                lastPlayerPosition.y = i;
            }
            else
            {
                lastPlayerPosition = new Point(j, i);
            }
            super.renderPlayer(j, i, "@");
        }
    }
}
