/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 4/11/11
 * Time: 8:01 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles {
import com.gamecook.tilecrusader.equipment.IEquipment;

public interface ISlot {
    function setWeaponSlot(value:IEquipment):void;
    function getWeaponSlot():IEquipment;

    function setHelmetSlot(value:IEquipment):void;
    function getHelmetSlot():IEquipment;

    function setArmorSlot(value:IEquipment):void;
    function getArmorSlot():IEquipment;

    function setShieldSlot(value:IEquipment):void;
    function getShieldSlot():IEquipment;

    function setShoeSlot(value:IEquipment):void;
    function getShoeSlot():IEquipment;
}
}
