/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:50 PM
 */
package com.gamecook.tilecrusader.tools.generator
{

import com.gamecook.tilecrusader.equipment.WeaponGenerator;

	import org.hamcrest.assertThat;

	public class WeaponGeneratorTest
	{
		private var weaponGenerator:WeaponGenerator;
		
		[Before]
		public function setup():void
		{
			weaponGenerator = new WeaponGenerator();
		}
		
		[Test]
		public function getWeapon_should_generate_a_valid_weapon():void
		{
			var level:int;
			var weapon:IEquipment;
			for (var i:int = 0; i < 100; i++)
			{
				level = int(Math.random() * 4);
				weapon = weaponGenerator.getWeapon(level) as IEquipment;
				assertThat(weapon);
			}
		}
	}
}