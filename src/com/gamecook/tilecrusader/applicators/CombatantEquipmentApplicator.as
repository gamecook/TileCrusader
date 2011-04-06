/**
 * User: John Lindquist
 * Date: 3/28/11
 * Time: 5:18 PM
 */
package com.gamecook.tilecrusader.applicators
{
    import com.gamecook.tilecrusader.equipment.*;
	import com.gamecook.tilecrusader.combat.ICombatant;

	public class CombatantEquipmentApplicator
	{
		public function apply(combatant:ICombatant, equipment:IEquipment):void
		{
			combatant.setAttackRolls(combatant.getAttackRolls() + equipment.attack);
			combatant.setDefenseRolls(combatant.getDefenseRolls() + equipment.defense);
			
			combatant.addEquipment(equipment);
		}
	}
}