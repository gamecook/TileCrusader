/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/20/11
 * Time: 8:49 AM
 * To change this template use File | Settings | File Templates.
 */
package
{
    import com.bit101.components.Component;
    import com.bit101.components.Style;
    import com.gamecook.tilecrusader.TileCrusaderGame;
    import com.gamecook.tilecrusader.activities.DebugStartActivity;
    import com.gamecook.tilecrusader.activities.GameCookSplashActivity;
    import com.gamecook.tilecrusader.managers.PopUpManager;
    import com.gamecook.tilecrusader.trackers.GoogleTracker;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.analytics.ITrack;
    import com.jessefreeman.factivity.utils.DeviceUtil;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.system.Capabilities;

    import net.hires.debug.Stats;

    [SWF(width="800",height="480",backgroundColor="#000000",frameRate="60")]
    public class TileCrusaderApp extends Sprite
    {
        [Embed(source='../build/assets/nokiafc22.ttf', fontName="system", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT:String;

        [Embed(source='../build/assets/fonts/slkscr.ttf', fontName="system2", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT2:String;

        private var game:TileCrusaderGame;
        private var tracker:ITrack;
        private var os:String;

        public function TileCrusaderApp()
        {
            configureStage();
            configureComponents();
            os = Capabilities.version.substr(0, 3);

            tracker = new GoogleTracker(this, "UA-18884514-4", "AS3", false);

            var scale:Number = 2;
            // Set up the screen size for BaseActivity
            BaseActivity.fullSizeWidth = DeviceUtil.getScreenWidth(stage) / scale;
            BaseActivity.fullSizeHeight = DeviceUtil.getScreenHeight(stage) / scale;

            PopUpManager.config(stage, BaseActivity.fullSizeWidth, BaseActivity.fullSizeHeight);

            //Debug Game
            //game = new TileCrusaderGame(tracker, 0, 0, DebugStartActivity, scale);
            //game = new TileCrusaderGame(tracker, 0, 0, ColorSwapTest, scale);

            // Real Game
            game = new TileCrusaderGame(tracker, 0,0, GameCookSplashActivity, scale);

            addChild(game);

            var stats:DisplayObject = addChild(new Stats());

            stats.y = (BaseActivity.fullSizeHeight * 2) - stats.height;
            /*
             var label:Label = new Label(this, 0, 0);
             label.autoSize = true;
             label.textField.multiline = true;
             label.textField.wordWrap = true;
             label.textField.width = 300;
             label.text += "Screen Resolution: " + stage.stageWidth + "x" + stage.stageHeight + "\n";
             label.text += "Full Screen Resolution: " + stage.fullScreenWidth + "x" + stage.fullScreenHeight + "\n";
             label.text += "Native Screen Resolution: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + "\n";
             label.text += "Version: " + Capabilities.version + "\n";
             label.text += "DPI: " + Capabilities.screenDPI + "\n";
             label.text += "Display Mode: " + stage.displayState + "\n";

             label.x = stats.width + 10;
             label.y = stats.y;*/
        }

        private function configureComponents():void
        {
            // Configure Minimal Comps
            Style.setStyle(Style.DARK);

            Style.fontName = "system";
            Component.initStage(stage);
        }

        private function configureStage():void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
    }
}
