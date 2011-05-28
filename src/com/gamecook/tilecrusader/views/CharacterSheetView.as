/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 5/15/11
 * Time: 8:29 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import com.bit101.components.HBox;
    import com.bit101.components.VBox;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.frogue.tiles.PlayerTile;

    import com.gamecook.frogue.tiles.TileTypes;
    import com.gamecook.tilecrusader.factories.TextFieldFactory;

    import com.jessefreeman.factivity.managers.SingletonManager;

    import flash.display.Bitmap;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.text.TextField;

    import spark.primitives.Graphic;

    public class CharacterSheetView extends Sprite
    {
        private var playerTile:PlayerTile;
        private var container:Sprite;
        private var levelText:TextField;
        private var attackText:TextField;
        private var defenseText:TextField;
        private var potionsText:TextField;
        private var goldText:TextField;
        private var weaponBox:Sprite;
        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);
        private var weaponBoxBitmap:Bitmap;
        private var armorBox:Sprite;
        private var armorBoxBitmap:Bitmap;
        private var equipmentBoxMatrix:Matrix;

        public function CharacterSheetView(playerTile:PlayerTile)
        {
            this.playerTile = playerTile;
            init()
        }

        protected function init():void
        {

            container = addChild(new Sprite()) as Sprite;
            var playerClass:TextField = TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, playerTile.getClass());
            container.addChild(playerClass);

            var playerName:TextField = TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsLarge, playerTile.getName());
            playerName.y = playerClass.y + playerClass.height -5;

            playerClass.x = (playerName.width - playerClass.width) * .5;

            container.addChild(playerName);

            var statsLineOneContainer:Sprite = addChild(new Sprite()) as Sprite;
            statsLineOneContainer.y = playerName.y + playerName.height;

            levelText = statsLineOneContainer.addChild(TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, "L: 00")) as TextField;
            attackText = statsLineOneContainer.addChild(TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, "A: 00")) as TextField;
            attackText.x = levelText.x + levelText.width + 2;
            defenseText = statsLineOneContainer.addChild(TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, "D: 00")) as TextField;
            defenseText.x = attackText.x + attackText.width + 2;

            var statsLineTwoContainer:Sprite = addChild(new Sprite()) as Sprite;
            statsLineTwoContainer.y = statsLineOneContainer.y + statsLineOneContainer.height;

            potionsText = statsLineTwoContainer.addChild(TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, "L: 00")) as TextField;
            goldText = statsLineTwoContainer.addChild(TextFieldFactory.createTextField(TextFieldFactory.textFormatStatsSmall, "A: 00")) as TextField;
            goldText.x = potionsText.x + potionsText.width + 2;

            weaponBox = addChild(new Sprite()) as Sprite;
            weaponBox.y = statsLineTwoContainer.y + statsLineOneContainer.height + 2;
            weaponBox.buttonMode = true;
            weaponBox.useHandCursor = true;

            weaponBoxBitmap = weaponBox.addChild(new Bitmap()) as Bitmap;

            armorBox = addChild(new Sprite()) as Sprite;
            armorBox.x = 36 + 5;
            armorBox.y = weaponBox.y;
            armorBox.buttonMode = true;
            armorBox.useHandCursor = true;

            armorBoxBitmap = armorBox.addChild(new Bitmap()) as Bitmap;

        }

        private function createInventoryBackgroundSprites(backgroundColor:uint):Bitmap
        {
            var shape:Shape = new Shape();
            var graphics:Graphics = shape.graphics;
            graphics.lineStyle(4,0xffffff);
            graphics.beginFill(backgroundColor);
            graphics.drawRect(0,0,36,36);
            graphics.endFill();

            var bitmap:Bitmap = new Bitmap(new BitmapData(36,36,0));
            bitmap.bitmapData.draw(shape);

            var colorTransform:ColorTransform = new ColorTransform(1,1,1,.3);
            equipmentBoxMatrix = new Matrix();
            equipmentBoxMatrix.translate(2,2);

            var player:BitmapData = spriteSheet.getSprite(TileTypes.getTileSprite("@"));
            bitmap.bitmapData.draw(player, equipmentBoxMatrix, colorTransform);

            return bitmap;

        }

        public function update():void
        {
            levelText.text = TextFieldFactory.pad("L: 00", playerTile.getLife().toString());
            attackText.text = TextFieldFactory.pad("A: 00", playerTile.getAttackRolls().toString());
            defenseText.text = TextFieldFactory.pad("D: 00", playerTile.getDefenseRolls().toString());
            potionsText.text = TextFieldFactory.pad("P: 00", playerTile.getPotions().toString());
            goldText.text = TextFieldFactory.pad("G: 000000", playerTile.getGold().toString());

            updateWeaponBox();
            updateArmorBox();

        }

        private function updateArmorBox():void
        {
            var bitmap:Bitmap = createInventoryBackgroundSprites(0x85acbb);

            if (playerTile.getShoeSlot())
                bitmap.bitmapData.draw(spriteSheet.getSprite(TileTypes.getTileSprite(playerTile.getShoeSlot().tileID)), equipmentBoxMatrix);

            if (playerTile.getArmorSlot())
                bitmap.bitmapData.draw(spriteSheet.getSprite(TileTypes.getTileSprite(playerTile.getArmorSlot().tileID)), equipmentBoxMatrix);

            if (playerTile.getHelmetSlot())
                bitmap.bitmapData.draw(spriteSheet.getSprite(TileTypes.getTileSprite(playerTile.getHelmetSlot().tileID)), equipmentBoxMatrix);

            if (playerTile.getShieldSlot())
                bitmap.bitmapData.draw(spriteSheet.getSprite(TileTypes.getTileSprite(playerTile.getShieldSlot().tileID)), equipmentBoxMatrix);

            armorBoxBitmap.bitmapData = bitmap.bitmapData.clone();
        }

        private function updateWeaponBox():void
        {
            var bitmap:Bitmap = createInventoryBackgroundSprites(0xe2a5a5);

            if(playerTile.getWeaponSlot())
            {
                bitmap.bitmapData.draw(spriteSheet.getSprite(TileTypes.getTileSprite(playerTile.getWeaponSlot().tileID)), equipmentBoxMatrix);
            }
            weaponBoxBitmap.bitmapData = bitmap.bitmapData.clone();
        }
    }
}
