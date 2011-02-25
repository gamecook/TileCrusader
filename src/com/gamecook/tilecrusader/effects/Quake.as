/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 2/25/11
 * Time: 5:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.effects
{
    import flash.display.DisplayObject;

    public class Quake
    {
        private var target:DisplayObject;
        public function Quake(target:DisplayObject, Zoom:uint = 1)
		{
            this.target = target;

            _zoom = Zoom;
			start(0);
		}

        /**
		 * The game's level of zoom.
		 */
		protected var _zoom:uint;
		/**
		 * The intensity of the quake effect: a percentage of the screen's size.
		 */
		protected var _intensity:Number;
		/**
		 * Set to countdown the quake time.
		 */
		protected var _timer:Number;

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
		 * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move during the 'quake'.
		 * @param	Duration	The length in seconds that the "quake" should last.
		 */
		public function start(Intensity:Number=0.05,Duration:Number=0.5):void
		{
			stop();
			_intensity = Intensity;
			_timer = Duration * 1000;
		}

		/**
		 * Stops this screen effect.
		 */
		public function stop():void
		{
			x = 0;
			y = 0;
			_intensity = 0;
			_timer = 0;
		}

		/**
		 * Updates and/or animates this special effect.
		 */
		public function update(elapsed:Number):void
		{
			if(_timer > 0)
			{
				_timer -= elapsed;
				if(_timer <= 0)
				{
					_timer = 0;
					target.x = 0;
					target.y = 0;
				}
				else
				{
					target.x = (Math.random()*_intensity*target.width*.5)*_zoom;
					target.y = (Math.random()*_intensity*target.height*.5)*_zoom;
				}
			}
		}
    }
}
