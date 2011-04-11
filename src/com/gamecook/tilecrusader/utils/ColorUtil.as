/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/24/11
 * Time: 11:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.utils
{
    public class ColorUtil
    {
        public static function returnARGB(rgb:uint, newAlpha:uint):uint
        {
            //newAlpha has to be in the 0 to 255 range
            var argb:uint = 0;
            argb += (newAlpha << 24);
            argb += (rgb);
            return argb;
        }
    }
}
