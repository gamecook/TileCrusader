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
    import flash.geom.Rectangle;

    public class PreviewMapRenderer extends MapDrawingRenderer
    {

        public function PreviewMapRenderer(target:Graphics, tileSize:Rectangle)
        {
            super(target, tileSize);
        }

        override protected function tileColor(value:String):uint
        {
            switch(value)
            {
                case "#":
                    return 0x333333;
                case "@":
                    return 0xff0000;
                case "x":
                    return 0x00ff00;
                default:
                    return 0xffffff;
            }
        }

    }
}
