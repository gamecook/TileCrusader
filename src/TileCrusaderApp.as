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
    import com.gamecook.tilecrusader.activities.MinimalCompsTestActivity;
    import com.gamecook.tilecrusader.managers.PopUpOverlayManager;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.gamecook.tilecrusader.TileCrusaderGame;
    import com.gamecook.tilecrusader.activities.GameCookSplashActivity;
    import com.gamecook.tilecrusader.activities.StartActivity;

    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import net.hires.debug.Stats;

    [SWF(width="800",height="480",backgroundColor="#000000",frameRate="60")]
    public class TileCrusaderApp extends Sprite
    {
        [Embed(source='../build/assets/nokiafc22.ttf', fontName="system", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT:String;

        [Embed(source='../build/assets/fonts/slkscr.ttf', fontName="system2", embedAsCFF=false, mimeType="application/x-font-truetype")]
        private static var EMBEDDED_FONT2:String;

        private var game:TileCrusaderGame;
        public function TileCrusaderApp()
        {
            configureStage();
            configureComponents();

            BaseActivity.fullSizeWidth = stage.stageWidth >= 1280 ? 1280 : stage.stageWidth;
            BaseActivity.fullSizeHeight = stage.stageHeight >= 800 ? 800 : stage.stageHeight;

            PopUpOverlayManager.config(stage, BaseActivity.fullSizeWidth, BaseActivity.fullSizeHeight);

            game = new TileCrusaderGame(0,0, GameCookSplashActivity);
            addChild(game);

            var stats:DisplayObject = addChild( new Stats() );

            CONFIG::mobile
            {
                stats.scaleX = stats.scaleY = 2;
            }

            stats.y =  BaseActivity.fullSizeHeight - stats.height;
        }

        private function configureComponents():void
        {
            // Configure Minimal Comps
            Style.setStyle(Style.DARK);
            Style.fontName = "system";
            Component.initStage(stage);
        }

        private function configureStage():void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
    }
}
