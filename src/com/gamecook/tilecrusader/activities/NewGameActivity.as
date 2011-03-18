/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.SoundManager;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.ActivityManager;

    public class NewGameActivity extends RandomMapBGActivity
    {
        var soundManager:SoundManager = SingletonManager.getClassReference(SoundManager) as SoundManager;

        public function NewGameActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            soundManager.play(TCSoundClasses.MainTileCrusaderTheme, .5, true);
            super.onCreate();
        }
    }
}
