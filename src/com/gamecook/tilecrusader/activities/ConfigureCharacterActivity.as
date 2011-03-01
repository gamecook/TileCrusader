/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.tilecrusader.factory.UIFactory;
    import com.gamecook.tilecrusader.views.Button;
    import com.gamecook.tilecrusader.views.StackLayout;
    import com.gamecook.tilecrusader.views.forms.InputField;
    import com.gamecook.tilecrusader.views.forms.PopUpPicker;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Shape;
    import flash.text.TextField;

    public class ConfigureCharacterActivity extends BaseActivity
    {
        public function ConfigureCharacterActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            var characterLayout:StackLayout = new StackLayout(10,StackLayout.HORIZONTAL);
            characterLayout.x = characterLayout.y = 50;
            addChild(characterLayout);

            // Player Portrait
            var playerPortrait:Shape = new Shape();
            playerPortrait.graphics.beginFill(0xff000);
            playerPortrait.graphics.drawRect(0,0,20,20);
            playerPortrait.graphics.endFill();
            playerPortrait.scaleX = playerPortrait.scaleY = 8;

            characterLayout.addChild(playerPortrait);

            var characterBioLayout:StackLayout = new StackLayout(10, StackLayout.VERTICAL);
            characterLayout.addChild(characterBioLayout);

            // Name Block
            var nameBlock:StackLayout = new StackLayout(20, StackLayout.HORIZONTAL);


            var nameLabel:TextField = UIFactory.createTextField(0,0,"Name:");
            nameBlock.addChild(nameLabel);

            var nameInput:InputField = UIFactory.createInputField(0,0,"Not Sure");
            nameBlock.addChild(nameInput);

            characterBioLayout.addChild(nameBlock);

            // Race Block
            var raceBlock:StackLayout = new StackLayout(20, StackLayout.HORIZONTAL);


            var raceLabel:TextField = UIFactory.createTextField(0,0,"Race:");
            raceBlock.addChild(raceLabel);

            var raceInput:PopUpPicker = UIFactory.createPopUpPicker(0,0,["Knight", "Mage", "Theif", "Necormancer", "Barbarian", "Dark Mage", "Hero", "Angel", "Demon", "Ancient"]);
            raceBlock.addChild(raceInput);

            characterBioLayout.addChild(raceBlock);

            // Attribute Block
            var attributeBlock:StackLayout = new StackLayout(20, StackLayout.VERTICAL);


            var attributeLabel:TextField = UIFactory.createTextField(0,0,"Special Attribute:");
            attributeBlock.addChild(attributeLabel);

            var attributeInput:PopUpPicker = UIFactory.createPopUpPicker(0,0,["First Attack"]);
            attributeBlock.addChild(attributeInput);

            characterBioLayout.addChild(attributeBlock);
        }
    }
}
