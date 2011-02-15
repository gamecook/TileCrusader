/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 2/15/11
 * Time: 9:55 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.map
{
    import com.gamecook.frogue.maps.IMap;
    import com.gamecook.frogue.maps.IMapSelection;

    import com.gamecook.frogue.maps.MapSelection;

    import flash.geom.Point;

    public class MapFogOfWar implements IMapSelection
    {
        private var map:IMap;
        private var selection:IMapSelection;
        private var width:int;
        private var height:int;
        private var exploredTiles:Array = [];
        private var visibleSelection:IMapSelection;

        public function MapFogOfWar(map:IMap, selection:IMapSelection, width:int, height:int)
        {
            this.height = height;
            this.width = width;
            this.selection = selection;
            this.map = map;
            visibleSelection = new MapSelection(map, width, height);

        }

        public function getTileID(column:int, row:int):int
        {
            return selection.getTileID(column, row);
        }

        public function getTiles():Array
        {
            return selection.getTiles();
        }

        public function getOffsetX():int
        {
            return selection.getOffsetX();
        }

        public function getOffsetY():int
        {
            return selection.getOffsetY();
        }

        public function setCenter(value:Point):void
        {
            visibleSelection.setCenter(value);

            var i:int;
            var j:int;
            var visibleTiles:Array = visibleSelection.getTiles();
            var rows:int = visibleTiles.length;
            var columns:int = visibleTiles[0].length;
            var uID:int;

            for(i = 0; i < rows; i++)
            {
                for(j = 0; j < columns; j++)
                {
                    uID = visibleSelection.getTileID(j,i);
                    exploredTiles[uID] = " ";
                }

            }

            selection.setCenter(value);
            visibleTiles = selection.getTiles();
            rows = visibleTiles.length;
            columns = visibleTiles[0].length;
            var tile:String;

            for(i = 0; i < rows; i++)
            {
                for(j = 0; j < columns; j++)
                {
                    uID = selection.getTileID(j,i);
                    tile = visibleTiles[i][j];
                    if(!exploredTiles[uID])
                    {
                        visibleTiles[i][j] = "*";
                    }
                }

            }
        }

        public function clear():void
        {
            exploredTiles.length = 0;
        }
    }
}
