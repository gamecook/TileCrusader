/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/15/11
 * Time: 9:40 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.SoundManager;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.IActivityManager;

    public class AdvancedActivity extends BaseActivity
    {

        protected var soundManager:SoundManager = SingletonManager.getClassReference(SoundManager) as SoundManager;


        public function AdvancedActivity(activityManager:IActivityManager, data:*)
        {
            super(activityManager, data);
        }

        override public function onStop():void
        {
            soundManager.destroySounds();
            soundManager.volume = 0;
            super.onStop();
        }

    }
}
