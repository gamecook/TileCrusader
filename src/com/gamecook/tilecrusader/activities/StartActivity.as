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

    import com.jessefreeman.factivity.managers.ActivityManager;

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
        public function StartActivity(activityManager:ActivityManager,data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            loadState(null);
            mapViewPortWidth = fullSizeWidth - mapViewPortX;

            super.onCreate();

            var xml:XML = <comps>
                <Label id="title" x="0" y="100" scaleX="4" scaleY="4" text="Tile Crusader"/>

                <VBox id="buttonLayout" x="50" y="150" scaleX="2" scaleY="2">
                            <PushButton id="continueButton" label="Continue Crusade" event="click:onContinue"/>
                            <PushButton id="newGameButton" label="New Crusade" event="click:onStartGame"/>
                            <PushButton id="helpButton" label="Help" event="click:onHelp"/>
                            <PushButton id="optionsButton" label="Options" event="click:onOptions"/>
                    </VBox>

                    </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            title.x = fullSizeWidth - 300;
            if(!stateSOData.activeGame)
                buttonLayout.removeChild(continueButton);
        }

        public function onStartGame(event:MouseEvent):void
        {
            //stateSO.clear();
            stateSOData.activeGame = true;
            nextActivity(ConfigureCharacterActivity);
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


        override public function loadState(obj:Object):void
        {
            //super.loadState(obj);

            stateSO = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            stateSOData = stateSO.data;
        }
    }
}
