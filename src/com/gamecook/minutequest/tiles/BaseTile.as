/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 10:53 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{

    import flash.geom.Point;

    public class BaseTile implements ITile
    {
        private var _name:String;
        private var _type:String;
        private var _id:int;

        public function BaseTile()
        {
        }

        public function get name():String
        {
            return _name;
        }

        public function set name(value:String):void
        {
            _name = value;
        }

        public function get type():String
        {
            return _type;
        }

        public function set type(value:String):void
        {
            _type = value;
        }

        public function get id():int
        {
            return _id;
        }

        public function set id(value:int):void
        {
            _id = value;
        }

    }
}
