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
		public function apply(combatant:IEquip, equipment:IEquipable):void
		{
			/*combatant.setAttackRolls(combatant.getAttackRolls() + equipment.attack);
			combatant.setDefenseRolls(combatant.getDefenseRolls() + equipment.defense);
			*/
			combatant.equip(equipment);
		}
	}
}