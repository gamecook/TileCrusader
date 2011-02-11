/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/6/11
 * Time: 9:19 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.items
{
    public class GoldItem
    {
        private var total:int;

        public function GoldItem(min:int = 0, max:int = 100)
        {
            trace("Gold Created");
        }

        public function getTotal():int
        {
            return total;
        }
    }
}
