/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/20/11
 * Time: 5:26 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader
{
    import com.gamecook.frogue.tiles.TileTypes;
    import com.jessefreeman.factivity.AbstractApplication;
    import com.jessefreeman.factivity.activities.ActivityManager;
    import com.jessefreeman.factivity.analytics.ITrack;

    public class TileCrusaderGame extends AbstractApplication
    {
        public function TileCrusaderGame(tracker:ITrack, x:int, y:int, state:Class, scale:Number = 1)
        {
            super(new ActivityManager(tracker), state, x, y, scale);
            soundManager.volume = 0;
        }


        override protected function init():void
        {

            TileTypes.registerTile(' ',  { name: 'Floor1', sprite: "sprite0", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_1', { name: 'Floor2', sprite: "sprite1", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_2', { name: 'Floor3', sprite: "sprite2", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_3', { name: 'Floor4', sprite: "sprite3", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_4', { name: 'Floor5', sprite: "sprite4", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_5', { name: 'Floor6', sprite: "sprite5", type: TileTypes.PASSABLE});
            TileTypes.registerTile('_6', { name: 'Floor7', sprite: "sprite6", type: TileTypes.PASSABLE});
            TileTypes.registerTile(':', { name: 'Eyes', sprite: "sprite7", type: TileTypes.DARKNESS});

            TileTypes.registerTile('#', { name: 'Wall', sprite: "sprite8", type: TileTypes.IMPASSABLE});
            TileTypes.registerTile('E', { name: 'Exit', sprite: "sprite9", type: TileTypes.EXIT});

            TileTypes.registerTile('C1', { name: 'Bronze Coin', sprite: "sprite10"});
            TileTypes.registerTile('C2', { name: 'Silver Coin', sprite: "sprite11"});
            TileTypes.registerTile('C3', { name: 'Gold Coin', sprite: "sprite12"});

            TileTypes.registerTile('T', { nname: 'Floor8', sprite: "sprite13", type: TileTypes.TREASURE, classPath:"TreasureChestTile"});
            TileTypes.registerTile('$', { name: 'Gold', sprite: "sprite14", type: TileTypes.PICKUP, classPath:"GoldTile"});
            TileTypes.registerTile('P', { name: 'Potion', sprite: "sprite15", type: TileTypes.PICKUP});

            TileTypes.registerTile('X', { name: 'Blood 1', sprite: "sprite16", type: TileTypes.PASSABLE});
            TileTypes.registerTile('X2', { name: 'Blood 2', sprite: "sprite17", type: TileTypes.PASSABLE});
            TileTypes.registerTile('X3', { name: 'Blood 3', sprite: "sprite18", type: TileTypes.PASSABLE});

            TileTypes.registerTile('@', { name: 'Player', sprite: "sprite19", type: TileTypes.PLAYER, classPath:"PlayerTile"});
            TileTypes.registerTile('1', { name: 'Ork', sprite: "sprite20", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:"0"});
            TileTypes.registerTile('2', { name: 'Oger', sprite: "sprite21", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".1"});
            TileTypes.registerTile('3', { name: 'Goblin', sprite: "sprite22", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".1"});
            TileTypes.registerTile('4', { name: 'Wolfman', sprite: "sprite23", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".3"});
            TileTypes.registerTile('5', { name: 'Vampire', sprite: "sprite24", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".3"});
            TileTypes.registerTile('6', { name: 'Mummy', sprite: "sprite25", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".4"});
            TileTypes.registerTile('7', { name: 'Skeleton', sprite: "sprite26", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".4"});
            TileTypes.registerTile('8', { name: 'Imp', sprite: "sprite27", type: TileTypes.MONSTER, classPath:"MonsterTile", pointPercent:".6"});
            TileTypes.registerTile('9', { name: 'Gargoyle', sprite: "sprite28", type: TileTypes.BOSS, classPath:"MonsterTile", pointPercent:"1"});
            /*TileTypes.registerTile('A', { name: 'Artifact', sprite: "sprite100", type: TileTypes.ARTIFACT});*/

            /* Weapons */
            TileTypes.registerTile('W1', { name: 'Trident', sprite: "sprite29", preview:"sprite30", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W2', { name: 'Sai', sprite: "sprite31", preview:"sprite32", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W3', { name: 'Compound Bow', sprite: "sprite33", preview:"sprite34", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W4', { name: 'Long Bow', sprite: "sprite35", preview:"sprite36", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W5', { name: 'Bow', sprite: "sprite37", preview:"sprite38", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W6', { name: 'Wide Sword', sprite: "sprite39", preview:"sprite40", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W7', { name: 'Crop', sprite: "sprite41", preview:"sprite42", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W8', { name: 'Flogger', sprite: "sprite43", preview:"sprite44", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W9', { name: 'Small Knife', sprite: "sprite45", preview:"sprite46", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W10', { name: 'Throwing Axe', sprite: "sprite47", preview:"sprite48", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W11', { name: 'Hammer', sprite: "sprite49", preview:"sprite50", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W12', { name: 'Curved Sword', sprite: "sprite51", preview:"sprite52", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W13', { name: 'Xena Sword', sprite: "sprite53", preview:"sprite54", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W14', { name: 'Spear', sprite: "sprite55", preview:"sprite56", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W15', { name: 'cane', sprite: "sprite57", preview:"sprite58", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W16', { name: 'Magic Wand', sprite: "sprite59", preview:"sprite60", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W17', { name: 'Lead Pipe', sprite: "sprite61", preview:"sprite62", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W18', { name: 'Knuckles', sprite: "sprite63", preview:"sprite64", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W19', { name: 'Dagger', sprite: "sprite65", preview:"sprite66", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W20', { name: 'Foil', sprite: "sprite67", preview:"sprite68", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W21', { name: 'Sword', sprite: "sprite69", preview:"sprite70", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W22', { name: 'Mace', sprite: "sprite71", preview:"sprite72", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W23', { name: 'Axe', sprite: "sprite73", preview:"sprite74", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W24', { name: 'Croquet Mallot', sprite: "sprite75", preview:"sprite76", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W25', { name: 'Whip', sprite: "sprite77", preview:"sprite78", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W26', { name: 'Club', sprite: "sprite79", preview:"sprite80", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});
            TileTypes.registerTile('W27', { name: 'Stick', sprite: "sprite81", preview:"sprite82", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyAttack"});

            /* Shield */
            TileTypes.registerTile('S1', { name: 'Oval Shield', sprite: "sprite83", preview:"sprite84", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S2', { name: 'Warrior Shield', sprite: "sprite85", preview:"sprite86", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S3', { name: 'Round X Shield', sprite: "sprite87", preview:"sprite88", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S4', { name: 'American Shield', sprite: "sprite89", preview:"sprite90", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S5', { name: 'Long Shield', sprite: "sprite91", preview:"sprite92", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S6', { name: 'Scaloped Shield', sprite: "sprite93", preview:"sprite94", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('S7', { name: 'Round Shield', sprite: "sprite95", preview:"sprite96", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});

            /* Helmet */
            TileTypes.registerTile('H1', { name: 'Baseball Hat', sprite: "sprite97", preview:"sprite98", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H2', { name: 'Secret Mask', sprite: "sprite99", preview:"sprite100", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H3', { name: 'Storm Trooper Helmet', sprite: "sprite101", preview:"sprite102", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H4', { name: 'Gimp Mask', sprite: "sprite103", preview:"sprite104", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H5', { name: 'Bucket Helmet', sprite: "sprite105", preview:"sprite106", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H6', { name: 'Open Helmet', sprite: "sprite107", preview:"sprite108", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H7', { name: 'Fuller', sprite: "sprite109", preview:"sprite110", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H8', { name: 'Short Helmet', sprite: "sprite111", preview:"sprite112", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H9', { name: 'Full Helmet', sprite: "sprite113", preview:"sprite114", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('H10', { name: 'Roman Helmet', sprite: "sprite115", preview:"sprite116", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});

            /* Armor */
            TileTypes.registerTile('A1', { name: 'Full Armor', sprite: "sprite117", preview:"sprite118", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A2', { name: 'Metal Bikini', sprite: "sprite119", preview:"sprite120", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A3', { name: 'Chain Shorts', sprite: "sprite121", preview:"sprite122", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A4', { name: 'Light Chainmail', sprite: "sprite123", preview:"sprite124", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A5', { name: 'Chainmail', sprite: "sprite125", preview:"sprite126", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A6', { name: 'T shirt', sprite: "sprite127", preview:"sprite128", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A7', { name: 'Chest Armor', sprite: "sprite129", preview:"sprite130", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A8', { name: 'Brown Robe', sprite: "sprite131", preview:"sprite132", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A9', { name: 'Blue Robe', sprite: "sprite133", preview:"sprite134", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('A10', { name: 'Red Robe', sprite: "sprite135", preview:"sprite136", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            
            /* Boots */
            TileTypes.registerTile('B1', { name: 'Pointy Boots', sprite: "sprite137", preview:"sprite138", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('B2', { name: 'Square Boots', sprite: "sprite139", preview:"sprite140", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});
            TileTypes.registerTile('B3', { name: 'Simple Boots', sprite: "sprite141", preview:"sprite142", classPath:"EquipmentTile", type: TileTypes.EQUIPMENT, modifyValue: 1 , modifyAttribute: "modifyDefense"});

            super.init();
        }
    }
}
