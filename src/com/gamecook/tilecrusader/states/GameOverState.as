/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
    import com.gamecook.lib.states.BaseState;

    import com.gamecook.tilecrusader.factory.UIFactory;

    import flash.text.TextField;

    public class GameOverState extends BaseState
    {
        public function GameOverState()
        {
            super();
        }

        override public function create():void
        {
            super.create();

            var tf:TextField = UIFactory.createTextField(200,200, "You were killed!");
            tf.textColor = 0xffffff;
            tf.x = (fullSizeWidth - tf.width) * .5;
            tf.y = (fullSizeHeight - tf.height) * .5;
            addChild(tf);

            startNextScreenTimer(StartState, 3);
        }
    }
}
