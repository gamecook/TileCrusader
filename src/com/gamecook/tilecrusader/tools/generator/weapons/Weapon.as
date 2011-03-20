/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 5:53 PM
 */
package com.gamecook.tilecrusader.tools.generator.weapons
{
	public class Weapon implements IWeapon
	{
		private var _type:String;
		private var _description:String;
		private var _damage:int;

		public function get type():String
		{
			return _type;
		}

		public function get description():String
		{
			return _description;
		}

		public function get damage():int
		{
			return _damage;
		}

		public function Weapon(type:String, description:String, damage:int)
		{
			_type = type;
			_description = description;
			_damage = damage;
		}
	}
}