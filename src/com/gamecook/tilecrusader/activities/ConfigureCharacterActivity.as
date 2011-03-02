/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.InputText;
    import com.bit101.components.Label;
    import com.bit101.components.NumericStepper;
    import com.bit101.utils.MinimalConfigurator;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    public class ConfigureCharacterActivity extends RandomMapBGActivity
    {
        private const DEFAULT_POINTS:int = 15;

        [Embed(source="../../../../../build/assets/spritesheet_template.png")]
        public static var SpriteSheetImage:Class;

        protected var characterPoints:int = DEFAULT_POINTS;
        public var pointTotal:Label;
        public var lifeNumStepper:NumericStepper;
        public var hitNumStepper:NumericStepper;
        public var defNumStepper:NumericStepper;
        public var potionsNumStepper:NumericStepper;
        public var title:Label;
        public var nameInput:InputText;
        private var defaultTotalTextColor:uint;
        private var spriteSheet:SpriteSheet;

        public function ConfigureCharacterActivity(activityManager:ActivityManager, data:* = null)
        {
            if(!data) data = {};
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            mapViewPortWidth = fullSizeWidth - mapViewPortX;
            mapViewPortY = fullSizeHeight - mapViewPortHeight - 40
            super.onCreate();

            parseSpriteSheet();
        }

        private function parseSpriteSheet():void
        {
            spriteSheet = SingletonManager.getClassReference(SpriteSheet);
            spriteSheet.clear();

            // create sprite sheet
            var bitmap:Bitmap = new SpriteSheetImage();
            spriteSheet.bitmapData = bitmap.bitmapData;
            spriteSheet.registerSprite("splashScreen", new Rectangle(0, 0, 800, 480));

            var i:int;
            var rows:int = Math.floor(bitmap.height / 20);
            var total:int = Math.floor((bitmap.width - 800) / 20) * (bitmap.height / 20);
            var spriteRect:Rectangle = new Rectangle(800, 0, 20, 20);
            for (i = 0; i < total; ++i)
            {
                spriteSheet.registerSprite("sprite" + i, spriteRect.clone());
                spriteRect.y += 20;
                if (i % rows == (rows - 1))
                {
                    spriteRect.x += 20;
                    spriteRect.y = 0;
                }
            }
        }

        override public function onStart():void
        {
            super.onStart();

            var xml:XML = <comps>
                <Label id="title" x="0" y="100" scaleX="4" scaleY="4" text="Create Character"/>

                <HBox x="150" y="80" scaleX="2" scaleY="2" spacing="10">
                    <VBox>
                        <VBox spacing="10">
                        <VBox spacing="-5">
                            <Label id="name" text="Name:"/>
                            <InputText id="nameInput" width="75" text="Not Sure"event="focusIn:onNameFocus"/>
                        </VBox>
                        <!--<VBox spacing="-5">
                            <Label id="race" text="Race:"/>
                            <PushButton id="raceButton" label="Knight" event="click:onPickRace"/>
                        </VBox>
                                </VBox>
                        <VBox spacing="-5">
                            <Label id="attribute" text="Special Attribute:"/>
                            <PushButton id="attributeButton" label="First Attack" event="click:onPickAttribute"/> -->
                        </VBox>
                    </VBox>
                    <VBox spacing="20">
                        <Label id="pointTotal" width="400" align="center" text="Character Points"/>

                        <HBox spacing="40">
                        <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="life" text="Life:"/>
                                <NumericStepper id="lifeNumStepper" minimum="1" maximum="20"event="change:onPointChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="hit" text="Attack:"/>
                                <NumericStepper id="hitNumStepper" minimum="1" maximum="9"event="change:onPointChange"/>
                            </VBox>
                        </VBox>
                        <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="def" text="Defense:"/>
                                <NumericStepper id="defNumStepper" minimum="1" maximum="9"event="change:onPointChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="potions" text="Potions:"/>
                                <NumericStepper id="potionsNumStepper" minimum="1" maximum="20"event="change:onPointChange"/>
                            </VBox>

                        </VBox>

                    </HBox>
                        <HBox>
                            <PushButton label="Go Back" event="click:onBack"/>
                            <PushButton label="I Like It" event="click:onDone"/>
                            </HBox>
                    </VBox>
                </HBox>


            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            title.x = fullSizeWidth - 380;
            title.y = mapViewPortY - 50;

            defaultTotalTextColor = pointTotal.textField.textColor;

            calculatePoints();
            updateTotalLabel();
        }

        private function updateTotalLabel():void
        {
            pointTotal.text = "Character Points: " + characterPoints +" out of "+DEFAULT_POINTS;
            if(characterPoints < 0)
                pointTotal.textField.textColor = 0xFF0000;
            else
                pointTotal.textField.textColor = defaultTotalTextColor;
        }

        public function onNameFocus(event:FocusEvent):void
        {
            trace("Has Focus");

        }

        private function calculatePoints():void
        {
            characterPoints = DEFAULT_POINTS;
            characterPoints -= Number(lifeNumStepper.value);
            characterPoints -= Number(hitNumStepper.value);
            characterPoints -= Number(defNumStepper.value);
            characterPoints -= Number(potionsNumStepper.value);


        }

        public function onChangeRace(event:MouseEvent):void
        {
            trace("Pick a race");

        }

        public function onChangeAttribute(event:MouseEvent):void
        {
            trace("Pick an attribute");
        }

        public function onPointChange(event:Event):void
        {
            calculatePoints();

            if(characterPoints < 0)
            {
                event.target.value --;
                characterPoints = 0;
            }

            updateTotalLabel();
        }

        public function onBack(event:MouseEvent):void
        {
            nextActivity(StartActivity);
        }

        public function  onDone(event:MouseEvent):void
        {
            data.player = {name:nameInput.text,
                            maxLife: lifeNumStepper.value,
                            attackRoll: hitNumStepper.value,
                            defenseRoll: defNumStepper.value,
                            maxPotions: potionsNumStepper.value,
                            points:characterPoints};

            nextActivity(RandomMapGeneratorActivity, data);
        }

    }
}
