/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/14/11
 * Time: 10:20 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities {
    import com.bit101.components.PushButton;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.behaviors.OptionsBehavior;
    import com.gamecook.tilecrusader.tools.generator.CharacterGenerator;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.display.Bitmap;
    import flash.events.MouseEvent;

    public class GenerateCharacterActivity extends BaseActivity{
        private var character:Bitmap;
        private var generator:CharacterGenerator;
        private var bodyButton:PushButton;
        private var bodyOptionBehavior:OptionsBehavior;

        public function GenerateCharacterActivity(activityManager:IActivityManager, data:*)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            generator = new CharacterGenerator();

            character = new Bitmap();
            character.scaleX = character.scaleY = 3;
            addChild(character);

            onUpdateCharacter();
        }


        override public function onStart():void
        {
            super.onStart();

            var xml:XML = <comps>
                <Label id="title" x="20" y="40" scaleX="4" scaleY="4" text="Customize Character's Appearance"/>

                <VBox id="layout" spacing="10" x="150" y="80" scaleX="2" scaleY="2">
                        <VBox spacing="10">
                              <VBox spacing="-5">
                            <Label text="Body:"/>
                            <PushButton id="bodyButton" label="Body 1" event="click:onChangeBody"/>
                        </VBox>
                        <VBox spacing="-5">
                            <Label text="Face:"/>
                            <PushButton id="faceButton" label="Face 1" event="click:onChangeFace"/>
                        </VBox>
                        <VBox spacing="-5">
                            <Label text="Outfit:"/>
                            <PushButton id="classButton" label="Outfit 1" event="click:onChangeOutfit"/>
                        </VBox>

                    </VBox>
                        <HBox spacing="10">
                            <PushButton id="cancel" label="Cancel" event="click:onBack"/>
                            <PushButton id="accept" label="Accept" event="click:onDone"/>
                        </HBox>
                    </VBox>

            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            bodyOptionBehavior = new OptionsBehavior(bodyButton, generator.getBodySpriteNames());
            onChangeBody();
        }

        public function onChangeBody(event:MouseEvent = null):void
        {
            var spriteName:String = bodyOptionBehavior.nextOption();

            bodyButton.label = spriteName;
            generator.changeBody(spriteName);
            onUpdateCharacter();
        }

        protected function onUpdateCharacter():void
        {
            character.bitmapData = generator.generateBitmapData();
        }

        public function onCancel(event:MouseEvent):void
        {
            nextActivity(ConfigureCharacterActivity);
        }

        public function onDone(event:MouseEvent):void
        {
            //TODO need to add in support to save out current customization.
        }
    }
}
