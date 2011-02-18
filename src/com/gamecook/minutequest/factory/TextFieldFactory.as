/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/17/11
 * Time: 11:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.factory
{
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class TextFieldFactory
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
    }
}
