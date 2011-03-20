/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:36 PM
 */
package com.gamecook.tilecrusader.tools.generator
{
	import com.gamecook.tilecrusader.tools.generator.weapons.IWeapon;
	import com.gamecook.tilecrusader.tools.generator.weapons.Weapon;

	public class WeaponGenerator
	{
		include "weapons/prefixes.as"
		include "weapons/suffixes.as"
		
		public function getWeapon(level:uint):IWeapon
		{
			//TODO: match character level range to weapon range
			var type:String = createType();
			var description:String = createDescription(level, type);
			var damage:int = createDamage(level);
			
			var weapon:Weapon = new Weapon(type, description, damage);
			
			
			return weapon;
		}

		private function createType():String
		{
			//TODO: Anything other than Swords?
			return "Sword";
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
			return level;
		}

		private function createSuffix(level:uint):String
		{
			var random:int = int(Math.random() * includedSuffixes[level].length);
			var suffix:String = includedSuffixes[level][random];
			return suffix;
		}
	}
}