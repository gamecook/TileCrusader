/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/22/11
 * Time: 3:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.enum
{
    public class PlayerClassTemplates
    {
        private static const CLASS_TEMPLATES:Object = new Object();
        {
            CLASS_TEMPLATES[ClassOptions.KNIGHT] = {life:10, attackRoll:3, defense:2, potions:5, visibility:5};
            CLASS_TEMPLATES[ClassOptions.MAGE] = {life:5, attackRoll:2, defense:1, potions:12, visibility:5};
            CLASS_TEMPLATES[ClassOptions.THIEF] = {life:7, attackRoll:2, defense:1, potions:10, visibility:5};
            CLASS_TEMPLATES[ClassOptions.NECROMANCER] = {life:13, attackRoll:3, defense:2, potions:2, visibility:5};
            CLASS_TEMPLATES[ClassOptions.BARBARIAN] = {life:10, attackRoll:5, defense:3, potions:2, visibility:5};
            CLASS_TEMPLATES[ClassOptions.DARK_MAGE] = {life:5, attackRoll:4, defense:1, potions:10, visibility:5};
        }

        public static function getTemplate(value:String):Object
        {
            return CLASS_TEMPLATES[value];
        }
    }
}
