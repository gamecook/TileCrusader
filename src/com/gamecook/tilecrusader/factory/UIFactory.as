/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/17/11
 * Time: 11:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.factory
{
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class UIFactory
    {
        private static var tfx:TextFormat = new TextFormat("system", 18, 0xffffff);

        public static function createTextField(x:int = 0, y:int = 0, text:String = ""):TextField
        {
            var tmpTF:TextField = new TextField();
            tmpTF.autoSize = TextFieldAutoSize.LEFT;
            tmpTF.embedFonts = true;
            tmpTF.x = x;
            tmpTF.y = y;
            tmpTF.defaultTextFormat = tfx;
            tmpTF.selectable = false;
            tmpTF.antiAliasType = AntiAliasType.ADVANCED;
            tmpTF.sharpness = 500;
            tmpTF.text = text;
            return tmpTF;
        }

        public static function createTextFieldButton(click:Function, x:int = 0, y:int = 0, text:String = ""):SimpleButton
        {
            var upTF:TextField = createTextField(0,0,"[ "+text+" ]");

            var downTF:TextField = createTextField(0,0,"[ "+text+" ]");
            downTF.textColor = 0xff0000;

            var overTF:TextField = createTextField(0,0,"[ "+text+" ]");
            overTF.textColor = 0x333333;

            var btn:SimpleButton = new SimpleButton(upTF, overTF, downTF, upTF);
            btn.x = x;
            btn.y = y;

            btn.addEventListener(MouseEvent.CLICK, click);

            return btn;
        }
    }
}
