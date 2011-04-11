/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/9/11
 * Time: 9:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views
{
import com.gamecook.tilecrusader.activities.StartActivity;
import com.gamecook.tilecrusader.factory.UIFactory;
import com.gamecook.tilecrusader.managers.PopUpManager;
import com.gamecook.tilecrusader.tiles.PlayerTile;
import com.gamecook.tilecrusader.views.popups.QuitPopUpWindow;
import com.jessefreeman.factivity.activities.BaseActivity;
import com.jessefreeman.factivity.managers.IActivityManager;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.text.TextField;

public class CharacterSheetView extends BaseActivity
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
        private var onQuitCallback:Function;

        //TODO maybe have this extend Activity and run it in to the game loop for update
        public function CharacterSheetView(stateManager:IActivityManager, data:* = null, onQuitCallback:Function = null)
        {
            this.onQuitCallback = onQuitCallback;
            super(stateManager, data);
        }


        override protected function onCreate():void
        {
            player = data.player;
            super.onCreate();
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

            nameLabel = UIFactory.createTextField(13, 64, player.getName());
            addChild(nameLabel);

            //TODO need to connect this up
            classLabel = UIFactory.createTextField(13, 86, "The Knight");
            classLabel.textColor = 0x999999;
            addChild(classLabel);

            goldLabel = UIFactory.createTextField(13, 225, "G: $0");
            addChild(goldLabel);

/*
            hitLabel = UIFactory.createTextField(102, 110, "H: 0");
            addChild(hitLabel);

            defenseLabel = UIFactory.createTextField(102, 130, "D: 0");
            addChild(defenseLabel);
*/

            potionLabel = UIFactory.createTextField(102, 150, "P: 0");
            addChild(potionLabel);

            killLabel = UIFactory.createTextField(102, 170, "K: 0");
            addChild(killLabel);

        }

        private function onQuitClick():void
        {
            // TODO Need a way to quit here.
            PopUpManager.showOverlay(new QuitPopUpWindow(onQuit));
        }

        private function onQuit():void
        {
            if(onQuitCallback)
                onQuitCallback();
            nextActivity(StartActivity);
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
                //lifeBar.scaleX = player.getLife()/player.getMaxLife();
                //hitLabel.text = "H: "+player.getAttackRolls().toString();
                //defenseLabel.text = "D: "+player.getDefenceRolls().toString();
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
