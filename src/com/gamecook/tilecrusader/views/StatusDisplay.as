/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/17/11
 * Time: 10:52 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class StatusDisplay extends Sprite
    {
        private var statusLabel:TextField;

        public function StatusDisplay(width:int)
        {
            init();
        }

        private function init():void
        {
            statusLabel = new TextField();
            statusLabel.autoSize = TextFieldAutoSize.LEFT;
            //statusLabel.width = viewPortWidth;
            statusLabel.multiline = true;
            statusLabel.wordWrap = true;
            statusLabel.embedFonts = true;
            statusLabel.background = true;
            statusLabel.backgroundColor = 0x000000;
            statusLabel.x = 9;
            statusLabel.y = 6;
            statusLabel.defaultTextFormat = new TextFormat("system", 18, 0xffffff);
            addChild(statusLabel);

        }
    }
}
