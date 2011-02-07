/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{
    import com.gamecook.minutequest.combat.IFight;

    public class MonsterTile extends BaseTile implements IFight
    {
        private var _life:int;
        private var _maxLife:int;
        private var _hitValue:int;
        private var _defenseValue:int;

        public function MonsterTile()
        {
        }

        public function get life():int
        {
            return _life;
        }

        public function set life(value:int)
        {
            _life = value;
        }

        public function get maxLife():int
        {
            return _maxLife;
        }

        public function set maxLife(value:int):void
        {
            _maxLife = value;
        }

        public function get hitValue():int
        {
            return _hitValue;
        }

        public function set hitValue(value:int):void
        {
            _hitValue = value;
        }

        public function get defenseValue():int
        {
            return _defenseValue;
        }

        public function set defenseValue(value:int):void
        {
            _defenseValue = value;
        }
    }
}
