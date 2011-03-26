/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/26/11
 * Time: 2:42 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.utils {
    import flash.utils.getQualifiedClassName;

    public class ClassUtil {
        public static function classToString(value:Class):String
        {
            return getQualifiedClassName(value).replace("::", ".");
        }
    }
}
