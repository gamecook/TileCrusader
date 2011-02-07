/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:49 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.combat
{
    public class DoubleAttackStatus
    {
        protected var _attackStatus:AttackStatus;
        protected var _attackStatus2:AttackStatus;

        public function get attackStatus():AttackStatus
        {
            return _attackStatus;
        }

        public function get attackStatus2():AttackStatus
        {
            return _attackStatus2;
        }

        public function DoubleAttackStatus(attackStatus:AttackStatus, attackStatus2:AttackStatus)
        {
            _attackStatus2 = attackStatus2;
            _attackStatus = attackStatus;
        }
    }
}
