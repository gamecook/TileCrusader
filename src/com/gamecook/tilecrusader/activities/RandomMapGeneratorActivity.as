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
        private var settingsLayout:StackLayout;

        public function RandomMapGeneratorActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            settingsLayout = new StackLayout();

            addChild(settingsLayout);

            generateData();

            var buttonLayout:StackLayout = new StackLayout(10, StackLayout.HORIZONTAL);

            var redo:Button = UIFactory.createTextFieldButton(generateData, 0,0, "New Map");
            buttonLayout.addChild(redo);

            var submit:Button = UIFactory.createTextFieldButton(onSubmit, 0,0, "Play Map");
            buttonLayout.addChild(submit);

            buttonLayout.x = settingsLayout.x;
            buttonLayout.y = settingsLayout.y + settingsLayout.height + 30;

            addChild(buttonLayout);
        }

        private function generateData():void
        {
            data.size = generateRandomMapSize();
            data.gameType = generateRandomGameType();
            data.darkness = generateRandomDarkness();
            data.monstersDropTreasure = randomBoolean();
            data.showMonsters = randomBoolean();

            var index:int = 0;
            for ( var prop:String in data ) {
                if(settingsLayout.numChildren > index)
                {
                    var label:TextField = settingsLayout.getChildAt(index) as TextField;
                }
                else
                {
                    label = settingsLayout.addChild(UIFactory.createTextField(0,0, "" )) as TextField;
                }
                label.text =  prop + ": " + data[prop];
                index ++;
            }
        }

        private function onSubmit():void
        {
            nextActivity(MapLoadingActivity, data);
        }

        private function generateRandomDarkness():String
        {
            var types:Array = [Darkness.LONG_RANGE, Darkness.REVEAL, Darkness.TORCH];
            return pickRandomArrayElement(types);
        }

        private function generateRandomGameType():String
        {
            var types:Array = [GameModes.KILL_ALL_MONSTERS, GameModes.KILL_BOSS];/*, GameModes.FIND_ALL_TREASURE, GameModes.FIND_ARTIFACT];*/
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
            return value[randNum];
        }

        protected function randomBoolean():Boolean
        {
            return Math.round((Math.random() * 1)) == 0 ? false : true;
        }
    }
}
