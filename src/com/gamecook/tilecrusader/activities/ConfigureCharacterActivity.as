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
import com.bit101.components.PushButton;
import com.bit101.components.VBox;
import com.bit101.utils.MinimalConfigurator;
import com.gamecook.frogue.sprites.SpriteSheet;
import com.gamecook.tilecrusader.behaviors.OptionsBehavior;
import com.gamecook.tilecrusader.enum.ClassOptions;
import com.gamecook.tilecrusader.enum.PlayerClassTemplates;
import com.gamecook.tilecrusader.managers.SingletonManager;
import com.gamecook.tilecrusader.states.ActiveGameState;
import com.gamecook.tilecrusader.states.CustomTemplateState;
import com.jessefreeman.factivity.managers.ActivityManager;

import flash.display.Bitmap;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

public class ConfigureCharacterActivity extends RandomMapBGActivity
    {
        private const DEFAULT_POINTS:int = 20;

        [Embed(source="../../../../../build/assets/spritesheet_template.png")]
        public static var SpriteSheetImage:Class;

        protected var characterPoints:int = DEFAULT_POINTS;
        public var pointTotal:Label;
        public var lifeNumStepper:NumericStepper;
        public var hitNumStepper:NumericStepper;
        public var defNumStepper:NumericStepper;
        public var potionsNumStepper:NumericStepper;
        public var nameInput:InputText;
        private var defaultTotalTextColor:uint;
        private var spriteSheet:SpriteSheet;
        public var classButton:PushButton;
        //private var classTemplates:Array;
        public var layout:VBox;
        private var defaultName:String;
        private var classOptionIterator:OptionsBehavior;
        public var classLabel:Label;
        private var activeGameState:ActiveGameState;
        private var customTemplateState:CustomTemplateState;

        public function ConfigureCharacterActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            activeGameState = new ActiveGameState();
            customTemplateState = new CustomTemplateState();

            loadState(null);
            mapViewPortX = 20;
            mapViewPortWidth = fullSizeWidth - 480;
            mapViewPortY = 100;
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
                <Label id="title" x="20" y="40" scaleX="4" scaleY="4" text="Create Character"/>

                <VBox id="layout" spacing="10" x="150" y="80" scaleX="2" scaleY="2">
                        <HBox spacing="10">
                              <VBox spacing="-5">
                            <Label id="name" text="Name:"/>
                            <InputText id="nameInput" width="100" height="20" text="Not Sure" event="focusIn:onNameFocus"/>

                        </VBox>
                                <VBox spacing="-5">
                            <Label id="classLabel" text="Class:"/>
                            <PushButton id="classButton" label="Knight" event="click:onChangeClass"/>
                        </VBox>
                                </HBox>
                        <HBox spacing="20">
                            <Label id="pointTotal" width="140" align="center" text="Character Points:\n 100 of 100"/>
                            <PushButton id="customPic" label="Customize Look" event="click:onCustomLook"/>
                        </HBox>
                        <HBox spacing="10">

                            <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="life" text="Life:"/>
                                <NumericStepper id="lifeNumStepper" minimum="1" maximum="99" value="8" width="100" event="change:onPointChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="hit" text="Attack:"/>
                                <NumericStepper id="hitNumStepper" minimum="1" maximum="99" value="4" width="100" event="change:onPointChange"/>
                            </VBox>
                        </VBox>
                        <VBox spacing="10">
                            <VBox spacing="-5">
                                <Label id="def" text="Defense:"/>
                                <NumericStepper id="defNumStepper" minimum="1" maximum="99"  value="2" width="100"event="change:onPointChange"/>
                            </VBox>
                            <VBox spacing="-5">
                                <Label id="potions" text="Potions:"/>
                                <NumericStepper id="potionsNumStepper" minimum="1" maximum="99" width="100" event="change:onPointChange"/>
                            </VBox>

                        </VBox>

                    </HBox>
                        <PushButton id="accept" label="I Like It" width="210" event="click:onDone"/>
                        <HBox spacing="10">
                            <PushButton id="cancel" label="Cancel" event="click:onBack"/>
                            <PushButton id="saveButton" label="Save As Default" event="click:onSave"/>
                        </HBox>
                    </VBox>

            </comps>;

            var config:MinimalConfigurator = new MinimalConfigurator(this);
            config.parseXML(xml);

            defaultName = nameInput.text;
            defaultTotalTextColor = pointTotal.textField.textColor;

            //classIterator = new OptionsIterator();

            classOptionIterator = new OptionsBehavior(classButton, ClassOptions.getValues());
            layout.x = fullSizeWidth - 450;

            if(customTemplateState.customTemplate)
            {
                applyTemplate(customTemplateState.customTemplate);
                classButton.label = customTemplateState.className;
                nameInput.text = customTemplateState.name;
                classLabel.text = "Class(Custom):";

                var index:int = ClassOptions.getValues().indexOf(customTemplateState.className);
                classOptionIterator.setIndex(index);

            }
            else
            {
                onChangeClass();
            }
            calculatePoints();
            updateTotalLabel();

        }

        private function updateTotalLabel():void
        {
            pointTotal.text = "Character Points:\n" + characterPoints +" out of "+DEFAULT_POINTS;
            if(characterPoints < 0)
                pointTotal.textField.textColor = 0xFF0000;
            else
                pointTotal.textField.textColor = defaultTotalTextColor;

            updateRandomMapPlayer();
        }

        public function onNameFocus(event:FocusEvent):void
        {
            var input:TextField = event.target as TextField;
            input.addEventListener(FocusEvent.FOCUS_OUT, onNameFocusOut);
            if(input.text == defaultName)
                input.text = "";
        }

        private function onNameFocusOut(event:FocusEvent):void
        {
           var target:TextField = event.target as TextField;
           target.removeEventListener(FocusEvent.FOCUS_OUT, onNameFocusOut);
            if(target.text == "")
                target.text = defaultName;
        }

        private function calculatePoints():void
        {
            characterPoints = DEFAULT_POINTS;
            characterPoints -= Number(lifeNumStepper.value);
            characterPoints -= Number(hitNumStepper.value);
            characterPoints -= Number(defNumStepper.value);
            characterPoints -= Number(potionsNumStepper.value);
        }

        public function onChangeClass(event:MouseEvent = null):void
        {
            classLabel.text = "Class:";
            var race:String = classOptionIterator.nextOption();

            var template:Object = PlayerClassTemplates.getTemplate(race);

            applyTemplate(template);
        }

        private function applyTemplate(template:Object):void
        {
            lifeNumStepper.value = template.life;
            hitNumStepper.value = template.attackRoll;
            defNumStepper.value = template.defense;
            potionsNumStepper.value = template.potions;

            updateRandomMapPlayer();
        }

        private function updateRandomMapPlayer():void
        {
            randMap.player.setAttackRolls(hitNumStepper.value);
            randMap.player.setDefenseRolls(defNumStepper.value);
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

            //Mark active game flag, save player info and go to next screen
            activeGameState.activeGame = true;
            activeGameState.player = {name:nameInput.text,
                            maxLife: lifeNumStepper.value,
                            attackRoll: hitNumStepper.value,
                            defenseRoll: defNumStepper.value,
                            maxPotions: potionsNumStepper.value,
                            points:characterPoints,
                            characterPoints:DEFAULT_POINTS};

            saveState(null);

            nextActivity(RandomMapGeneratorActivity);
        }

        public function onSave(event:MouseEvent):void
        {
            customTemplateState.name = nameInput.text == "" ? "Not Sure" : nameInput.text
            customTemplateState.className = classButton.label;
            customTemplateState.life = lifeNumStepper.value;
            customTemplateState.attackRoll = hitNumStepper.value;
            customTemplateState.defense = defNumStepper.value;
            customTemplateState.potions = potionsNumStepper.value;

            customTemplateState.save();

            classLabel.text = "Class(Custom):";
        }

        public function onCustomLook(event:MouseEvent):void
        {
            nextActivity(GenerateCharacterActivity, null);
        }

        override public function loadState(obj:Object):void
        {
            activeGameState.load();
            customTemplateState.load();
        }

        override public function saveState(obj:Object, activeState:Boolean = true):void
        {
            activeGameState.save();

        }

    }
}
