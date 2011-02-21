/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:11 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles
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
		TYPES['*'] = { name: 'Darkness', sprite: "sprite0", color: 0x000000, type: PASSABLE},
		TYPES[' '] = { name: 'Floor', sprite: "sprite1", color: 0xffffff, type: PASSABLE},
		TYPES['X'] = { name: 'Blood', sprite: "sprite2", color: 0xff0000, type: PASSABLE},
		TYPES['#'] = { name: 'Wall', sprite: "sprite3", color: 0x666666, type: IMPASSABLE},
		TYPES['E'] = { name: 'Exit', sprite: "sprite4", color: 0x39BF17, type: EXIT},
		TYPES['@'] = { name: 'Player', sprite: "sprite5", color: 0x00ff00, type: PLAYER, classPath:"PlayerTile"},
		TYPES['1'] = { name: 'Monster 1', sprite: "sprite6", life: 1, maxLife:1, attackRoll: 2, defenseRoll: 1, color: 0x009124, type: MONSTER, classPath:"MonsterTile"},
		TYPES['2'] = { name: 'Monster 2', sprite: "sprite7", life: 2, maxLife:2, attackRoll: 3, defenseRoll: 2, color: 0x014512, type: MONSTER, classPath:"MonsterTile"},
		TYPES['3'] = { name: 'Monster 3', sprite: "sprite8", life: 3, maxLife:3, attackRoll: 3, defenseRoll: 3, color: 0x669175, type: MONSTER, classPath:"MonsterTile"},
		TYPES['4'] = { name: 'Monster 4', sprite: "sprite9", life: 3, maxLife:3, attackRoll: 3, defenseRoll: 4, color: 0x7D7D7D, type: MONSTER, classPath:"MonsterTile"},
		TYPES['5'] = { name: 'Monster 5', sprite: "sprite10", life: 1, maxLife:1, attackRoll: 2, defenseRoll: 2, color: 0xE8E5C1, type: MONSTER, classPath:"MonsterTile"},
		TYPES['6'] = { name: 'Monster 6', sprite: "sprite11", life: 1, maxLife:1, attackRoll: 2, defenseRoll: 3, color: 0xF0E548, type: MONSTER, classPath:"MonsterTile"},
		TYPES['7'] = { name: 'Monster 7', sprite: "sprite12", life: 1, maxLife:1, attackRoll: 3, defenseRoll: 4, color: 0x736B00, type: MONSTER, classPath:"MonsterTile"},
		TYPES['8'] = { name: 'Monster 8', sprite: "sprite13", life: 4, maxLife:4, attackRoll: 4, defenseRoll: 4, color: 0x9193B5, type: MONSTER, classPath:"MonsterTile"},
		TYPES['9'] = { name: 'Monster 9', sprite: "sprite14", life: 6, maxLife:6, attackRoll: 4, defenseRoll: 4, color: 0x9193B5, type: BOSS, classPath:"MonsterTile"},
        TYPES['T'] = { name: 'Treasure', sprite: "sprite15", color: 0x333333, type: TREASURE},
        TYPES['$'] = { name: 'Gold', sprite: "sprite16", color: 0xffff00, type: PICKUP},
        TYPES['P'] = { name: 'Potion', sprite: "sprite17", color: 0x1100ee, type: PICKUP},
        TYPES['A'] = { name: 'Artifact', sprite: "sprite18", color: 0x333333, type: ARTIFACT}

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

        public function getTileSprite(tile:String):String
        {
            return TYPES[tile].sprite;
        }
    }
}
