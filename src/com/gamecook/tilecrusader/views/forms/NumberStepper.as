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
 * Date: 3/1/11
 * Time: 12:28 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views.forms
{
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.gamecook.tilecrusader.views.Button;
    import com.gamecook.tilecrusader.views.StackLayout;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    import flashx.textLayout.formats.TextAlign;

    public class NumberStepper extends Sprite
    {
        private var maxValue:int;
        private var value:int;
        private var layout:StackLayout;
        private var increaseBtn:Button;
        private var decreaseBtn:Button;
        private var field:TextField;
        private var minValue:int;

        public function NumberStepper(minValue:int, maxValue:int, startValue:int = 0)
        {
            this.minValue = minValue;
            this.value = startValue;
            this.maxValue = maxValue;

            init();
        }

        protected function init():void
        {
            layout = new StackLayout(5, StackLayout.HORIZONTAL);
            addChild(layout);
            decreaseBtn = UIFactory.createTextFieldButton(onDecrease,0,0,"-");
            layout.addChild(decreaseBtn);

            field = UIFactory.createTextField(0,0,value.toString(),100, 80, TextAlign.LEFT);

            layout.addChild(field);

            increaseBtn = UIFactory.createTextFieldButton(onIncrease,0,0,"+");
            layout.addChild(increaseBtn);
        }

        private function onIncrease():void
        {
            var tmpValue:int = value +1;

            if(tmpValue > maxValue)
                tmpValue = minValue;

            setValue(tmpValue);
        }

        private function onDecrease():void
        {
            var tmpValue:int = value -1;

            if(tmpValue < minValue)
               tmpValue = maxValue;

             setValue(tmpValue);
        }

        public function setValue(value:int):void
        {
            this.value = value;
            field.text = value.toString();

            trace("Value", value);
        }

        public function getValue():int
        {
            return value;
        }
    }
}
