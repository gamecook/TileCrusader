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
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.gamecook.tilecrusader.enum.BooleanOptions;
    import com.gamecook.tilecrusader.states.ActiveGameState;
    import com.gamecook.tilecrusader.utils.ArrayUtil;
    import com.gamecook.tilecrusader.views.Button;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.enum.MapSizeOptions;
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.events.MouseEvent;
    import flash.net.SharedObject;
    import flash.text.TextField;
    import flash.utils.getQualifiedClassName;

    public class RandomMapGeneratorActivity extends RandomMapBGActivity
    {
        private var settingsLayout:StackLayout;
        private var darknessOptions:Array;
        private var gameModeOptions:Array;
        private var mapSizeOptions:Array;
        public var mapSizeLabel:Label;
        public var darknessLabel:Label;
        public var showMonsters:Label;
        public var dropTreasure:Label;
        public var gameMode:Label;
        private var showMonsterOptions:Array;
        private var dropTreasureOptions:Array;
        private var mapOptionsSO:SharedObject;
        private var activeStateSO:SharedObject;
        private var activeGameState:ActiveGameState;

        public function RandomMapGeneratorActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            activeGameState = new ActiveGameState();
            loadState(null);

            super.onCreate();

            //Get Map Option Settings
            mapOptionsSO = SharedObject.getLocal(ApplicationShareObjects.MAP_OPTIONS);
            var mapOptionsSOData:Object = mapOptionsSO.data;



            trace("Has Shared Object", mapOptionsSOData);

            darknessOptions = (mapOptionsSOData.darknessOptions) ? mapOptionsSOData.darknessOptions : DarknessOptions.getValues();
            gameModeOptions = (mapOptionsSOData.gameModeOptions) ? mapOptionsSOData.gameModeOptions : GameModeOptions.getValues();
            mapSizeOptions = (mapOptionsSOData.mapSizeOptions) ? mapOptionsSOData.mapSizeOptions : MapSizeOptions.getValues();
            showMonsterOptions = (mapOptionsSOData.showMonsterOptions) ? mapOptionsSOData.showMonsterOptions : BooleanOptions.getNYOptions();
            dropTreasureOptions = (mapOptionsSOData.dropTreasureOptions) ? mapOptionsSOData.dropTreasureOptions : BooleanOptions.getNYOptions();

            var xml:XML = <comps>

                      <VBox x="20" y="20" scaleX="2" scaleY="2">
                      <Label id="mapSizeLabel"/>
                      <Label id="darknessLabel"/>
                      <Label id="showMonsters"/>
                      <Label id="dropTreasure"/>
                      <Label id="gameMode"/>

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
            activeGameState.size = generateRandomMapSize();
            activeGameState.gameType = generateRandomGameType();
            activeGameState.darkness = generateRandomDarkness();
            activeGameState.monstersDropTreasure = generateDropTreasure();
            activeGameState.showMonsters = generateRandomShowMonsters();

            mapSizeLabel.text = "Map Size: "+activeGameState.size;
            darknessLabel.text = "Darkness: "+activeGameState.darkness;
            showMonsters.text = "Show Monsters: "+activeGameState.showMonsters;
            dropTreasure.text = "Drop Treasure: "+activeGameState.monstersDropTreasure;
            gameMode.text = "Game Mode: "+activeGameState.gameType;
        }

        public function onSubmit(event:MouseEvent):void
        {
            activeGameState.lastActivity = getQualifiedClassName(MapLoadingActivity).replace("::", ".");
            saveState(null);

            nextActivity(MapLoadingActivity);
        }

        private function generateRandomDarkness():String
        {

            return ArrayUtil.pickRandomArrayElement(darknessOptions);
        }

        private function generateRandomGameType():String
        {
            return ArrayUtil.pickRandomArrayElement(gameModeOptions);
        }

        private function generateRandomMapSize():int
        {
            return ArrayUtil.pickRandomArrayElement(mapSizeOptions);
        }

        private function generateRandomShowMonsters():Boolean
        {
            return generateRandomBooleanFromString(showMonsterOptions);
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
            nextActivity(RandomMapGeneratorFilterActivity);
        }

        override public function loadState(obj:Object):void
        {
            activeGameState.load();
        }

        override public function saveState(obj:Object, activeState:Boolean = true):void
        {
            activeGameState.save();
        }

    }
}
