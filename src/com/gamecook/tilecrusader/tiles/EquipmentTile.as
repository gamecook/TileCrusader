/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 4/5/11
 * Time: 10:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles {
import com.gamecook.tilecrusader.equipment.Equipment;
import com.gamecook.tilecrusader.equipment.IEquipable;

public class EquipmentTile extends BaseTile{

        private var weapon:IEquipable;

        public function EquipmentTile()
        {
        }

        override public function parseObject(obj:Object):void
        {
            super.parseObject(obj);

            if(obj.hasOwnProperty("weapon"))
            {
                weapon = new Equipment();
                weapon.parseObject(obj.weapon);
            }

        }

        override public function toObject():Object
        {
            var obj:Object = super.toObject();
            obj.weapon = weapon.toObject();

            return obj;
        }

        public function getWeapon():IEquipable
        {
            return weapon;
        }
    }
}
