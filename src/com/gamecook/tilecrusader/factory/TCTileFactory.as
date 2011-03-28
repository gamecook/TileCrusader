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

        public function TCTileFactory(tileTypes:TileTypes, templates:ITemplateCollection, templateApplicator:TemplateApplicator, characterPoints:int, modifier:Number = 0)
        {
            this.modifier = modifier;
            this.characterPoints = characterPoints;
            this.templateApplicator = templateApplicator;
            this.templates = templates;
            super(tileTypes);
        }


        override public function createTile(value:String):BaseTile
        {
            var tile:BaseTile = super.createTile(value);

            if(tile is IMonster && !(tile is PlayerTile))
            {
                var template:ITemplate = templates.getRandomTemplate();

                var points:int = (IMonster(tile).getCharacterPointPercent() + modifier) * characterPoints;
                templateApplicator.apply(tile as ICombatant, template, points);
                tile.setName(template.getName()+" "+tile.getName());
            }

            return tile;
        }
    }
}
