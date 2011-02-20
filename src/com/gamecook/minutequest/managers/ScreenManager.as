/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.managers
{
    import com.gamecook.minutequest.screens.BaseScreen;

    import flash.display.DisplayObjectContainer;

    public class ScreenManager
    {
        private var _currentState:BaseScreen;
        private var _target:DisplayObjectContainer;

        public function ScreenManager(target:DisplayObjectContainer) {
            this.target = target;
        }

        public function set target(target:DisplayObjectContainer):void
        {
            _target = target;
        }

        public function set state(state:Class)
        {
            if(_currentState)
            {
                _target.removeChild(_currentState);
            }

            _currentState = new state();

            _target.addChild(_currentState);

        }
    }

}
