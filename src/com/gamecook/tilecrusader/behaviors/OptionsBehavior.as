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
 * Date: 3/6/11
 * Time: 12:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.behaviors
{
    import com.jessefreeman.factivity.iterators.ArrayIterator;
    import com.jessefreeman.factivity.iterators.IIterator;

    public class OptionsBehavior
    {
        private var target:*;
        private var options:Array;
        private var startIndex:int;
        private var iterator:IIterator;

        public function OptionsBehavior(target:*, options:Array, startIndex:int = -1)
        {
            this.startIndex = startIndex;
            this.options = options;
            this.target = target;
            iterator = new ArrayIterator(options, startIndex);
        }

        public function nextOption():*
        {
            var value:* = iterator.getNext();

            //TODO may need an option to put clean text in vs a value
            if (target.hasOwnProperty("text"))
                target.text = value;
            else if (target.hasOwnProperty("label"))
                target.label = value;

            return value;
        }

        public function reset():void
        {
            iterator.setIndex(startIndex);
            nextOption();
        }

        public function setIndex(value:int):void
        {
            iterator.setIndex(value);
        }
    }
}
