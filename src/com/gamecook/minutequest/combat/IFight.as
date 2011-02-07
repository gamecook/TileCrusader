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

    public interface IFight
    {
        function get life():int;
        function set life(value:int);

        function get maxLife():int;
        function set maxLife(value:int):void;

        function get hitValue():int;
        function set hitValue(value:int):void;

        function get defenseValue():int;
        function set defenseValue(value:int):void;
    }
}
