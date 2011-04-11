/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:36 PM
 */
package com.gamecook.tilecrusader.factory
{
    import com.gamecook.tilecrusader.equipment.*;
    import com.gamecook.tilecrusader.tiles.TileTypes;


    public class EquipmentFactory
    {
        include "prefixes.as"
        include "suffixes.as"
        include "types.as"

        public static const WEAPON:int = 0;

        public function createEquipment(level:uint, equipmentType:int):IEquipable
        {
            //TODO: figure out how level matches length of arrays
            level = Math.min(level, includedPrefixes.length - 1);
            level = int(Math.random() * level);

            //TODO: match character level range to weapon range
            var tileID:String = createTileID(equipmentType);
            var type:String = TileTypes.getTileName(tileID);
            var description:String = createDescription(level, type);
            var modifierValue:int = createModifierValue(level);
            var modify:String = type;

            var weapon:Equipment = new Equipment();
            weapon.parseObject({tileID:tileID, type:equipmentType, description:description, modifierValue:modifierValue, modify:modify});
            return weapon;
        }

        private function createTileID(arrayName:int):String
        {
            var randomType:int = int(Math.random() * types[arrayName].length);
            return types[arrayName][randomType];
        }

        private function createDescription(level:uint, type:String):String
        {
            var description:String;
            //TODO: add small percentage chance for unique weapons
            description = createPrefix(level) + " " + type + " " + createSuffix(level);
            return description;
        }

        private function createPrefix(level:uint):String
        {
            var random:int = int(Math.random() * includedPrefixes[level].length);
            var prefix:String = includedPrefixes[level][random];

            return prefix;
        }

        private function createModifierValue(level:uint):uint
        {
            //TODO: determine damage based on level
            return int(Math.random() * level);
        }

        private function createSuffix(level:uint):String
        {
            var random:int = int(Math.random() * includedSuffixes[level].length);
            var suffix:String = includedSuffixes[level][random];
            return suffix;
        }
    }
}