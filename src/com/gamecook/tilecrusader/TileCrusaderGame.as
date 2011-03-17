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
 * Time: 5:26 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader
{
    import com.bit101.components.Component;
    import com.bit101.components.Style;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.SoundManager;
    import com.jessefreeman.factivity.AbstractApplication;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.events.Event;

    public class TileCrusaderGame extends AbstractApplication
    {
        protected var soundManager:SoundManager = SingletonManager.getClassReference(SoundManager) as SoundManager;

        public function TileCrusaderGame(x:int, y:int, state:Class, scale:Number = 1)
        {
            super(new ActivityManager(), state, x, y, scale);
        }

        override public function resume():void
        {
            super.resume();
            soundManager.playSounds();
        }

        override public function pause():void
        {
            super.pause();
            soundManager.pauseSounds();
        }
    }
}
