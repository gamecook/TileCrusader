/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:36 PM
 */
package com.gamecook.tilecrusader.equipment
{
	import com.gamecook.tilecrusader.equipment.weapons.IWeapon;
	import com.gamecook.tilecrusader.equipment.weapons.Weapon;

	public class WeaponGenerator
	{
		include "weapons/prefixes.as"
		include "weapons/suffixes.as"
		include "weapons/types.as"
		
		public function getWeapon(level:uint):IWeapon
		{
			//TODO: figure out how level matches length of arrays
			level = Math.min(level, includedPrefixes.length - 1);
			level = int(Math.random() * level);
			
			//TODO: match character level range to weapon range
			var type:String = createType();
			var description:String = createDescription(level, type);
			var damage:int = createDamage(level);
			var defense:int = createDefense(level);
			
			var weapon:Weapon = new Weapon(type, description, damage, defense);
			
			return weapon;
		}

		private function createDefense(level:int):int
		{
			
			return int(Math.random() * level);
		}

		private function createType():String
		{
			var randomType:int = int(Math.random() * types.length);
			return types[randomType];
		}

		private function createDescription(level:uint, type:String):String
		{
			var description:String;
			//TODO: add small percentage chance for unique weapons
			description = createPrefix(level) + " " + type + " " + createSuffix(level);
			return description;
		}

		private function createPrefix(level:uint):String
		{
			var random:int = int(Math.random() * includedPrefixes[level].length);
			var prefix:String = includedPrefixes[level][random];
			
			return prefix;
		}

		private function createDamage(level:uint):uint
		{
			//TODO: determine damage based on level
			return int(Math.random() * level);
		}

		private function createSuffix(level:uint):String
		{
			var random:int = int(Math.random() * includedSuffixes[level].length);
			var suffix:String = includedSuffixes[level][random];
			return suffix;
		}
	}
}