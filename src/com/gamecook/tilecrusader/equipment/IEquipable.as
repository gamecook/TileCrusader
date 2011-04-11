/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 4/5/11
 * Time: 6:07 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.equipment
{
    import com.gamecook.tilecrusader.serialize.ISerializeToObject;

    public interface IEquipable extends ISerializeToObject
    {
        function get tileID():String;

        function slotID():String;

        function getModifyAttribute():String;

        function getValue():Number;

        function get description():String;
    }
}
