/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/9/11
 * Time: 9:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.views
{
    import com.gamecook.minutequest.factory.TextFieldFactory;
    import com.gamecook.minutequest.status.IStatus;
    import com.gamecook.minutequest.tiles.PlayerTile;

    import flash.display.Bitmap;
    import flash.display.Shape;
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
        private var helpLabel:TextField;
        private var quitLabel:TextField;
        private var killLabel:TextField;
        private var classLabel:TextField;
        private var lifeBarBG:Shape;
        private var lifeBar:Shape;

        public function CharacterSheetView()
        {

        }

        private function init():void
        {
            registerUI();
        }

        private function registerUI():void
        {

            helpLabel = TextFieldFactory.createTextField(6,5,"[ Help ]");
            addChild(helpLabel);

            quitLabel = TextFieldFactory.createTextField(110,5,"[ Quit ]");
            addChild(quitLabel);

            nameLabel = TextFieldFactory.createTextField(13, 64, "BitchAss");
            addChild(nameLabel);

            classLabel = TextFieldFactory.createTextField(13, 86, "The Knight");
            classLabel.textColor = 0x999999;
            addChild(classLabel);

            lifeLabel = TextFieldFactory.createTextField(13, 200, "L");
            addChild(lifeLabel);

            lifeBarBG = new Shape();
            lifeBarBG.graphics.beginFill(0xff0000);
            lifeBarBG.graphics.drawRect(0,0, 155, 18);
            lifeBarBG.graphics.endFill();
            lifeBarBG.x = 33;
            lifeBarBG.y = 202;
            addChild(lifeBarBG);

            lifeBar = new Shape();
            lifeBar.graphics.beginFill(0x00ff00);
            lifeBar.graphics.drawRect(0,0, lifeBarBG.width, lifeBarBG.height);
            lifeBar.graphics.endFill();
            lifeBar.x = lifeBarBG.x;
            lifeBar.y = lifeBarBG.y;
            addChild(lifeBar);

            goldLabel = TextFieldFactory.createTextField(13, 225, "G: $0");
            addChild(goldLabel);

            hitLabel = TextFieldFactory.createTextField(102, 110, "H: "+player.getAttackRolls().toString());
            addChild(hitLabel);

            defenseLabel = TextFieldFactory.createTextField(102, 130, "D: "+player.getDefenceRolls().toString());
            addChild(defenseLabel);

            potionLabel = TextFieldFactory.createTextField(102, 150, "P: "+player.getPotions().toString());
            addChild(potionLabel);

            killLabel = TextFieldFactory.createTextField(102, 170, "K: "+player.getKills().toString());
            addChild(killLabel);

        }

        public function refresh():void
        {
            if(player)
            {
                goldLabel.text = "G: $"+player.getGold();
                potionLabel.text = "P: "+player.getPotions();
                killLabel.text = "K: "+player.getKills();

                lifeBar.scaleX = player.getLife()/player.getMaxLife();
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
            bitmap.x = 12;
            bitmap.y = 115;
            addChild(bitmap);
        }

    }
}
