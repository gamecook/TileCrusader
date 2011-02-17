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

        [Embed(source='../../../../../build/assets/nokiafc22.ttf', fontName="system", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT:String;

        private var player:PlayerTile;
        private var nameLabel:TextField;
        private var lifeLabel:TextField;
        private var hitLabel:TextField;
        private var defenseLabel:TextField;
        private var goldLabel:TextField;
        private var potionLabel:TextField;
        private var status:String;

        public function CharacterSheetView()
        {

        }

        private function init():void
        {
            registerUI();
        }

        private function registerUI():void
        {

            var tfx:TextFormat = new TextFormat("system", 16, 0xffffff);

            nameLabel = new TextField();
            nameLabel.autoSize = TextFieldAutoSize.LEFT;
            nameLabel.x = 0;
            nameLabel.y = 10;
            nameLabel.embedFonts = true;
            nameLabel.defaultTextFormat = tfx;
            nameLabel.text = "BitchAss";
            addChild(nameLabel);

            lifeLabel = new TextField();
            lifeLabel.autoSize = TextFieldAutoSize.LEFT;
            lifeLabel.defaultTextFormat = tfx;
            lifeLabel.y = 40;
            //addChild(lifeLabel);

            hitLabel = new TextField();
            hitLabel.autoSize = TextFieldAutoSize.LEFT;
            hitLabel.defaultTextFormat = tfx;
            hitLabel.embedFonts = true;
            hitLabel.x = 80;
            hitLabel.y = 40;
            hitLabel.text = "H: "+player.getAttackRolls().toString();
            addChild(hitLabel);

            defenseLabel = new TextField();
            defenseLabel.autoSize = TextFieldAutoSize.LEFT;
            defenseLabel.defaultTextFormat = tfx;
            defenseLabel.embedFonts = true;
            defenseLabel.x = 80;
            defenseLabel.y = 60;
            defenseLabel.text = "D: "+player.getDefenceRolls().toString();
            addChild(defenseLabel);

            /*goldLabel = new TextField();
            goldLabel.autoSize = TextFieldAutoSize.LEFT;
            goldLabel.defaultTextFormat = tfx;

            goldLabel.text = "Gold: "+player.getGold().toString();
            goldLabel.y = 85;
            //addChild(goldLabel);

            potionLabel = new TextField();
            potionLabel.autoSize = TextFieldAutoSize.LEFT;
            potionLabel.defaultTextFormat = tfx;
            potionLabel.y = 100;
            potionLabel.text = "Potions: "+player.getPotions().toString();
            //addChild(potionLabel);*/




        }

        public function refresh():void
        {
            if(player)
            {
                lifeLabel.text = "Life: "+player.getLife().toString() +"/"+player.getMaxLife();
                //goldLabel.text = "Gold: "+player.getGold();
                //potionLabel.text = "Potions: "+player.getPotions();
                //statusLabel.text = "Status:\n"+status;
                //clear status
                status = "";
            }
        }


        public function setPlayer(player:PlayerTile):void
        {
            this.player = player;
            init();
        }

        public function setPortrait(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 4;
            bitmap.x = 0;
            bitmap.y = 40;
            addChild(bitmap);
        }

        public function setGoldIcon(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 3;
            bitmap.x = 5;
            bitmap.y = 110;
            //addChild(bitmap);
        }

        public function setPotionIcon(bitmap:Bitmap):void
        {
            bitmap.scaleX = bitmap.scaleY = 3;
            bitmap.x = 5;
            bitmap.y = 160;
            //addChild(bitmap);
        }

    }
}
