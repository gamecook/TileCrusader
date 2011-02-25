/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.text.TextField;

    public class GameOverActivity extends BaseActivity
    {
        public function GameOverActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function init():void
        {
            super.init();

            var tf:TextField = UIFactory.createTextField(200,200, "You were killed!");
            tf.textColor = 0xffffff;
            tf.x = (fullSizeWidth - tf.width) * .5;
            tf.y = (fullSizeHeight - tf.height) * .5;
            addChild(tf);

            startNextActivityTimer(StartActivity, 3);
        }
    }
}
