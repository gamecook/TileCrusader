/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:49 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.status
{
    public class DoubleAttackStatus implements IStatus
    {
        protected var _attackStatus:CombatResult;
        protected var _attackStatus2:CombatResult;

        public function get attackStatus():CombatResult
        {
            return _attackStatus;
        }

        public function get attackStatus2():CombatResult
        {
            return _attackStatus2;
        }

        public function DoubleAttackStatus(attackStatus:CombatResult, attackStatus2:CombatResult)
        {
            _attackStatus2 = attackStatus2;
            _attackStatus = attackStatus;
        }

        public function toString():String
        {
            var message:String = _attackStatus.toString();
            if (_attackStatus.kill) {
                message += attackStatus.defender.getName() + " was defeated.\n"
            }
            else {
                //message += attackStatus.defender.getName() +" attacks back!\n";
                message += attackStatus2.toString();
            }
            return message;
        }
    }
}
