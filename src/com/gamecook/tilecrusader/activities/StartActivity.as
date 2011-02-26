/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.gamecook.tilecrusader.views.AutoPlayMap;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class StartActivity extends RandomMapBGActivity
    {

        public function StartActivity(activityManager:ActivityManager,data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            super.onCreate();

            var tf:TextField = UIFactory.createTextField(0,100, "Tile Crusader");
            tf.x = fullSizeWidth - (tf.width + 50);
            addChild(tf);

            var layout:StackLayout = new StackLayout(20);
            layout.x = 50;
            layout.y = 150;

            layout.addChild(UIFactory.createTextFieldButton(onStartGame, 0,0, "New Crusade"));
            layout.addChild(UIFactory.createTextFieldButton(onHelp, 0,0, "Help"));
            layout.addChild(UIFactory.createTextFieldButton(onOptions, 0,0, "Options"));

            addChild(layout);

        }

        private function onStartGame(event:MouseEvent):void
        {
            //nextActivity(MapLoadingActivity);
            nextActivity(RandomMapGeneratorActivity);
        }

        private function onHelp(event:MouseEvent):void
        {
            stateManager.setCurrentActivity(HelpActivity);
        }

        private function onOptions(event:MouseEvent):void
        {
            stateManager.setCurrentActivity(OptionsActivity);
        }
    }
}
