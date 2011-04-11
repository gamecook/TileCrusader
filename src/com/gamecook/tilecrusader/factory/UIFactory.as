/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/17/11
 * Time: 11:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.factory
{
import com.gamecook.tilecrusader.views.Button;
import com.gamecook.tilecrusader.views.forms.InputField;
import com.gamecook.tilecrusader.views.forms.NumberStepper;
import com.gamecook.tilecrusader.views.forms.PopUpPicker;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import flashx.textLayout.formats.TextAlign;

public class UIFactory
    {
        private static var tfx:TextFormat = new TextFormat("system", 18, 0xffffff);

        public static function createTextField(x:int = 0, y:int = 0, text:String = "", width:int = 0, height:int = 20, align:String = TextAlign.LEFT):TextField
        {
            var tmpTF:TextField = new TextField();
            tmpTF.autoSize = TextFieldAutoSize.LEFT;
            tmpTF.embedFonts = true;
            tmpTF.x = x;
            tmpTF.y = y;

            if(width > 0)
            {
                tmpTF.width = width;
                tmpTF.height = height;
                tmpTF.autoSize = TextFieldAutoSize.NONE;
            }
            tfx.align = align;
            tmpTF.defaultTextFormat = tfx;
            tmpTF.selectable = false;
            tmpTF.antiAliasType = AntiAliasType.ADVANCED;
            tmpTF.sharpness = 500;
            tmpTF.text = text;


            // Reset TFX
            tfx.align = TextAlign.LEFT;

            return tmpTF;
        }

        public static function createTextFieldButton(click:Function, x:int = 0, y:int = 0, text:String = "", leftDecoration:String = "[", rightDecoration:String = "]"):Button
        {
            var states:Object = createButtonStates(text);
            var upTF = states.up;
            var downTF = states.down;
            var overTF:DisplayObject = states.over;
            var rect:Rectangle = states.rect;

            var btn:Button = new Button(upTF, click, overTF, downTF, rect, true);
            btn.x = x;
            btn.y = y;

            btn.addEventListener(MouseEvent.CLICK, click);

            return btn;
        }

        public static function createButtonStates(text:String,leftDecoration:String = "[", rightDecoration:String = "]"):Object
        {
            var upTF:TextField = createTextField(0, 0, leftDecoration + text + rightDecoration);

            var downTF:TextField = createTextField(0, 0, leftDecoration + text + rightDecoration);
            downTF.textColor = 0xff0000;

            var overTF:TextField = createTextField(0, 0, leftDecoration + text + rightDecoration);
            overTF.textColor = 0xdddddd;

            var rect:Rectangle = new Rectangle(-5, -5, upTF.width + 10, upTF.height + 10);

            return {up:upTF, down:downTF, over:overTF, rect:rect};
        }

        public static function createKeyButton(up:DisplayObject, pressAction:Function):Button
        {
            var btn:Button = new Button(up, pressAction, null, null, new Rectangle(0,0,up.width, up.height));

            return btn;
        }

        public static function createInputField(x:int, y:int, text:String, width:int = 200):InputField
        {
            var tf:TextField = createTextField(x,y,text);
            tf.type = TextFieldType.INPUT;
            tf.selectable = true;
            tf.width = width;
            tf.autoSize = TextFieldAutoSize.NONE;

            var inputField:InputField = new InputField(tf, text);
            return inputField;
        }

        public static function createPopUpPicker(x:int, y:int, data:Array):PopUpPicker
        {
            var picker:PopUpPicker = new PopUpPicker(data, 0);

            return picker;
        }

        public static function createNumberStepper(minValue:int, maxValue:int, startValue:int):NumberStepper
        {
            var numStepper:NumberStepper = new NumberStepper(minValue, maxValue, startValue);
            return numStepper;
        }
    }
}
