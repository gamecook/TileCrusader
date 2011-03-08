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
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.net.SharedObject;
    public class GameOverActivity extends BaseActivity
    {
        public function GameOverActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {
            super.onCreate();

            var tf:Label = new Label(this, 0,0, "You were killed!");
            tf.x = (fullSizeWidth - tf.width) * .5;
            tf.y = (fullSizeHeight - tf.height) * .5;
            addChild(tf);

            startNextActivityTimer(StartActivity, 3);

            var so:SharedObject = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            so.clear();
        }
    }
}
