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
    import com.gamecook.tilecrusader.enum.BooleanOptions;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.enum.MapSizeOptions;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.events.MouseEvent;

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
                                <PushButton id="resetButton" label="Reset" event="click:onReset"/>
                                <PushButton id="saveButton" label="Save & Close" event="click:onSave"/>
                            </HBox>
                    </VBox>
                    </comps>

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            var startIndex:int;

            // Setup Map Size behavior
            var mapOptions:Array = MapSizeOptions.getValues();
            startIndex = mapOptions.length - 1;
            mapOptions.push(RANDOM);
            mapOptionIterator = new OptionsBehavior(mapSizeButton, mapOptions, startIndex);
            mapOptionIterator.nextOption();

            // Setup Show Monster behavior
            var showMonsterOptions:Array = BooleanOptions.getYNOptions();
            startIndex = showMonsterOptions.length - 1;
            showMonsterOptions.push(RANDOM);
            showMonstersOptionIterator = new OptionsBehavior(showMonstersButton, showMonsterOptions, startIndex);
            showMonstersOptionIterator.nextOption();

            // Setup Darkness Behavior
            var darknessOptions:Array = DarknessOptions.getValues();
            startIndex = darknessOptions.length - 1;
            darknessOptions.push(RANDOM);
            darknessOptionIterator = new OptionsBehavior(darknessButton, darknessOptions, startIndex);
            darknessOptionIterator.nextOption();

            // Setup Drop Treasure
             var dropTreasureOptions:Array = BooleanOptions.getYNOptions();
            startIndex = dropTreasureOptions.length - 1;
            dropTreasureOptions.push(RANDOM);
            dropTreasureOptionIterator = new OptionsBehavior(treasureButton, dropTreasureOptions, startIndex);
            dropTreasureOptionIterator.nextOption();

            // Game Mode
            var gameModeOptions:Array = GameModeOptions.getValues();
            startIndex = gameModeOptions.length - 1;
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
            gameOptionIterator.nextOption();
        }

        public function onReset(event:MouseEvent):void
        {
            mapOptionIterator.reset();
            showMonstersOptionIterator.reset();
            dropTreasureOptionIterator.reset();
            darknessOptionIterator.reset();
            gameOptionIterator.reset();
        }

        public function onSave(event:MouseEvent):void
        {
            nextActivity(RandomMapGeneratorActivity, data);
        }
    }
}
