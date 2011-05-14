/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.bit101.components.PushButton;
    import com.bit101.components.VBox;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.gamecook.tilecrusader.enum.BooleanOptions;
    import com.gamecook.tilecrusader.enum.ClassOptions;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.enum.MapSizeOptions;
    import com.gamecook.tilecrusader.factories.NewGameFactory;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.jessefreeman.factivity.activities.ActivityManager;

    import flash.events.MouseEvent;
    import flash.net.SharedObject;
    import flash.utils.getDefinitionByName;

    public class StartActivity extends RandomMapBGActivity
    {

        public var title:Label;
        public var continueButton:PushButton;
        public var buttonLayout:VBox;

        private var stateSO:SharedObject;
        private var stateSOData:Object;

        public function StartActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {

            loadState();
            mapViewPortWidth = fullSizeWidth - mapViewPortX;
            mapViewPortY = 30;

            super.onCreate();

            var xml:XML = <comps>
                <Label id="title" x="45" y="30" scaleX="2" scaleY="2" text="Tile Crusader"/>

                <VBox id="buttonLayout" x="50" y="60">
                    <PushButton id="continueButton" label="Continue Crusade" event="click:onContinue"/>
                    <PushButton id="newGameButton" label="New Crusade" event="click:onStartGame"/>
                    <PushButton id="optionsButton" label="Options" event="click:onOptions"/>
                    <PushButton id="creditsButton" label="Credits" event="click:onCredits"/>
                </VBox>

            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            //title.x = fullSizeWidth - 300;
            if (!stateSOData.activeGame)
                buttonLayout.removeChild(continueButton);
        }

        public function onStartGame(event:MouseEvent):void
        {

            //var so:SharedObject = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            //so.clear();
            //TODO show a warning that this will overwrite the current game
            //stateSOData.activeGame = true;

            nextActivity(ConfigureCharacterActivity);
            /*NewGameFactory.createCoffeeBreakGame(ClassOptions.getValues(), DarknessOptions.getValues(), GameModeOptions.getValues(), MapSizeOptions.getValues(), BooleanOptions.getTFOptions(), BooleanOptions.getTFOptions());

            nextActivity(MapLoadingActivity);*/
        }

        public function onContinue(event:MouseEvent):void
        {
            var ClassReference:Class = getDefinitionByName(stateSOData.lastActivity) as Class;
            nextActivity(ClassReference);
        }

        public function onHelp(event:MouseEvent):void
        {
            activityManager.setCurrentActivity(HelpActivity);
        }

        public function onOptions(event:MouseEvent):void
        {
            activityManager.setCurrentActivity(OptionsActivity);
        }


        override public function loadState():void
        {
            stateSO = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            stateSOData = stateSO.data;
        }

        override public function onStart():void
        {
            super.onStart();

            soundManager.playMusic(TCSoundClasses.MainTileCrusaderTheme, .5);

        }
    }
}
