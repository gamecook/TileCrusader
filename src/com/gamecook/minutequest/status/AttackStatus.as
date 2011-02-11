/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:36 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.status
{
    import com.gamecook.minutequest.combat.*;
    public class AttackStatus
    {
        protected var _attacker:IFight;
        protected var _defender:IFight;
        protected var _success:Boolean;
        protected var _hit:int;
        protected var _defense:int;
        protected var _difference:int;
        protected var _kill:Boolean;

        public function AttackStatus(attacker:IFight, defender:IFight, success:Boolean, hit:int, defense:int, difference:int, kill:Boolean)
        {
            _kill = kill;
            _difference = difference;
            _defense = defense;
            _hit = hit;
            _success = success;
            _defender = defender;
            _attacker = attacker;
        }


        public function get attacker():IFight
        {
            return _attacker;
        }

        public function get defender():IFight
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
            var message:String = "Attack was "+success ? "successful" : "not successful"+"!\n";

            message = attacker.getName()+" rolled "+hit+" point"+((hit != 1) ? "s" : "")+" of damage against "+defender.getName() +"\n";

            return message;
        }
    }
}
