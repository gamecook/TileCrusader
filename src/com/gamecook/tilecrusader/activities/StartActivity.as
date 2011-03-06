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
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class StartActivity extends RandomMapBGActivity
    {
        public var title:Label;

        public function StartActivity(activityManager:ActivityManager,data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            mapViewPortWidth = fullSizeWidth - mapViewPortX;

            super.onCreate();

            var xml:XML = <comps>
                <Label id="title" x="0" y="100" scaleX="4" scaleY="4" text="Tile Crusader"/>

                <VBox x="50" y="150" scaleX="2" scaleY="2">
                            <PushButton id="NewGame" label="New Crusade" event="click:onStartGame"/>
                            <PushButton id="Help" label="Help" event="click:onHelp"/>
                            <PushButton id="Options" label="Options" event="click:onOptions"/>
                    </VBox>

                    </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            title.x = fullSizeWidth - 300;
        }

        public function onStartGame(event:MouseEvent):void
        {
            nextActivity(ConfigureCharacterActivity);
        }

        public function onHelp(event:MouseEvent):void
        {
            activityManager.setCurrentActivity(HelpActivity);
        }

        public function onOptions(event:MouseEvent):void
        {
            activityManager.setCurrentActivity(OptionsActivity);
        }
    }
}
