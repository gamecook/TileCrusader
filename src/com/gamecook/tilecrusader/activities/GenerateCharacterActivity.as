/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/14/11
 * Time: 10:20 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities {
    import com.gamecook.tilecrusader.tools.generator.CharacterGenerator;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.IActivityManager;

    import flash.display.Bitmap;

    public class GenerateCharacterActivity extends BaseActivity{
        private var character:Bitmap;
        private var generator:CharacterGenerator;

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

        protected function onUpdateCharacter():void
        {
            character.bitmapData = generator.generateBitmapData();
        }
    }
}
