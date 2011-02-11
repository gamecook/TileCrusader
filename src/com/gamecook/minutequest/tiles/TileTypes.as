/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:11 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{

    public class TileTypes
    {
        public static const PASSABLE:String = "passable";
        public static const IMPASSABLE:String = "impassable";
        public static const EXIT:String = "exit";
        public static const PLAYER:String = "player";
        public static const MONSTER:String = "monster";
        public static const TREASURE:String = "treasure";
        public static const ARTIFACT:String = "artifact";
        public static const PICKUP:String = "pickup";
        public static const BOSS:String = "boss";

        private static const TYPES : Object = new Object();
		{
		TYPES[' '] = { name: 'Floor', color: 0xffffff, type: PASSABLE},
		TYPES['X'] = { name: 'Blood', color: 0xff0000, type: PASSABLE},
		TYPES['#'] = { name: 'Wall', color: 0x000000, type: IMPASSABLE},
		TYPES['E'] = { name: 'Exit', color: 0x39BF17, type: EXIT},
		TYPES['@'] = { name: 'Player', color: 0x00ff00, type: PLAYER, classPath:"PlayerTile"},
		TYPES['1'] = { name: 'Monster 1', life: 1, maxLife:1, attackRoll: 2, defenseRoll: 1, color: 0x009124, type: MONSTER, classPath:"MonsterTile"},
		TYPES['2'] = { name: 'Monster 2', life: 2, maxLife:2, attackRoll: 3, defenseRoll: 2, color: 0x014512, type: MONSTER, classPath:"MonsterTile"},
		TYPES['3'] = { name: 'Monster 3', life: 3, maxLife:3, attackRoll: 3, defenseRoll: 3, color: 0x669175, type: MONSTER, classPath:"MonsterTile"},
		TYPES['4'] = { name: 'Monster 4', life: 3, maxLife:3, attackRoll: 3, defenseRoll: 4, color: 0x7D7D7D, type: MONSTER, classPath:"MonsterTile"},
		TYPES['5'] = { name: 'Monster 5', life: 1, maxLife:1, attackRoll: 2, defenseRoll: 2, color: 0xE8E5C1, type: MONSTER, classPath:"MonsterTile"},
		TYPES['6'] = { name: 'Monster 6', life: 1, maxLife:1, attackRoll: 2, defenseRoll: 3, color: 0xF0E548, type: MONSTER, classPath:"MonsterTile"},
		TYPES['7'] = { name: 'Monster 7', life: 1, maxLife:1, attackRoll: 3, defenseRoll: 4, color: 0x736B00, type: MONSTER, classPath:"MonsterTile"},
		TYPES['8'] = { name: 'Monster 8', life: 4, maxLife:4, attackRoll: 4, defenseRoll: 4, color: 0x9193B5, type: MONSTER, classPath:"MonsterTile"},
		TYPES['9'] = { name: 'Monster 9', life: 6, maxLife:6, attackRoll: 4, defenseRoll: 4, color: 0x9193B5, type: BOSS, classPath:"MonsterTile"},
		TYPES['A'] = { name: 'Artifact', color: 0x333333, type: ARTIFACT},
		TYPES['T'] = { name: 'Treasure', color: 0x333333, type: TREASURE},
        TYPES['$'] = { name: 'Gold', color: 0xffff00, type: PICKUP},
        TYPES['P'] = { name: 'Potion', color: 0x1100ee, type: PICKUP}
		}

        public static function registerTile(id:String, template:Object):void
        {
            TYPES[id] = template;
        }

        public static function removeTile(id:String):void
        {
            delete TYPES[id];
        }

        public function getTileColor(tile:String):uint
        {
            if(TYPES[tile] == null)
                tile = TYPES["#"];
            return TYPES[tile].color;
        }

        public function getTileTemplate(id:String):Object
        {
            return TYPES[id];
        }

        public function getTileType(tile:String):String
        {
            return TYPES[tile].type;
        }
    }
}
