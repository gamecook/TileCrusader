/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 3/5/11
 * Time: 2:17 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.PushButton;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.behaviors.OptionsBehavior;
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.gamecook.tilecrusader.enum.BooleanOptions;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.enum.MapSizeOptions;
    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.events.MouseEvent;
    import flash.net.SharedObject;

    public class RandomMapGeneratorFilterActivity extends RandomMapBGActivity
    {
        public var mapSizeButton:PushButton;
        private var mapOptionIterator:OptionsBehavior;
        private const RANDOM:String = "Random";
        private var showMonstersOptionIterator:OptionsBehavior;
        public var showMonstersButton:PushButton;
        public var treasureButton:PushButton;
        private var dropTreasureOptionIterator:OptionsBehavior;
        private var darknessOptionIterator:OptionsBehavior;
        public var darknessButton:PushButton;
        public var gameModeButton:PushButton;
        private var gameOptionIterator:OptionsBehavior;
        private var mapOptionsSO:SharedObject;
        private var mapOptionsSOData:Object;

        public function RandomMapGeneratorFilterActivity(activityManager:IActivityManager, data:*)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            super.onCreate();

            var xml:XML = <comps>
                <VBox spacing="10" x="20" y="20" scaleX="2" scaleY="2">
                    <HBox spacing="10">

                        <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="map" text="mapSize:"/>
                                <PushButton id="mapSizeButton" width="100" event="click:onMapSizeChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="darkness" text="Darkness:"/>
                                <PushButton id="darknessButton" width="100" event="click:onDarknessChange"/>
                            </VBox>
                        </VBox>
                        <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="showMonsters" text="Show Monsters:"/>
                                <PushButton id="showMonstersButton" width="100"event="click:onShowMonstersChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="treasure" text="Dropped Treasure:"/>
                                <PushButton id="treasureButton" width="100" event="click:onDropTreasureChange"/>
                            </VBox>

                        </VBox>

                    </HBox>
                    <PushButton id="gameModeButton" label="This is the game mode" width="210" event="click:onGameModeChange"/>
                    <HBox spacing="10">
                        <PushButton id="resetButton" label="Cancel" event="click:onCancel"/>
                        <PushButton id="saveButton" label="Save & Close" event="click:onSave"/>
                    </HBox>
                </VBox>
            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            var startIndex:int;

            //Get Map Option Settings
            mapOptionsSO = SharedObject.getLocal(ApplicationShareObjects.MAP_OPTIONS);
            mapOptionsSOData = mapOptionsSO.data;


            // Setup Map Size behavior
            var mapSizeOptions:Array = MapSizeOptions.getValues();
            if (!mapOptionsSO.data.mapSizeOptions)
                mapOptionsSO.data.mapSizeOptions = [];
            startIndex = mapOptionsSO.data.mapSizeOptions.length == 1 ? mapSizeOptions.indexOf(mapOptionsSO.data.mapSizeOptions[0]) - 1 : mapSizeOptions.length - 1;
            mapSizeOptions.push(RANDOM);
            mapOptionIterator = new OptionsBehavior(mapSizeButton, mapSizeOptions, startIndex);
            mapOptionIterator.nextOption();

            // Setup Show Monster behavior
            var showMonsterOptions:Array = BooleanOptions.getYNOptions();
            if (!mapOptionsSO.data.showMonsterOptions)
                mapOptionsSO.data.showMonsterOptions = [];
            startIndex = mapOptionsSO.data.showMonsterOptions.length == 1 ? showMonsterOptions.indexOf(mapOptionsSO.data.showMonsterOptions[0]) - 1 : showMonsterOptions.length - 1;
            showMonsterOptions.push(RANDOM);
            showMonstersOptionIterator = new OptionsBehavior(showMonstersButton, showMonsterOptions, startIndex);
            showMonstersOptionIterator.nextOption();

            // Setup Darkness Behavior
            var darknessOptions:Array = DarknessOptions.getValues();
            if (!mapOptionsSO.data.darknessOptions)
                mapOptionsSO.data.darknessOptions = [];
            startIndex = mapOptionsSO.data.darknessOptions.length == 1 ? darknessOptions.indexOf(mapOptionsSO.data.darknessOptions[0]) - 1 : darknessOptions.length - 1;
            darknessOptions.push(RANDOM);
            darknessOptionIterator = new OptionsBehavior(darknessButton, darknessOptions, startIndex);
            darknessOptionIterator.nextOption();

            // Setup Drop Treasure
            var dropTreasureOptions:Array = BooleanOptions.getYNOptions();
            if (!mapOptionsSO.data.dropTreasureOptions)
                mapOptionsSO.data.dropTreasureOptions = [];
            startIndex = mapOptionsSO.data.dropTreasureOptions.length == 1 ? dropTreasureOptions.indexOf(mapOptionsSO.data.dropTreasureOptions[0]) - 1 : dropTreasureOptions.length - 1;
            dropTreasureOptions.push(RANDOM);
            dropTreasureOptionIterator = new OptionsBehavior(treasureButton, dropTreasureOptions, startIndex);
            dropTreasureOptionIterator.nextOption();

            // Game Mode
            var gameModeOptions:Array = GameModeOptions.getValues();
            if (!mapOptionsSO.data.gameModeOptions)
                mapOptionsSO.data.gameModeOptions = [];
            startIndex = mapOptionsSO.data.gameModeOptions.length == 1 ? gameModeOptions.indexOf(mapOptionsSO.data.gameModeOptions[0]) - 1 : gameModeOptions.length - 1;
            gameModeOptions.push(RANDOM);
            gameOptionIterator = new OptionsBehavior(gameModeButton, gameModeOptions, startIndex);
            gameOptionIterator.nextOption();

        }

        public function onMapSizeChange(event:MouseEvent):void
        {
            mapOptionIterator.nextOption();
        }

        public function onShowMonstersChange(event:MouseEvent):void
        {
            showMonstersOptionIterator.nextOption();
        }

        public function onDropTreasureChange(event:MouseEvent):void
        {
            dropTreasureOptionIterator.nextOption();
        }

        public function onDarknessChange(event:MouseEvent):void
        {
            darknessOptionIterator.nextOption();
        }

        public function onGameModeChange(event:MouseEvent):void
        {
            //TODO need to add in logic to dissable options that will not work for game mode
            gameOptionIterator.nextOption();
        }

        public function onCancel(event:MouseEvent):void
        {
            nextActivity(RandomMapGeneratorActivity, data);
        }

        public function onSave(event:MouseEvent):void
        {
            mapOptionsSOData.mapSizeOptions = (mapSizeButton.label == RANDOM) ? MapSizeOptions.getValues() : [int(mapSizeButton.label)];
            mapOptionsSOData.showMonsterOptions = (showMonstersButton.label == RANDOM) ? BooleanOptions.getYNOptions() : [showMonstersButton.label];
            mapOptionsSOData.dropTreasureOptions = (treasureButton.label == RANDOM) ? BooleanOptions.getYNOptions() : [treasureButton.label];
            mapOptionsSOData.darknessOptions = (darknessButton.label == RANDOM) ? DarknessOptions.getValues() : [darknessButton.label];
            mapOptionsSOData.gameModeOptions = (gameModeButton.label == RANDOM) ? GameModeOptions.getValues() : [gameModeButton.label];
            mapOptionsSO.flush();
            trace("Map Options SO Size:", (mapOptionsSO.size / 1,024), "k");
            nextActivity(RandomMapGeneratorActivity, data);
        }
    }
}
