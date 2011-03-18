/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/18/11
 * Time: 3:58 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;

    import flash.geom.Point;

    public class ActiveGameState extends AbstractStateObject
    {
        public function ActiveGameState()
        {
            super(this, ApplicationShareObjects.ACTIVE_GAME)
        }

        public function get player():Object{
            return dataObject.player;
        }

        public function set player(value:Object):void
        {
            dataObject.player = value;
        }

        public function get tileInstanceManager():Object
        {
            return dataObject.tileInstanceManager;
        }

        public function set tileInstanceManager(value:Object):void
        {
            dataObject.tileInstanceManager = value;
        }

        public function get mapSelection():Object
        {
            return dataObject.mapSelection;
        }

        public function set mapSelection(value:Object):void
        {
            dataObject.mapSelection = value;
        }

        public function get startPositionPoint():Point
        {
            var obj:Object = dataObject.startPosition;
            return new Point(obj.x, obj.y);
        }

        public function set startPositionPoint(value:Point):void
        {
            dataObject.startPosition = {x:value.x, y:value.y};
        }

        public function set startPosition(value:Object):void
        {
            dataObject.startPosition = value;
        }

        public function set map(value:Object):void
        {
            dataObject.map = value;
        }

        public function get map():Object
        {
            return dataObject.map;
        }
    }
}
