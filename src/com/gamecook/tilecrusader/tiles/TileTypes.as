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
        public static const EQUIPMENT:String = "equipment";

        public static const TYPES : Object = new Object();
        public static const DARKNESS:String = "darkness";
		{
		TYPES[' '] = { name: 'Floor', sprite: "sprite0", type: PASSABLE},
        TYPES['#'] = { name: 'Wall', sprite: "sprite1", type: IMPASSABLE},
        TYPES['E'] = { name: 'Exit', sprite: "sprite2", type: EXIT},
        TYPES['T'] = { name: 'Treasure', sprite: "sprite4", type: TREASURE, classPath:"TreasureChestTile"},
        TYPES['$'] = { name: 'Gold', sprite: "sprite5", type: PICKUP, classPath:"GoldTile"},
        TYPES['P'] = { name: 'Potion', sprite: "sprite6", type: PICKUP},
        TYPES['X'] = { name: 'Blood', sprite: "sprite7", type: PASSABLE},
        TYPES['@'] = { name: 'Player', sprite: "sprite8", type: PLAYER, classPath:"PlayerTile"},
		TYPES['1'] = { name: 'Ork', sprite: "sprite9", type: MONSTER, classPath:"MonsterTile", pointPercent:"0"},
		TYPES['2'] = { name: 'Oger', sprite: "sprite10", type: MONSTER, classPath:"MonsterTile", pointPercent:".1"},
		TYPES['3'] = { name: 'Goblin', sprite: "sprite11", type: MONSTER, classPath:"MonsterTile", pointPercent:".1"},
		TYPES['4'] = { name: 'Wolfman', sprite: "sprite12", type: MONSTER, classPath:"MonsterTile", pointPercent:".3"},
		TYPES['5'] = { name: 'Vampire', sprite: "sprite13", type: MONSTER, classPath:"MonsterTile", pointPercent:".3"},
		TYPES['6'] = { name: 'Mummy', sprite: "sprite14", type: MONSTER, classPath:"MonsterTile", pointPercent:".4"},
		TYPES['7'] = { name: 'Skeleton', sprite: "sprite15", type: MONSTER, classPath:"MonsterTile", pointPercent:".4"},
		TYPES['8'] = { name: 'Imp', sprite: "sprite16", type: MONSTER, classPath:"MonsterTile", pointPercent:".6"},
		TYPES['9'] = { name: 'Gargoyle', sprite: "sprite17", type: BOSS, classPath:"MonsterTile", pointPercent:"1"},
        TYPES['A'] = { name: 'Artifact', sprite: "sprite100", type: ARTIFACT},
        TYPES['w1'] = { name: 'Spear', sprite: "sprite18", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w2'] = { name: 'Cane', sprite: "sprite19", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w3'] = { name: 'Magic Wand', sprite: "sprite20", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w4'] = { name: 'Lead Pipe', sprite: "sprite21", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w5'] = { name: 'Knuckles', sprite: "sprite22", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w6'] = { name: 'Dagger', sprite: "sprite23", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w7'] = { name: 'Foil', sprite: "sprite24", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w8'] = { name: 'Sword', sprite: "sprite25", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w9'] = { name: 'Mace', sprite: "sprite26", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w10'] = { name: 'Axe', sprite: "sprite27", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w11'] = { name: 'Croquet Mallot', sprite: "sprite28", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w12'] = { name: 'Whip', sprite: "sprite29", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w13'] = { name: 'Club', sprite: "sprite30", classPath:"WeaponTile", type: EQUIPMENT}
        TYPES['w14'] = { name: 'Stick', sprite: "sprite31", classPath:"WeaponTile", type: EQUIPMENT}
        }

        public static function registerTile(id:String, template:Object):void
        {
            TYPES[id] = template;
        }

        public static function removeTile(id:String):void
        {
            delete TYPES[id];
        }

        public static function getTileColor(tile:String):uint
        {
            if(TYPES[tile] == null)
                tile = TYPES["#"];
            return TYPES[tile].color;
        }

        public static function getTileTemplate(id:String):Object
        {
            return TYPES[id];
        }

        public static function getTileType(tile:String):String
        {
            return TYPES[tile].type;
        }

        public static function getTileSprite(tile:String):String
        {
            return TYPES[tile].sprite;
        }

        public static function isMonster(tile:String):Boolean
        {
            return (TYPES[tile].type == MONSTER);
        }

        public static function getStats(tile:String):Object
        {
            var obj:Object = TYPES[tile];
            return {hit:obj.attackRoll, defense:obj.defenseRoll};
        }

        public static function isBoss(tile:String):Boolean
        {
            return (TYPES[tile].type == BOSS);
        }

        public static function isPlayer(value:String):Boolean
        {
            return (TYPES[value].type == PLAYER);
        }

        public static function getTileName(value:String):String
        {
            return TYPES[value].name;
        }

        public static function isDarkness(value:String):Boolean
        {
            return TYPES[value] == null ? false : (TYPES[value].type == DARKNESS);
        }

        public static function getEmptyTile():String
        {
            return " ";
        }
    }
}
