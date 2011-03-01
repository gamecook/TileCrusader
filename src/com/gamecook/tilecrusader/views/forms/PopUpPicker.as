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
 * Date: 2/28/11
 * Time: 11:30 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views.forms
{
    import com.gamecook.tilecrusader.factory.UIFactory;

    import com.gamecook.tilecrusader.managers.PopUpOverlayManager;
    import com.gamecook.tilecrusader.views.Button;

    import com.gamecook.tilecrusader.views.popups.PopUpPickerWindow;

    import flash.display.Sprite;

    import mx.managers.PopUpManager;

    public class PopUpPicker extends Sprite
    {
        private var data:Array;
        private var selectedID:int;
        private var btn:Button;

        public function PopUpPicker(data:Array, select:int = 0)
        {
            this.data = data;

            btn = UIFactory.createTextFieldButton(onClick, 0,0,"");
            addChild(btn);
            selectItem(select);
        }

        private function onClick():void
        {
            PopUpOverlayManager.showOverlay(new PopUpPickerWindow(data, selectedID), onClose, true);
        }

        private function onClose():void
        {

        }

        public function selectItem(index:int):void
        {
            selectedID = index;
            var states:Object = UIFactory.createButtonStates(data[selectedID]);
            btn.changeStates(states.up, states.over, states.down, states.rect);
        }
    }
}
