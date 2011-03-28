/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/5/11
 * Time: 8:19 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.combat
{
    import com.gamecook.tilecrusader.combat.ICombatant;
    import com.gamecook.tilecrusader.status.CombatResult;
    import com.gamecook.tilecrusader.status.DoubleAttackStatus;

    public class CombatHelper
    {
        public function CombatHelper()
        {
        }

        public function doubleAttack(attackerA:ICombatant, attackerB:ICombatant):DoubleAttackStatus
        {
            //TODO find out who has attack first
            if(Math.random() >= 0.5)
            {
                var tmpInstance:ICombatant = attackerA;
                attackerA = attackerB;
                attackerB = tmpInstance;
            }

            var statusA:CombatResult = attack(attackerA, attackerB);
            var statusB:CombatResult;

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

	    //TODO: clean up by refactoring to visitor
        public function attack(attacker:ICombatant, defender:ICombatant):CombatResult
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
	        

            //TODO check for special attributes

            return new CombatResult(success, hit, difference);
        }
    }
}
