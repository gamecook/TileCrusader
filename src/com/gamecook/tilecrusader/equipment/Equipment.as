/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 5:53 PM
 */
package com.gamecook.tilecrusader.equipment
{
import com.gamecook.tilecrusader.enum.EquipmentValues;
import com.gamecook.tilecrusader.enum.SlotsEnum;

public class Equipment implements IEquipable
	{
		private var _type:String;
		private var _description:String;
		private var _damage:int;
		private var _defense:int;
        private var _tileID:String;

        public function get tileID():String
        {
            return _tileID;
        }

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

		public function Equipment()
		{

		}

		public function get defense():int
		{
			return _defense;
		}

		public function toString():String
		{
			return "Weapon{_type=" + String(_type) + ",_description=" + String(_description) + ",_damage=" + String(_damage) + ",_defense=" + String(_defense) + "}";
		}

        public function parseObject(value:Object):void
        {
            if(value.hasOwnProperty("tileID"))
                _tileID = value.tileID;

            if(value.hasOwnProperty("type"))
                _type = value.type;

            if(value.hasOwnProperty("description"))
                _description = value.description;

            if(value.hasOwnProperty("damage"))
                _damage = value.damage;

            if(value.hasOwnProperty("defense"))
                _defense = value.defense;
        }

        public function toObject():Object
        {
            return {tileID:tileID, type:type, description:description, damage:_damage, defense:defense}
        }

        public function slotID():String
        {
            return SlotsEnum.WEAPON;
        }

        public function getModifyAttribute():String
        {
            return EquipmentValues.ATTACK;
        }

        public function getValue():Number
        {
            return _damage;
        }
    }
}