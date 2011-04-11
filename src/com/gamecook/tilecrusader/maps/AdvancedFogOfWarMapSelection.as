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
 * User: jfreeman
 * Date: 2/15/11
 * Time: 9:55 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.maps
{
    import com.gamecook.frogue.maps.IMap;
    import com.gamecook.frogue.maps.MapSelection;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.tiles.MonsterTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;

    import flash.geom.Point;

    public class AdvancedFogOfWarMapSelection extends MapSelection
    {
        protected var exploredTilesHashMap:Array = [];
        protected var saveExploredTiles:Boolean = true;
        protected var _revealAll:Boolean;
        protected var visiblePoints:Array = [];
        protected var viewDistance:int;
        protected var _tourchMode:Boolean;
        protected var exploredTiles:Array = [];
        protected var lightMap:Array = [];
        private var instanceManager:TileInstanceManager;

        public function AdvancedFogOfWarMapSelection(map:IMap, width:int, height:int, viewDistance:int, instanceManager:TileInstanceManager)
        {
            this.instanceManager = instanceManager;
            this.viewDistance = viewDistance;
            super(map, width, height);
        }

        override protected function getSurroundingTiles(center:Point, horizontalRange:Number, verticalRange:Number):Array
        {

            var tiles:Array = super.getSurroundingTiles(center, horizontalRange, verticalRange);

            // Need to adjust the center point coming in
            var newPoint:Point = center.clone();
            newPoint.x -= getOffsetX();
            newPoint.y -= getOffsetY();

            calculateLight(tiles, new Point(newPoint.y, newPoint.x));

            applyLight(tiles, visiblePoints);

            if (!saveExploredTiles)
                clear();

            return tiles;
        }

        private function applyLight(tiles:Array, visiblePoints:Array):void
        {
            var width:int = tiles[0].length;
            var height:int = tiles.length;

            var rows:int;
            var columns:int;

            for (rows = 0; rows < height; rows++) {
                for (columns = 0; columns < width; columns ++) {
                    var spriteID:String = TileTypes.getTileSprite("#");
                    var tileValue = tiles[rows][columns];
                    var uID:int = getTileID(columns, rows);

                    // Get base tile if it's not a wall
                    if (tileValue != "#") {
                        spriteID = TileTypes.getTileSprite(" ");

                        if (tileValue != " ")
                            spriteID = spriteID.concat("," + TileTypes.getTileSprite(tiles[rows][columns]));

                    }

                    //Pre-Process tile based on type.
                    if (TileTypes.isMonster(tileValue)) {
                        var newMonsterTile:MonsterTile = instanceManager.getInstance(uID.toString(), tileValue) as MonsterTile
                        var newTileID:String = newMonsterTile.getSpriteID();
                        if (newTileID != "" || newTileID)
                            spriteID = spriteID.concat("," + newMonsterTile.getSpriteID());
                    }

                    //Apply lighting effects
                    if (lightMap[uID]) {

                        var id:int = Math.round((viewDistance - lightMap[uID]) / viewDistance * 10) - 3;
                        if (id < 1)
                            id = 0;

                        spriteID = spriteID.concat(",light" + id);
                    }
                    else if (exploredTilesHashMap[uID]) {
                        //trace("Out Of Sight", uID, tileValue, viewDistance+1);
                        spriteID = spriteID = spriteID.concat(",light9");
                    }
                    else if (TileTypes.isMonster(tileValue)) {
                        //trace("Monster in Dark", uID);
                        spriteID = "sprite3";
                    }
                    else {
                        spriteID = "light10";
                    }

                    tiles[rows][columns] = spriteID;
                }

            }
            lightMap.length = 0;
            visiblePoints.length = 0;
        }

        private function calculateLight(tiles:Array, center:Point):void
        {

            var totalRows:int = tiles.length;
            var totalColumns:int = tiles[0].length;
            var i:int;

            // Get top
            for (i = 0; i < totalColumns; i++) {
                rayTrace(center.x, center.y, 0, i, tiles);
                rayTrace(center.x, center.y, totalRows - 1, i, tiles);
            }

            for (i = 0; i < totalRows; i++) {
                rayTrace(center.x, center.y, i, 0, tiles);
                rayTrace(center.x, center.y, i, totalColumns - 1, tiles);
            }
        }


        private function rayTrace(x0:int, y0:int, x1:int, y1:int, tiles:Array):void
        {

            var dx:int = Math.abs(x1 - x0);
            var dy:int = Math.abs(y1 - y0);
            var x:int = x0;
            var y:int = y0;
            var n:int = viewDistance;//(!_fullLineOfSight) ? viewDistance : 1 + dx + dy;
            var x_inc:int = (x1 > x0) ? 1 : -1;
            var y_inc:int = (y1 > y0) ? 1 : -1;
            var error:int = dx - dy;
            dx *= 2;
            dy *= 2;

            for (; n > 0; --n) {
                var isWall:Boolean = visit(x, y, tiles, n);

                if (isWall)
                    n = 0;

                if (error > 0) {
                    x += x_inc;
                    error -= dy;
                }
                else {
                    y += y_inc;
                    error += dx;
                }
            }

        }

        private function visit(x:int, y:int, tiles:Array, distance:int):Boolean
        {
            //TODO not sure why I would ever get a value less then 0 but I do
            if (x < 0) x = 0;
            if (x > tiles.length - 1) x = tiles.length - 1;
            if (y < 0) y = 0;
            if (y > tiles[0].length - 1) y = tiles[0].length - 1;

            var tile:String = tiles[x][y];

            var uID:int = getTileID(y, x);

            lightMap[uID] = distance;

            if (visiblePoints.indexOf(uID) == -1)
                visiblePoints.push(uID);

            if (!_tourchMode);// || !_fullLineOfSight)
            {
                if (!exploredTilesHashMap[uID] && tile != "#") {
                    exploredTilesHashMap[uID] = " ";
                    exploredTiles.push(uID);
                }
            }
            //TODO this should use the type types to see if it is see threw not just a wall to add shadow around monsters
            return tile == "#" ? true : false;
        }

        public function clear():void
        {
            exploredTilesHashMap.length = 0;
            exploredTiles.length = 0;
        }

        public function revealAll(value:Boolean):void
        {
            _revealAll = value;

        }

        public function tourchMode(value:Boolean):void
        {
            _tourchMode = value;
        }

        /*public function fullLineOfSight(value:Boolean):void
         {
         _fullLineOfSight = value;
         }*/

        public function getVisitedTiles():int
        {
            return exploredTiles.length;
        }

        public function getExploredTiles():Array
        {
            return exploredTiles;
        }
    }
}
