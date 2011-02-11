/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.combat
{
    import com.gamecook.minutequest.items.BaseArmor;
    import com.gamecook.minutequest.items.BaseWeapon;
    import com.gamecook.minutequest.tiles.ITile;

    public interface IFight extends ITile
    {

        function getLife():int;

        function subtractLife(value:int):void;

        function addLife(value:int):void;

        function getHitValue():int;

        function getDefenseValue():int;

        function getMaxLife():int;
    }
}
