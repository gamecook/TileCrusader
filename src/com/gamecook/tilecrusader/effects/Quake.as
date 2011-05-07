/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 2/25/11
 * Time: 5:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.effects
{
    import com.jessefreeman.factivity.threads.GreenThread;

    import flash.display.DisplayObject;

    public class Quake extends GreenThread
    {
        private var target:DisplayObject;

        public function Quake(target:DisplayObject, intensity:Number = 0.05, duration:Number = 0.5, updateCallback:Function = null, finishCallback:Function = null)
        {
            super(updateCallback, finishCallback);
            defaultIntensity = intensity;
            defaultTime = duration * 1000;
            this.target = target;
        }

        /**
         * The intensity of the quake effect: a percentage of the screen's size.
         */
        protected var _intensity:Number;
        private var _defaultIntensity:Number;
        /**
         * Set to countdown the quake time.
         */
        protected var _timer:Number;
        private var _defaultTime:Number;

        /**
         * The amount of X distortion to apply to the screen.
         */
        public var x:int;
        /**
         * The amount of Y distortion to apply to the screen.
         */
        public var y:int;


        /**
         * Reset and trigger this special effect.
         *
         * @param    intensity    Percentage of screen size representing the maximum distance that the screen can move during the 'quake'.
         * @param    duration    The length in seconds that the "quake" should last.
         */
        override public function start():void
        {
            super.start();
            clearValues();
        }

        /**
         * Stops this screen effect.
         */
        override protected function finish():void
        {
            clearValues();
            super.finish();
        }

        private function clearValues():void
        {
            x = 0;
            y = 0;
            _intensity = _defaultIntensity;
            _timer = _defaultTime;
        }

        /**
         * Runs the Quake thread
         */
        override public function run(elapsed:Number = 0):void
        {
            if (_timer > 0)
            {
                _timer -= elapsed;
                if (_timer <= 0)
                {
                    _timer = 0;
                    target.x = 0;
                    target.y = 0;
                }
                else
                {
                    target.x = (Math.random() * _intensity * target.width * .5);
                    target.y = (Math.random() * _intensity * target.height * .5);
                }
            }
            else
            {
                finish();
            }
        }

        public function set defaultIntensity(value:Number):void
        {
            _defaultIntensity = value;
        }

        public function set defaultTime(value:Number):void
        {
            _defaultTime = value;
        }
    }
}
