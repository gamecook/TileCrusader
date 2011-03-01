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
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import com.gamecook.tilecrusader.behaviors.ButtonBehavior;
    import com.gamecook.tilecrusader.behaviors.IButton;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    public class Button extends Sprite implements IButton
    {
        protected var activeDisplayObject:DisplayObject;
        private var _isDown:Boolean;
        private var down:DisplayObject;
        private var over:DisplayObject;
        private var up:DisplayObject;
        private var pressAction:Function;
        private var clickOnUp:Boolean;

        public function Button(up:DisplayObject, pressAction:Function, over:DisplayObject = null, down:DisplayObject = null, hitArea:Rectangle = null, clickOnUp:Boolean = false)
        {
            this.clickOnUp = clickOnUp;
            this.pressAction = pressAction;
            changeStates(up, over, down, hitArea);

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            ButtonBehavior.addEventListeners(this);
            swapDisplayObject(up);
        }

        private function onRemovedFromStage(event:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            ButtonBehavior.removeEventListeners(this);
        }

        private function drawHitArea(hitArea:Rectangle):void
        {
            graphics.clear();
            graphics.beginFill(0xff0000, 0);
            graphics.drawRect(hitArea.x,hitArea.y,hitArea.width, hitArea.height);
            graphics.endFill();
        }

        public function onRollOver(event:MouseEvent):void
        {
            if(over)
                swapDisplayObject(over);
        }

        public function onRollOut(event:MouseEvent):void
        {
            swapDisplayObject(up);
        }

        public function onMouseDown(event:MouseEvent):void
        {
            if(down)
                swapDisplayObject(down);
            _isDown = true;

            if(!clickOnUp)
                pressAction();
        }

        public function onMouseUp(event:MouseEvent):void
        {
            //TODO this may need to test if mouse is in the button before going to over.
            if(over)
                swapDisplayObject(over);
            _isDown = false;

            if(clickOnUp)
                pressAction();
        }

        protected function swapDisplayObject(target:DisplayObject):void
        {
            if(activeDisplayObject)
                removeChild(activeDisplayObject);

            addChild(target);
            activeDisplayObject = target;
        }

        public function isDown():Boolean
        {
            return _isDown;
        }

        public function changeStates(up:DisplayObject, over:DisplayObject = null, down:DisplayObject = null, hitArea:Rectangle = null):void
        {
            this.up = up;
            this.over = over;
            this.down = down;

            if(hitArea)
                drawHitArea(hitArea);
        }

    }
}
