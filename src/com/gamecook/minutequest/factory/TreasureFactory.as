/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/10/11
 * Time: 11:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.factory
{
    import com.gamecook.minutequest.tiles.BaseTile;
    import com.gamecook.minutequest.tiles.TileTypes;

    public class TreasureFactory
    {
        private var pool:Array = [];

        public function TreasureFactory()
        {

        }

        public function addTreasure(...types):void
        {
            var i:int;
            var total:int = types.length;
            for (i = 0; i < total; i++)
            {
                pool.push(types[i]);
            }
        }

        public function nextTreasure():String
        {
            if(pool.length == 0)
                return " ";

            randomizePool();
            return pool.pop();
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


    }
}
