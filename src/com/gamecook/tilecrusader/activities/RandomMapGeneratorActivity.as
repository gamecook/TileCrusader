/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.tilecrusader.views.Button;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.enum.Darkness;
    import com.gamecook.tilecrusader.enum.GameModes;
    import com.gamecook.tilecrusader.enum.MapSizes;
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.text.TextField;

    public class RandomMapGeneratorActivity extends RandomMapBGActivity
    {
        private var mapConfig:Object;
        private var settingsLayout:StackLayout;

        public function RandomMapGeneratorActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();


            mapConfig = {};

            settingsLayout = new StackLayout();

            addChild(settingsLayout);

            generateMapConfig();

            var buttonLayout:StackLayout = new StackLayout(10, StackLayout.HORIZONTAL);

            var redo:Button = UIFactory.createTextFieldButton(generateMapConfig, 0,0, "New Map");
            buttonLayout.addChild(redo);

            var submit:Button = UIFactory.createTextFieldButton(onSubmit, 0,0, "Play Map");
            buttonLayout.addChild(submit);

            buttonLayout.x = settingsLayout.x;
            buttonLayout.y = settingsLayout.y + settingsLayout.height + 30;

            addChild(buttonLayout);
        }

        private function generateMapConfig():void
        {
            mapConfig.size = generateRandomMapSize();
            mapConfig.gameType = generateRandomGameType();
            mapConfig.darkness = generateRandomDarkness();
            mapConfig.monstersDropTreature = randomBoolean();
            mapConfig.showMonsters = randomBoolean();

            var index:int = 0;
            for ( var prop:String in mapConfig ) {
                if(settingsLayout.numChildren > index)
                {
                    var label:TextField = settingsLayout.getChildAt(index) as TextField;

                }
                else
                {
                    label = settingsLayout.addChild(UIFactory.createTextField(0,0, "" )) as TextField;
                }
                label.text =  prop + ": " + mapConfig[prop];
                index ++;
            }
        }

        private function onSubmit():void
        {
            nextActivity(MapLoadingActivity, mapConfig);
        }

        private function generateRandomDarkness():String
        {
            var types:Array = [Darkness.NONE, Darkness.REVEAL, Darkness.TORCH];
            return pickRandomArrayElement(types);
        }

        private function generateRandomGameType():String
        {
            var types:Array = [GameModes.FIND_ALL_TREASURE, GameModes.FIND_ARTIFACT, GameModes.KILL_ALL_MONSTERS, GameModes.KILL_BOSS];
            return pickRandomArrayElement(types);
        }

        private function generateRandomMapSize():int
        {
            var sizes:Array = [MapSizes.SMALL, MapSizes.MEDIUM, MapSizes.LARGE];
            return pickRandomArrayElement(sizes);
        }

        protected function pickRandomArrayElement(value:Array):*
        {
            var randNum:Number = Math.floor((Math.random() * value.length));
            trace("Random Number", randNum, value.length, value);
            return value[randNum];
        }

        protected function randomBoolean():Boolean
        {
            return Math.round((Math.random() * 1)) == 0 ? false : true;
        }
    }
}
