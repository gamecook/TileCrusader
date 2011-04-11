/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/4/11
 * Time: 10:32 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.factory
{
	import com.gamecook.tilecrusader.combat.ICombatant;
	import com.gamecook.tilecrusader.applicators.CombatantEquipmentApplicator;
import com.gamecook.tilecrusader.equipment.IEquipable;
import com.gamecook.tilecrusader.equipment.WeaponGenerator;
	import com.gamecook.tilecrusader.equipment.weapons.IWeapon;
	import com.gamecook.tilecrusader.templates.ITemplate;
	import com.gamecook.tilecrusader.templates.ITemplateCollection;
	import com.gamecook.tilecrusader.templates.TemplateApplicator;
	import com.gamecook.tilecrusader.tiles.BaseTile;
	import com.gamecook.tilecrusader.tiles.IMonster;
	import com.gamecook.tilecrusader.tiles.PlayerTile;
	import com.gamecook.tilecrusader.tiles.TileTypes;

	public class TCTileFactory extends TileFactory
    {
        private var templates:ITemplateCollection;
        private var templateApplicator:TemplateApplicator;
        private var characterPoints:int;
        private var modifier:Number;
	    private var weaponGenerator:WeaponGenerator = new WeaponGenerator();
		private var combatantEquipmentApplicator:CombatantEquipmentApplicator = new CombatantEquipmentApplicator();

        public function TCTileFactory(templates:ITemplateCollection, templateApplicator:TemplateApplicator, characterPoints:int, modifier:Number = 0)
        {
            this.modifier = modifier;
            this.characterPoints = characterPoints;
            this.templateApplicator = templateApplicator;
            this.templates = templates;
            super();
        }


        override public function createTile(value:String):BaseTile
        {
            var tile:BaseTile = super.createTile(value);

	        //TODO: move to a combatantFactory subclass? TCTileFactory shouldn't have to worry about checking ICombatant/IMonsters/etc
            if(tile is IMonster && !(tile is PlayerTile))
            {
                var template:ITemplate = templates.getRandomTemplate();
	            var weapon:IEquipable = weaponGenerator.getWeapon(characterPoints);

                var spriteID:String = TileTypes.getTileSprite(value)+","+TileTypes.getTileSprite(weapon.tileID);

                // Create weapon and armor sprites


                trace("New Monster", spriteID);
                var points:int = (IMonster(tile).getCharacterPointPercent() + modifier) * characterPoints;
                templateApplicator.apply(tile as ICombatant, template, points);
	            IMonster(tile).equip(weapon)
                //combatantEquipmentApplicator.apply(tile as ICombatant, weapon);
	            //TODO: generate armor and apply
                tile.setName(template.getName()+" "+tile.getName());
            }

            return tile;
        }
    }
}
