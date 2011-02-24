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
 * Date: 2/20/11
 * Time: 9:04 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    public class StackLayout extends Sprite
    {
        public static const VERTICAL:String = "y";
        public static const HORIZONTAL:String = "x";

        private const WIDTH:String = "width";
        private const HEIGHT:String = "height";

        private var dirProp:String = HORIZONTAL;
        private var sizeProp:String = WIDTH;
        private var gap:int = 0;

        public function StackLayout(gap:int = 0, direction:String = VERTICAL)
        {
            this.gap = gap;
            this.direction = direction;
        }

        protected function set direction(value:String):void
        {
            switch (value)
            {
                case VERTICAL:
                    dirProp = VERTICAL;
                    sizeProp = HEIGHT;
                    break;
                default:
                    dirProp = HORIZONTAL;
                    sizeProp = WIDTH;
                    break;
            }
        }

        override public function addChild(child:DisplayObject):DisplayObject
        {
            super.addChild(child);
            refresh();
            return child;
        }

        override public function addChildAt(child:DisplayObject, index:int):DisplayObject
        {
            super.addChildAt(child, index);
            refresh();
            return child;
        }

        override public function removeChild(child:DisplayObject):DisplayObject
        {
            super.removeChild(child);
            refresh();
            return child;
        }

        override public function removeChildAt(index:int):DisplayObject
        {
            var displayObject:DisplayObject = super.removeChildAt(index);
            refresh();
            return displayObject;
        }

        protected function refresh():void
        {
            var total:int = this.numChildren;
            var i:int;
            var nextCoord:Number = 0;
            var child:DisplayObject;

            for (i = 0; i < total; i ++)
            {
                child = this.getChildAt(i);

                child[dirProp] = nextCoord;
                nextCoord += child[sizeProp] + gap;

            }
        }
    }
}
