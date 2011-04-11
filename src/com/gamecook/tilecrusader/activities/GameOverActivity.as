/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
import com.bit101.components.Label;
import com.gamecook.tilecrusader.sounds.TCSoundClasses;
import com.gamecook.tilecrusader.states.ActiveGameState;
import com.jessefreeman.factivity.managers.ActivityManager;

public class GameOverActivity extends AdvancedActivity
    {
        private var activeGameState:ActiveGameState;

        public function GameOverActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            activeGameState = new ActiveGameState();
            loadState(null);

            super.onCreate();

            soundManager.play(TCSoundClasses.DeathTheme);

            var tf:Label = new Label(this, 0,0, "You were killed!");
            tf.x = (fullSizeWidth - tf.width) * .5;
            tf.y = (fullSizeHeight - tf.height) * .5;
            addChild(tf);

            startNextActivityTimer(StartActivity, 3);

            //TODO show stats before clearing this out.

            //TODO save player name and score

            activeGameState.clear();
        }

        override public function loadState(obj:Object):void
        {
            activeGameState.load();
        }
    }
}
