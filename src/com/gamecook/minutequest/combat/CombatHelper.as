/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:19 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.combat
{
    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.status.AttackStatus;
    import com.gamecook.minutequest.status.DoubleAttackStatus;

    public class CombatHelper
    {
        public function CombatHelper()
        {
        }

        public function doubleAttack(attackerA:IFight, attackerB:IFight):DoubleAttackStatus
        {
            var statusA:AttackStatus = attack(attackerA, attackerB);
            var statusB:AttackStatus;
            if(!statusA.kill)
            {
                statusB = attack(attackerB, attackerA);
            }
            else
            {
                // Monster Was Killed
            }

            return new DoubleAttackStatus(statusA, statusB);

        }

        public function attack(attacker:IFight, defender:IFight):AttackStatus
        {
            var hit:int = attacker.getHitValue();
            var defense:int = defender.getDefenseValue();
            var difference:int;
            var success:Boolean;

            var kill:Boolean;

            if(hit > defense)
            {
                success = true;
                difference = hit - defense;
                defender.subtractLife(difference);
                if(defender.getLife() == 0)
                {
                    kill = true;
                }
            }

            return new AttackStatus(attacker, defender, success, hit, defense, difference, kill);
        }
    }
}
