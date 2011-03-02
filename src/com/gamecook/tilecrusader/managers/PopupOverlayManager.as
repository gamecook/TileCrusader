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
 * Date: 2/27/11
 * Time: 9:06 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers
{
    import com.gamecook.tilecrusader.views.AbstractPopUp;
    import com.gamecook.tilecrusader.views.IPopUp;

    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.MouseEvent;

    public class PopUpOverlayManager
    {
        private static var stage:Stage;
        private static var currentPopUp:AbstractPopUp;
        private static var onClose:Function;
        private static var overlay:Sprite;


        public static function config(target:Stage, width:int, height:int, overlayColor:uint = 0x000000, overlayAlpha:Number = .8):void
        {
            stage = target;
            overlay = new Sprite();
            overlay.graphics.beginFill(overlayColor, overlayAlpha);
            overlay.graphics.drawRect(0,0,width, height);
            overlay.graphics.endFill();

        }

        public static function showOverlay(target:AbstractPopUp, onClose:Function = null, overlayClose:Boolean = false):void
        {

            if(overlayClose)
                overlay.addEventListener(MouseEvent.CLICK, onOverlayClick);

            removePopUp(false);

            stage.addChild(overlay);
            currentPopUp = target;
            currentPopUp.x = ((overlay.width - currentPopUp.width) * .5);
            currentPopUp.y = ((overlay.height - currentPopUp.height) * .5);
            stage.addChild(currentPopUp);
        }

        private static function onOverlayClick(event:MouseEvent):void
        {
            close();
        }

        private static function removePopUp(removeOverlay:Boolean):void
        {
            if (currentPopUp)
            {
                stage.removeChild(currentPopUp);
                currentPopUp = null;
            }

            if(overlay.stage && removeOverlay)
            {
                overlay.hasEventListener(MouseEvent.CLICK);
                overlay.removeEventListener(MouseEvent.CLICK, onOverlayClick);
                stage.removeChild(overlay);
            }
        }

        public static function close():void
        {
            removePopUp(true);
            if(onClose != null)
            {
                onClose();
                onClose = null;
            }
        }
    }
}