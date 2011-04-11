/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:36 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.status
{
    import com.gamecook.tilecrusader.combat.ICombatant;

    public class CombatResult
    {
        protected var _attacker:ICombatant;
        protected var _defender:ICombatant;
        protected var _success:Boolean;
        protected var _hit:int;
        protected var _defense:int;
        protected var _difference:int;
        protected var _kill:Boolean;

        public function CombatResult(success:Boolean, hit:int, difference:int)
        {
            _kill = kill;
            _difference = difference;
            _defense = defense;
            _hit = hit;
            _success = success;
            _defender = defender;
            _attacker = attacker;
        }


        public function get attacker():ICombatant
        {
            return _attacker;
        }

        public function get defender():ICombatant
        {
            return _defender;
        }

        public function get success():Boolean
        {
            return _success;
        }

        public function get hit():int
        {
            return _hit;
        }

        public function get defense():int
        {
            return _defense;
        }

        public function get difference():int
        {
            return _difference;
        }

        public function get kill():Boolean
        {
            return _kill;
        }

        public function toString():String
        {
            var message:String = "Attack was " + success ? "successful" : "not successful" + "!\n";

            message = attacker.getName() + " rolled " + hit + " point" + ((hit != 1) ? "s" : "") + " of damage against " + defender.getName() + "\n";

            return message;
        }
    }
}
