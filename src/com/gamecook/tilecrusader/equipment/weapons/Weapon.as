/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 5:53 PM
 */
package com.gamecook.tilecrusader.equipment.weapons
{
	public class Weapon implements IWeapon
	{
		private var _type:String;
		private var _description:String;
		private var _damage:int;
		private var _defense:int;

		public function get type():String
		{
			return _type;
		}

		public function get description():String
		{
			return _description;
		}

		public function get attack():int
		{
			return _damage;
		}

		public function Weapon(type:String, description:String, damage:int, defense:int)
		{
			_type = type;
			_description = description;
			_damage = damage;
			_defense = defense;
		}

		public function toString():String
		{
			return "Weapon{_type=" + String(_type) + ",_description=" + String(_description) + ",_damage=" + String(_damage) + "}";
		}

		public function get defense():int
		{
			return _defense;
		}
	}
}