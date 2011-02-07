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

        public function GoldItem(total:int = 0)
        {
            this.total = total;
        }

        public function getTotal():int
        {
            return total;
        }
    }
}
