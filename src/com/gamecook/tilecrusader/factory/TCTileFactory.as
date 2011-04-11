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
    import com.gamecook.tilecrusader.enum.SlotsEnum;
    import com.gamecook.tilecrusader.equipment.Equipment;
    import com.gamecook.tilecrusader.equipment.IEquipable;
    import com.gamecook.tilecrusader.factory.EquipmentFactory;
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
        private var weaponGenerator:EquipmentFactory = new EquipmentFactory();

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
            if (tile is IMonster && !(tile is PlayerTile)) {
                var template:ITemplate = templates.getRandomTemplate();

                //TODO this is hardcoded right now, should be moved into an enum
                var weapon:IEquipable = weaponGenerator.createEquipment(characterPoints, SlotsEnum.WEAPON);
                var shield:IEquipable = weaponGenerator.createEquipment(characterPoints, SlotsEnum.SHIELD);

                var points:int = (IMonster(tile).getCharacterPointPercent() + modifier) * characterPoints;
                templateApplicator.apply(tile as ICombatant, template, points);

                IMonster(tile).equip(weapon);
                IMonster(tile).equip(shield);

                //TODO: generate armor and apply
                tile.setName(template.getName() + " " + tile.getName());
            }

            return tile;
        }
    }
}
