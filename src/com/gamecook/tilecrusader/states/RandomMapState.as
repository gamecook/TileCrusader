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
 * Time: 9:34 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
    import com.gamecook.lib.states.BaseState;
    import com.gamecook.tilecrusader.views.AutoPlayMap;

    public class RandomMapState extends BaseState
    {
        protected var randMap:AutoPlayMap;
        protected var movementCounter:int = 0;
        protected var nextMovement:int = 500;
        protected var mapViewPortWidth = 500;
        protected var mapViewPortHeight = 200;
        protected var mapViewPortX = 260;
        protected var mapViewPortY = 150;

        public function RandomMapState(data:* = null)
        {
            super(data);
        }

        override public function create():void
        {
            super.create();

            randMap = new AutoPlayMap(mapViewPortWidth, mapViewPortHeight);
            randMap.x = mapViewPortX;
            randMap.y = mapViewPortY;
            addChild(randMap);

        }

        override public function update(elapsed:Number = 0):void
        {
            super.update(elapsed);

            movementCounter += elapsed;
            if (movementCounter >= nextMovement)
            {
                randMap.nextMove();
                movementCounter = 0;
            }

        }

        override protected function render():void
        {
            super.render();
            randMap.render();
        }
    }
}
