/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 8:11 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{
    import com.gamecook.minutequest.tiles.*;
    public class TileTypes
    {
        private static const TYPES : Object = new Object();
		{
		TYPES[' '] = { name: 'Floor', color: 0xffffff, type: "passable"},
		TYPES['X'] = { name: 'Blood', color: 0xff0000, type: "passable"},
		TYPES['#'] = { name: 'Wall', color: 0x000000, type: "impassable"},
		TYPES['@'] = { name: 'Player', color: 0x00ff00, type:"monster", classPath:"com.gamecook.minutequest.tiles.PlayerTile"},
		TYPES['G'] = { name: 'Goblin', life: 1, maxLife:1, attackRoll: 2, defenseRoll: 1, color: 0x009124, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['O'] = { name: 'Orc',  life: 2, maxLife:2, attackRoll: 3, defenseRoll: 2, color: 0x014512, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['F'] = { name: 'Fimir',  life: 3, maxLife:3, attackRoll: 3, defenseRoll: 3, color: 0x669175, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['C'] = { name: 'Chaos Warrior',  life: 3, maxLife:3, attackRoll: 3, defenseRoll: 4, color: 0x7D7D7D, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['S'] = { name: 'Skeleton',  life: 1, maxLife:1, attackRoll: 2, defenseRoll: 2, color: 0xE8E5C1, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['Z'] = { name: 'Zombies',  life: 1, maxLife:1, attackRoll: 2, defenseRoll: 3, color: 0xF0E548, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['M'] = { name: 'Mummies',  life: 1, maxLife:1, attackRoll: 3, defenseRoll: 4, color: 0x736B00, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['L'] = { name: 'Gargoyle',  life: 4, maxLife:4, attackRoll: 4, defenseRoll: 4, color: 0x9193B5, type:"monster", classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['A'] = { name: 'Artifact', color: 0x333333, type: "artifact"},
		TYPES['T'] = { name: 'Treasure', color: 0x333333, type: "treasure"},
        TYPES['$'] = { name: 'Gold', color: 0xffff00, type: "pickup"},
        TYPES['P'] = { name: 'Potion', color: 0x1100ee, type: "pickup"}
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

        public function isPassable(id:String):Boolean
        {
            return TYPES[id].type == "passable";
        }

        public function isMonster(id:String):Boolean
        {
            return TYPES[id].type == "monster";
        }

        public function isTreasure(tile:String):Boolean
        {
            return TYPES[tile].type == "treasure";
        }

        public function isPickupable(tile:String):Boolean
        {
            return TYPES[tile].type == "pickup";
        }
    }
}
