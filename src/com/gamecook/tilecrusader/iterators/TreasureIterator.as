/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/10/11
 * Time: 11:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.iterators
{
    public class TreasureIterator implements IIterator
    {
        private var pool:Array = [];

        public function TreasureIterator(target:Array)
        {
            pool = target;
            randomizePool();
        }

        protected function randomizePool():void {
            var newArray:Array = new Array();
            while(pool.length > 0){
                var obj:Array = pool.splice(Math.floor(Math.random()*pool.length), 1);
                newArray.push(obj[0]);
            }
            pool = newArray;
        }

        public function hasNext():Boolean
        {
            return (pool.length != 0);
        }


        public function getNext():*
        {
            if(pool.length == 0)
                return " ";

            randomizePool();
            return pool.pop();
        }

        public function setIndex(value:int = -1):void
        {
        }
    }
}
