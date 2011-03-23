/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/18/11
 * Time: 3:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
    public interface IStateObject
    {
        function load():void;

        function save():String;

        function clear():void;
    }
}
