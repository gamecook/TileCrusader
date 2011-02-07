/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{
    public class PlayerTile extends MonsterTile
    {
        protected var weapon:String;
        protected var armor:String;

        public function PlayerTile()
        {
        }

        public function setWeapon(value:String):void
        {
            weapon = value;
        }

        public function getWeapon(value:String):String
        {
            return weapon;
        }

        public function setArmor(value:String):void
        {
            armor = value;
        }

        public function getArmor():String
        {
            return armor;
        }

        override public function parseObject(obj:Object):void
        {
            super.parseObject(obj);

            if(obj.hasOwnProperty("weapon"))
                weapon = obj.weapon;
            if(obj.hasOwnProperty("armor"))
                armor = obj.armor;
        }
    }
}
