/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/14/11
 * Time: 10:20 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.bit101.components.PushButton;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.tilecrusader.behaviors.OptionsBehavior;
    import com.gamecook.tilecrusader.utils.ArrayUtil;
    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.display.Bitmap;
    import flash.events.MouseEvent;

    public class GenerateCharacterActivity extends RandomMapBGActivity
    {
        private var character:Bitmap;
        private var generator:CharacterGenerator;
        private var bodyOptionBehavior:OptionsBehavior;
        private var faceOptionBehavior:OptionsBehavior;
        private var outfitOptionBehavior:OptionsBehavior;
        public var bodyButton:PushButton;
        public var faceButton:PushButton;
        public var outfitButton:PushButton;
        public var title:Label;

        public function GenerateCharacterActivity(activityManager:IActivityManager, data:*)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            mapViewPortX = 490;
            mapViewPortWidth = 200;
            mapViewPortY = 100;
            mapViewPortHeight = fullSizeHeight - 40;

            super.onCreate();

            generator = new CharacterGenerator();

            character = new Bitmap();
            character.scaleX = character.scaleY = 6;
            addChild(character);

            onUpdateCharacter();
        }


        override public function onStart():void
        {
            super.onStart();

            var xml:XML = <comps>
                <Label id="title" x="40" y="40" scaleX="4" scaleY="4" text="Customize Character's Appearance"/>

                <VBox id="layout" spacing="10" x="40" y="120" scaleX="2" scaleY="2">

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
                            <PushButton id="outfitButton" label="Outfit 1" event="click:onChangeOutfit"/>
                        </VBox>

                    </VBox>
                    <PushButton id="accept" label="I Like It" width="210" event="click:onDone"/>
                    <HBox spacing="10">
                        <PushButton id="cancel" label="Cancel" event="click:onBack"/>
                        <PushButton id="randomize" label="Randomize" event="click:onRandomize"/>
                    </HBox>
                </VBox>

            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            bodyOptionBehavior = new OptionsBehavior(bodyButton, generator.getBodySpriteNames());
            onChangeBody();

            faceOptionBehavior = new OptionsBehavior(faceButton, generator.getFaceSpriteNames());
            onChangeFace();

            outfitOptionBehavior = new OptionsBehavior(outfitButton, generator.getOutfitSpriteNames());
            onChangeOutfit();

            character.x = 260;
            character.y = 150;
        }

        public function onChangeOutfit(event:MouseEvent = null):void
        {
            var spriteName:String = outfitOptionBehavior.nextOption();

            outfitButton.label = spriteName;
            generator.changeOutfit(spriteName);
            onUpdateCharacter();
        }

        public function onChangeFace(event:MouseEvent = null):void
        {
            var spriteName:String = faceOptionBehavior.nextOption();

            faceButton.label = spriteName;
            generator.changeFace(spriteName);
            onUpdateCharacter();
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

        public function onBack(event:MouseEvent):void
        {
            nextActivity(ConfigureCharacterActivity);
        }

        public function onDone(event:MouseEvent):void
        {
            //TODO need to add in support to save out current customization.
        }

        public function onRandomize(event:MouseEvent):void
        {
            generator.changeBody(ArrayUtil.pickRandomArrayElement(generator.getBodySpriteNames()));
            generator.changeFace(ArrayUtil.pickRandomArrayElement(generator.getFaceSpriteNames()));
            generator.changeOutfit(ArrayUtil.pickRandomArrayElement(generator.getOutfitSpriteNames()));

            onUpdateCharacter();
        }
    }
}
