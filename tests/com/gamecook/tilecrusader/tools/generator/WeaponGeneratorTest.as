/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:50 PM
 */
package com.gamecook.tilecrusader.tools.generator
{
import com.gamecook.frogue.enum.SlotsEnum;
import com.gamecook.frogue.equipment.Equipment;
import com.gamecook.frogue.equipment.IEquipable;
import com.gamecook.frogue.factories.EquipmentFactory;

	import org.hamcrest.assertThat;

	public class WeaponGeneratorTest
	{
		private var weaponGenerator:EquipmentFactory;
		
		[Before]
		public function setup():void
		{
			weaponGenerator = new EquipmentFactory();
		}
		
		[Test]
		public function getWeapon_should_generate_a_valid_weapon():void
		{
			var level:int;
			var weapon:IEquipable;
			for (var i:int = 0; i < 100; i++)
			{
				level = int(Math.random() * 4);
				weapon = weaponGenerator.createEquipment(level, SlotsEnum.WEAPON) as IEquipable;
				assertThat(weapon);
			}
		}
	}
}