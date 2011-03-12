/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 11:16 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles
{
    import flash.geom.Point;

    public interface ITile
    {
        function getName():String;
        function get id():String;
        function get type():String;

    }
}
