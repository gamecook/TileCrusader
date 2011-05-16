/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 5/14/11
 * Time: 11:22 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.threads.effects
{
    import com.gamecook.tilecrusader.renderer.IScroll;
    import com.jessefreeman.factivity.threads.Thread;

    public class EaseScrollBehavior extends Thread
    {
        public var targetX:Number;
        public var targetY:Number;
        private var target:Object;
        private var speed:int = 5;


        public function EaseScrollBehavior(target:IScroll, updateCallback:Function = null, finishCallback:Function = null)
        {
            super(updateCallback, finishCallback);
            this.target = target;
        }

        override public function run(elapsed:Number = 0):void
        {
            var diffX:Number = Math.abs(targetX - target.scrollX);
            var diffY:Number = Math.abs(targetY - target.scrollY);
            if ( diffX < speed && diffY < speed)
            {
                finish();
                return;
            }
            else
            {
                target.scrollX -= (target.scrollX - targetX) / speed;
                target.scrollY -= (target.scrollY - targetY) / speed;

                super.run(elapsed);

            }

        }

    }
}
