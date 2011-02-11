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

    public class TreasureFactory implements ITileFactory
    {
        private var tileTypes:TileTypes;

        public function TreasureFactory(tileTypes:TileTypes)
        {
            this.tileTypes = tileTypes;
            indexItemsToPickUp()
        }

        private function indexItemsToPickUp():void
        {
        }

        public function createTile(value:String):BaseTile
        {
            return null;
        }
    }
}
