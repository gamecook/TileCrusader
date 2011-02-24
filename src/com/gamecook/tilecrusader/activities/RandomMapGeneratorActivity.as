/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.enum.Darkness;
    import com.gamecook.tilecrusader.enum.GameModes;
    import com.gamecook.tilecrusader.enum.MapSizes;
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.ActivityManager;

    public class RandomMapGeneratorActivity extends RandomMapBGActivity
    {
        public function RandomMapGeneratorActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function init():void
        {
            super.init();


            var mapConfig:Object = {};
            mapConfig.size = generateRandomMapSize();
            mapConfig.gameType = generateRandomGameType();
            mapConfig.darkness = generateRandomDarkness();
            mapConfig.monstersDropTreature = randomBoolean();
            mapConfig.showMonsters = randomBoolean();

            var layout:StackLayout = new StackLayout();

            for ( var prop:String in mapConfig ) {
                layout.addChild(UIFactory.createTextField(0,0,  prop + ": " + mapConfig[prop] ));
            }

            addChild(layout);



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
            return value[Math.round((Math.random() * value.length))];
        }

        protected function randomBoolean():Boolean
        {
            return Math.round((Math.random() * 1)) == 0 ? false : true;
        }
    }
}
