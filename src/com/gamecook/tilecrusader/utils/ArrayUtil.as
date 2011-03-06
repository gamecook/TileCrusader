/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/4/11
 * Time: 1:52 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.utils
{
    public class ArrayUtil
    {
        public static function pickRandomArrayElement(value:Array):*
        {
            //trace("Picking from ",value.length, "elements:", value)
            return value[Math.floor((Math.random() * value.length))];
        }
    }
}
