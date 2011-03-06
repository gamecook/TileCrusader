/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.enum.BooleanOptions;
    import com.gamecook.tilecrusader.utils.ArrayUtil;
    import com.gamecook.tilecrusader.views.Button;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.enum.MapSizeOptions;
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class RandomMapGeneratorActivity extends RandomMapBGActivity
    {
        private var settingsLayout:StackLayout;
        private var darknessTypes:Array;
        private var gameModeTypes:Array;
        private var mapSizeTypes:Array;
        public var mapSizeLabel:Label;
        public var darknessLabel:Label;
        public var showMonsters:Label;
        public var dropTreasure:Label;
        private var showMonsterTypes:Array;
        private var dropTreasureOptions:Array;

        public function RandomMapGeneratorActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            darknessTypes = (data.darknessTypes) ? data.darknessTypes : DarknessOptions.getValues();
            gameModeTypes = (data.gameTypes) ? data.gameTypes : GameModeOptions.getValues();
            mapSizeTypes = (data.mapSizes) ? data.mapSizes : MapSizeOptions.getValues();
            showMonsterTypes = (data.showMonsterTypes) ? data.showMonsterTypes : BooleanOptions.getNYOptions();
            dropTreasureOptions = (data.dropTreasureOptions) ? data.dropTreasureOptions : BooleanOptions.getNYOptions();


            var xml:XML = <comps>

                      <VBox x="20" y="20" scaleX="2" scaleY="2">
                      <Label id="mapSizeLabel"/>
                      <Label id="darknessLabel"/>
                      <Label id="showMonsters"/>
                      <Label id="dropTreasure"/>

                      <PushButton id="generateDataButton" label="New Map" event="click:generateData"/>
                      <PushButton id="submitButton" label="Play Map" event="click:onSubmit"/>
                      <PushButton label="Filter" event="click:onFilter"/>
                    </VBox>

                    </comps>

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            generateData();

        }

        public function generateData(event:MouseEvent = null):void
        {
            data.size = generateRandomMapSize();
            data.gameType = generateRandomGameType();
            data.darkness = generateRandomDarkness();
            data.monstersDropTreasure = generateDropTreasure();
            data.showMonsters = generateRandomShowMonsters();

            mapSizeLabel.text = "Map Size: "+data.size;
            darknessLabel.text = "Darkness: "+data.darkness;
            showMonsters.text = "Show Monsters: "+data.showMonsters;
            dropTreasure.text = "Drop Treasure: "+data.monstersDropTreasure;
        }

        public function onSubmit(event:MouseEvent):void
        {
            nextActivity(MapLoadingActivity, data);
        }

        private function generateRandomDarkness():String
        {

            return ArrayUtil.pickRandomArrayElement(darknessTypes);
        }

        private function generateRandomGameType():String
        {
            return ArrayUtil.pickRandomArrayElement(gameModeTypes);
        }

        private function generateRandomMapSize():int
        {
            return ArrayUtil.pickRandomArrayElement(mapSizeTypes);
        }

        private function generateRandomShowMonsters():Boolean
        {
            return generateRandomBooleanFromString(showMonsterTypes);
        }

        private function generateDropTreasure():Boolean
        {
            return generateRandomBooleanFromString(dropTreasureOptions);
        }

        private function generateRandomBooleanFromString(options:Array):Boolean
        {
            var data:String = ArrayUtil.pickRandomArrayElement(options);
            return data == BooleanOptions.YES ? true : false;
        }

        public function onFilter(event:MouseEvent):void
        {
            nextActivity(RandomMapGeneratorFilterActivity, data);
        }

    }
}
