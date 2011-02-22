/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
    import com.gamecook.lib.states.BaseState;

    import com.gamecook.lib.ui.containers.StackLayout;
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.gamecook.tilecrusader.views.AutoPlayMap;

    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class StartState extends RandomBackgroundMapState
    {

        public function StartState(data:* = null)
        {
            super(data);
        }

        override public function create():void
        {
            super.create();

            var tf:TextField = UIFactory.createTextField(0,100, "Tile Crusader");
            tf.x = fullSizeWidth - (tf.width + 50);
            addChild(tf);

            var layout:StackLayout = new StackLayout(20);
            layout.x = 50;
            layout.y = 150;

            layout.addChild(UIFactory.createTextFieldButton(onStart, 0,0, "New Crusade"));
            layout.addChild(UIFactory.createTextFieldButton(onHelp, 0,0, "Help"));
            layout.addChild(UIFactory.createTextFieldButton(onOptions, 0,0, "Options"));

            addChild(layout);

        }

        private function onStart(event:MouseEvent):void
        {
            stateManager.setState(MapLoadingState);
        }

        private function onHelp(event:MouseEvent):void
        {
            stateManager.setState(HelpState);
        }

        private function onOptions(event:MouseEvent):void
        {
            stateManager.setState(OptionsState);
        }
    }
}
