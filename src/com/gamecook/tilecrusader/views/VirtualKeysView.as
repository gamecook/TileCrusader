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

    import flash.display.Bitmap;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class VirtualKeysView extends Sprite
    {
        [Embed(source="../../../../../build/assets/arrow_up.gif")]
        public static var ArrowUp:Class;

        [Embed(source="../../../../../build/assets/arrow_right.gif")]
        public static var ArrowRight:Class;

        [Embed(source="../../../../../build/assets/arrow_down.gif")]
        public static var ArrowDown:Class;

        [Embed(source="../../../../../build/assets/arrow_left.gif")]
        public static var ArrowLeft:Class;

        private var upBTN:Sprite;
        private var downBTN:Sprite;
        private var leftBTN:Sprite;
        private var rightBTN:Sprite;
        private var target:IControl;

        public function VirtualKeysView(target:IControl)
        {
            this.target = target;

            upBTN = new Sprite();
            upBTN.addChild(new ArrowUp() as Bitmap);
            upBTN.addEventListener(MouseEvent.MOUSE_DOWN, onUp);
            upBTN.x = upBTN.width;
            addChild(upBTN);

            downBTN = new Sprite();
            downBTN.addChild(new ArrowDown() as Bitmap);
            downBTN.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            downBTN.x = upBTN.x;
            downBTN.y = upBTN.height;
            addChild(downBTN);

            rightBTN = new Sprite();
            rightBTN.addChild(new ArrowRight() as Bitmap);
            rightBTN.addEventListener(MouseEvent.MOUSE_DOWN, onRight);
            rightBTN.x = downBTN.x + downBTN.width;
            rightBTN.y = downBTN.y;
            addChild(rightBTN);

            leftBTN = new Sprite();
            leftBTN.addChild(new ArrowLeft() as Bitmap);
            leftBTN.addEventListener(MouseEvent.MOUSE_DOWN, onLeft);
            leftBTN.y = downBTN.y;
            addChild(leftBTN);

        }

        private function onLeft(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            target.left();
        }

        private function onRight(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            target.right();
        }

        private function onUp(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            target.up();
        }

        private function onDown(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            target.down();
        }

    }
}
