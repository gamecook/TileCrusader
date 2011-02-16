/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/9/11
 * Time: 9:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.views
{
    import com.gamecook.minutequest.status.IStatus;
    import com.gamecook.minutequest.tiles.PlayerTile;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.text.AntiAliasType;
    import flash.text.Font;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class CharacterSheetView extends Sprite
    {

        [Embed(source='../../../../../build/assets/nokiafc22.ttf', fontName="Font", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT:String;

        private var player:PlayerTile;
        private var nameLabel:TextField;
        private var characterLabel:TextField;
        private var lifeLabel:TextField;
        private var hitLabel:TextField;
        private var defenseLabel:TextField;
        private var goldLabel:TextField;
        private var potionLabel:TextField;
        private var status:String;
        private var statusLabel:TextField;

        public function CharacterSheetView()
        {
            var embeddedFonts:Array = Font.enumerateFonts(false);
            embeddedFonts.sortOn("fontName", Array.CASEINSENSITIVE);
            trace("\n\n----- Enumerate Fonts -----");
            for(var i:int = 0; i<embeddedFonts.length; i++) {
                trace(Font(embeddedFonts[i]).fontName);
            }
        }

        private function init():void
        {
        // TextFormat object
                    var format :TextFormat = new TextFormat();
                    format.font = "Font"; // Here is where the magic happens
                    format.color = 0xff0000;
                    format.size = 30;

        // TextField object
                    var txt :TextField = new TextField();
                    txt.embedFonts = true;
                    txt.autoSize = TextFieldAutoSize.LEFT;
                    txt.antiAliasType = flash.text.AntiAliasType.ADVANCED;
                    txt.defaultTextFormat = format;
                    txt.text = "Testing my embedded Calibri font";

                    addChild(txt);


            registerUI();
        }

        private function registerUI():void
        {

            var tfx:TextFormat = new TextFormat("system", 10, 0xffffff);

            nameLabel = new TextField();
            nameLabel.autoSize = TextFieldAutoSize.LEFT;

            nameLabel.y = 10;
            nameLabel.embedFonts = true;
            nameLabel.defaultTextFormat = new TextFormat("system", 10, 0xffffff);
            nameLabel.text = "Name: "+"BitchAss";
            addChild(nameLabel);

            characterLabel = new TextField();
            characterLabel.autoSize = TextFieldAutoSize.LEFT;
            characterLabel.defaultTextFormat = tfx;
            characterLabel.y = 25;
            characterLabel.text = "Character: "+"Hero"
            addChild(characterLabel);

            lifeLabel = new TextField();
            lifeLabel.autoSize = TextFieldAutoSize.LEFT;
            lifeLabel.defaultTextFormat = tfx;
            lifeLabel.y = 40;
            addChild(lifeLabel);

            hitLabel = new TextField();
            hitLabel.autoSize = TextFieldAutoSize.LEFT;
            hitLabel.defaultTextFormat = tfx;
            hitLabel.y = 55;
            hitLabel.text = "Hit: "+player.getAttackRolls().toString();
            addChild(hitLabel);

            defenseLabel = new TextField();
            defenseLabel.autoSize = TextFieldAutoSize.LEFT;
            defenseLabel.defaultTextFormat = tfx;
            defenseLabel.y = 70;
            defenseLabel.text = "Defense: "+player.getDefenceRolls().toString();
            addChild(defenseLabel);

            goldLabel = new TextField();
            goldLabel.autoSize = TextFieldAutoSize.LEFT;
            goldLabel.defaultTextFormat = tfx;
            goldLabel.y = 85;
            goldLabel.text = "Gold: "+player.getGold().toString();
            addChild(goldLabel);

            potionLabel = new TextField();
            potionLabel.autoSize = TextFieldAutoSize.LEFT;
            potionLabel.defaultTextFormat = tfx;
            potionLabel.y = 100;
            potionLabel.text = "Potions: "+player.getPotions().toString();
            addChild(potionLabel);

            statusLabel = new TextField();
            statusLabel.width = 150;
            statusLabel.height = 300;
            statusLabel.multiline = true;
            statusLabel.wordWrap = true;
            statusLabel.defaultTextFormat = tfx;
            statusLabel.y = 300;
            addChild(statusLabel);
        }

        public function refresh():void
        {
            if(player)
            {
                lifeLabel.text = "Life: "+player.getLife().toString() +"/"+player.getMaxLife();
                goldLabel.text = "Gold: "+player.getGold();
                potionLabel.text = "Potions: "+player.getPotions();
                statusLabel.text = "Status:\n"+status;
                //clear status
                status = "";
            }
        }

        public function addStatusMessage(value:String, clear:Boolean = true):void
        {
            if(clear)
                status = "";
            status += value
        }

        public function setPlayer(player:PlayerTile):void
        {
            this.player = player;
            init();
        }

        public function setPortrait(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 4;
            bitmap.x = bitmap.y = 5;
            addChild(bitmap);
        }

        public function setGoldIcon(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 2;
            bitmap.x = 5;
            bitmap.y = 90;
            addChild(bitmap);
        }

        public function setPotionIcon(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 2;
            bitmap.x = 5;
            bitmap.y = 140;
            addChild(bitmap);
        }
    }
}
