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
 * Date: 2/26/11
 * Time: 12:49 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.behaviors
{
    import flash.events.MouseEvent;

    public class ButtonBehavior
    {
        protected var inside:Boolean = false;

        public static function addEventListeners(target:IButton):void
        {
            target.addEventListener(MouseEvent.ROLL_OVER, target.onRollOver);
            target.addEventListener(MouseEvent.ROLL_OUT, target.onRollOut);
            target.addEventListener(MouseEvent.MOUSE_DOWN, target.onMouseDown);
            target.addEventListener(MouseEvent.MOUSE_UP, target.onMouseUp);
        }

        public static function removeEventListeners(target:IButton):void
        {
            target.removeEventListener(MouseEvent.ROLL_OVER, target.onRollOver);
            target.removeEventListener(MouseEvent.ROLL_OUT, target.onRollOut);
            target.removeEventListener(MouseEvent.MOUSE_DOWN, target.onMouseDown);
            target.removeEventListener(MouseEvent.MOUSE_UP, target.onMouseUp);
        }

    }

}
