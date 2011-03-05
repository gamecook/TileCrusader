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
		TYPES['*'] = { name: 'Darkness', sprite: "sprite0", type: PASSABLE},
		TYPES[' '] = { name: 'Floor', sprite: "sprite1", type: PASSABLE},
		TYPES['?'] = { name: 'DarkFloor', sprite: "sprite2", type: PASSABLE},
		TYPES['X'] = { name: 'Blood', sprite: "sprite3", type: PASSABLE},
		TYPES['#'] = { name: 'Wall', sprite: "sprite4", type: IMPASSABLE},
		TYPES['E'] = { name: 'Exit', sprite: "sprite5", type: EXIT},
		TYPES['@'] = { name: 'Player', sprite: "sprite6", type: PLAYER, classPath:"PlayerTile"},
		TYPES['1'] = { name: 'Monster 1', sprite: "sprite7", type: MONSTER, classPath:"MonsterTile", pointPercent:"0"},
		TYPES['2'] = { name: 'Monster 2', sprite: "sprite8", type: MONSTER, classPath:"MonsterTile", pointPercent:".1"},
		TYPES['3'] = { name: 'Monster 3', sprite: "sprite9", type: MONSTER, classPath:"MonsterTile", pointPercent:".1"},
		TYPES['4'] = { name: 'Monster 4', sprite: "sprite10", type: MONSTER, classPath:"MonsterTile", pointPercent:".2"},
		TYPES['5'] = { name: 'Monster 5', sprite: "sprite11", type: MONSTER, classPath:"MonsterTile", pointPercent:".3"},
		TYPES['6'] = { name: 'Monster 6', sprite: "sprite12", type: MONSTER, classPath:"MonsterTile", pointPercent:".5"},
		TYPES['7'] = { name: 'Monster 7', sprite: "sprite13", type: MONSTER, classPath:"MonsterTile", pointPercent:".7"},
		TYPES['8'] = { name: 'Monster 8', sprite: "sprite14", type: MONSTER, classPath:"MonsterTile", pointPercent:".9"},
		TYPES['9'] = { name: 'Monster 9', sprite: "sprite15", type: BOSS, classPath:"MonsterTile", pointPercent:"1"},
        TYPES['T'] = { name: 'Treasure', sprite: "sprite16", type: TREASURE},
        TYPES['$'] = { name: 'Gold', sprite: "sprite17", type: PICKUP},
        TYPES['P'] = { name: 'Potion', sprite: "sprite18", type: PICKUP},
        TYPES['A'] = { name: 'Artifact', sprite: "sprite19", type: ARTIFACT}
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

        public function isMonster(tile:String):Boolean
        {
            return (TYPES[tile].type == MONSTER);
        }

        public function getStats(tile:String):Object
        {
            var obj:Object = TYPES[tile];
            return {hit:obj.attackRoll, defense:obj.defenseRoll};
        }

        public function isBoss(tile:String):Boolean
        {
            return (TYPES[tile].type == BOSS);
        }

        public function isPlayer(value:String):Boolean
        {
            return (TYPES[value].type == PLAYER);
        }
    }
}
