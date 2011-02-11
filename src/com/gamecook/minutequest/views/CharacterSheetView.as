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

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class CharacterSheetView extends Sprite
    {
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

        }

        private function init():void
        {
            registerUI();
        }

        private function registerUI():void
        {
            var tfx:TextFormat = new TextFormat(null, 10, 0xffffff);

            nameLabel = new TextField();
            nameLabel.autoSize = TextFieldAutoSize.LEFT;
            nameLabel.defaultTextFormat = tfx;
            nameLabel.y = 10;
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
    }
}
