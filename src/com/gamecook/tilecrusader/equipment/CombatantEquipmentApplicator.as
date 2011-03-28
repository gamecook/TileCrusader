/**
 * User: John Lindquist
 * Date: 3/28/11
 * Time: 5:18 PM
 */
package com.gamecook.tilecrusader.equipment
{
	import com.gamecook.tilecrusader.combat.ICombatant;

	public class CombatantEquipmentApplicator
	{
		public function apply(combatant:ICombatant, equipment:IEquipment):void
		{
			combatant.addEquipment(equipment);
		}
	}
}