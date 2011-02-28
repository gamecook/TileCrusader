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
 * Date: 2/21/11
 * Time: 7:04 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import com.gamecook.frogue.io.IControl;

    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.jessefreeman.factivity.activities.IUpdate;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class VirtualKeysView extends Sprite implements IUpdate
    {
        [Embed(source="../../../../../build/assets/arrow_up.gif")]
        public static var ArrowUp:Class;

        [Embed(source="../../../../../build/assets/arrow_right.gif")]
        public static var ArrowRight:Class;

        [Embed(source="../../../../../build/assets/arrow_down.gif")]
        public static var ArrowDown:Class;

        [Embed(source="../../../../../build/assets/arrow_left.gif")]
        public static var ArrowLeft:Class;

        private var upBTN:Button;
        private var downBTN:Button;
        private var leftBTN:Button;
        private var rightBTN:Button;
        private var target:IControl;
        private var pressedButton:Button;

        public function VirtualKeysView(target:IControl)
        {
            this.target = target;

            upBTN = addChild(UIFactory.createKeyButton(new ArrowUp(), onUp)) as Button;
            upBTN.x = upBTN.width;

            downBTN = addChild(UIFactory.createKeyButton(new ArrowDown(), onDown)) as Button;
            downBTN.x = upBTN.x;
            downBTN.y = upBTN.height;

            rightBTN = addChild(UIFactory.createKeyButton(new ArrowRight(), onRight)) as Button;
            rightBTN.x = downBTN.x + downBTN.width;
            rightBTN.y = downBTN.y;

            leftBTN = addChild(UIFactory.createKeyButton(new ArrowLeft(), onLeft)) as Button;
            leftBTN.y = downBTN.y;

        }

        private function onLeft():void
        {
            pressedButton = leftBTN;
        }

        private function onRight():void
        {
            pressedButton = rightBTN;
        }

        private function onUp():void
        {
            pressedButton = upBTN;
        }

        private function onDown():void
        {
            pressedButton = downBTN;
        }


        public function update(elapsed:Number = 0):void
        {
            if(pressedButton)
            {
                switch(pressedButton)
                {
                    case leftBTN:
                        target.left();
                        break;
                    case rightBTN:
                        target.right();
                        break;
                    case downBTN:
                        target.down();
                        break;
                    case upBTN:
                        target.up();
                        break;
                }

                if(!pressedButton.isDown())
                    pressedButton = null

            }

        }
    }
}
