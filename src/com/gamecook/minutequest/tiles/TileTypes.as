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
        private static const TYPES : Object = new Object();
		{
		TYPES[' '] = { name: 'Floor', color: 0xffffff, impassable:false},
		TYPES['#'] = { name: 'Wall', color: 0x000000, impassable: true},
		TYPES['@'] = { name: 'Player', color: 0xff0000, impassable: true, classPath:"com.gamecook.minutequest.tiles.PlayerTile"},
		TYPES['G'] = { name: 'Goblin', color: 0x009124, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['O'] = { name: 'Orc', color: 0x014512, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['F'] = { name: 'Fimir', color: 0x669175, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['C'] = { name: 'Chaos Warrior', color: 0x7D7D7D, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['S'] = { name: 'Skeleton', color: 0xE8E5C1, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['Z'] = { name: 'Zombies', color: 0xF0E548, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['M'] = { name: 'Mummies', color: 0x736B00, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['L'] = { name: 'Gargoyle', color: 0x9193B5, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"},
		TYPES['W'] = { name: 'Chaos Warlock', color: 0xB51616, impassable: true, classPath:"com.gamecook.minutequest.tiles.MonsterTile"}
		TYPES['T'] = { name: 'Treasure', color: 0x333333, impassable: false}
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

    }
}
