/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/28/11
 * Time: 10:28 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views.forms
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.text.TextField;

    public class InputField extends Sprite
    {
        private var _textField:TextField;
        private var defaultText:String;

        public function InputField(target:TextField, defaultText:String = " ")
        {
            this.defaultText = defaultText;
            _textField = target;
            addChild(textField);
            textField.text = defaultText;
            drawDecoration(FocusEvent.FOCUS_OUT);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);

            textField.addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			textField.addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
        }

        private function onRemoveFromStage(event:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function getTextField():TextField
        {
            return textField;
        }

           protected function checkText() : void
            {
                if( textField.text == "" )
                    textField.text = defaultText;
            }

        protected function onFocusIn( event : FocusEvent ) : void
		{
            if( textField.text == defaultText && textField.text != "" )
				textField.text = "";
            drawDecoration(FocusEvent.FOCUS_IN);
		}

		protected function onFocusOut( event : FocusEvent ) : void
		{
			checkText( );
            drawDecoration(FocusEvent.FOCUS_OUT);
		}

        private function drawDecoration(state:String):void
        {
            graphics.clear();
            graphics.lineStyle(4, state == FocusEvent.FOCUS_IN ? 0x0000ff : 0xffffff);
            graphics.beginFill(0x000000);
            graphics.drawRect(-10,-5, textField.width + 10, textField.height+ 10);
            graphics.endFill();
        }

        public function getValue():String
        {
            return textField.text;
        }

        public function get textField():TextField
        {
            return _textField;
        }
    }
}
