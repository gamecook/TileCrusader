/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/9/11
 * Time: 9:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.gamecook.tilecrusader.tiles.PlayerTile;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class CharacterSheetView extends Sprite
    {

        private var player:PlayerTile;
        private var nameLabel:TextField;
        private var lifeLabel:TextField;
        private var hitLabel:TextField;
        private var defenseLabel:TextField;
        private var goldLabel:TextField;
        private var potionLabel:TextField;
        private var quitLabel:Button;
        private var killLabel:TextField;
        private var classLabel:TextField;
        private var lifeBarBG:Shape;
        private var lifeBar:Shape;
        private var portraitBitmap:Bitmap;

        //TODO maybe have this extend Activity and run it in to the game loop for update
        public function CharacterSheetView()
        {
            init();
        }

        private function init():void
        {
            registerUI();
        }

        private function registerUI():void
        {

            portraitBitmap = new Bitmap();
            portraitBitmap.scaleX = portraitBitmap.scaleY = 4;
            portraitBitmap.x = 12;
            portraitBitmap.y = 115;
            addChild(portraitBitmap);

            quitLabel = UIFactory.createTextFieldButton(onQuitClick, 110,5,"Quit");
            addChild(quitLabel);

            nameLabel = UIFactory.createTextField(13, 64, "BitchAss");
            addChild(nameLabel);

            classLabel = UIFactory.createTextField(13, 86, "The Knight");
            classLabel.textColor = 0x999999;
            addChild(classLabel);

            lifeLabel = UIFactory.createTextField(13, 200, "L");
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

            goldLabel = UIFactory.createTextField(13, 225, "G: $0");
            addChild(goldLabel);

            hitLabel = UIFactory.createTextField(102, 110, "H: 0");
            addChild(hitLabel);

            defenseLabel = UIFactory.createTextField(102, 130, "D: 0");
            addChild(defenseLabel);

            potionLabel = UIFactory.createTextField(102, 150, "P: 0");
            addChild(potionLabel);

            killLabel = UIFactory.createTextField(102, 170, "K: 0");
            addChild(killLabel);

        }

        private function onQuitClick():void
        {
            // TODO Need a way to quit here.
        }

        private function onHelpClick(event:MouseEvent):void
        {
            trace("Open Help.");
        }

        public function refresh():void
        {
            if(player)
            {
                goldLabel.text = "G: $"+player.getGold();
                potionLabel.text = "P: "+player.getPotions();
                killLabel.text = "K: "+player.getKills();
                lifeBar.scaleX = player.getLife()/player.getMaxLife();
                hitLabel.text = "H: "+player.getAttackRolls().toString();
                defenseLabel.text = "D: "+player.getDefenceRolls().toString();
                potionLabel.text = "P: "+player.getPotions().toString();
            }
        }

        public function setPlayer(player:PlayerTile):void
        {
            this.player = player;
        }

        public function setPortrait(bitmap:BitmapData):void
        {
            portraitBitmap.bitmapData = bitmap;
        }


    }
}
