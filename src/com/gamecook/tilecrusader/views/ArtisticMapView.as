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
 * Date: 2/20/11
 * Time: 10:53 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views {
    import com.gamecook.frogue.maps.MapPopulater;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.AbstractMapRenderer;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.factory.TileFactory;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.maps.TCMapSelection;
    import com.gamecook.tilecrusader.renderer.MQMapBitmapRenderer;
    import com.gamecook.tilecrusader.tiles.PlayerTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ArtisticMapView extends Sprite {
        [Embed(source="../../../../../build/assets/tc_sprite_sheet.png")]
        public static var SpriteSheetImage:Class;

        public var map:RandomMap;
        private var renderer:AbstractMapRenderer;
        private var renderWidth:int;
        private var renderHeight:int;
        private var darknessWidth:int;
        private var darknessHeight:int;

        private var populateMapHelper:MapPopulater;
        public var player:PlayerTile;
        private var tileInstanceManager:TileInstanceManager;
        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);
        private var mapBitmap:Bitmap;

        private static const TILE_SIZE:int = 32;
        private var scale:int = 1;
        private var tileWidth:int;
        private var tileHeight:int;
        private var viewPortWidth:int = 0;
        private var viewPortHeight:int = 0;
        private var mapSelection:TCMapSelection;

        public function ArtisticMapView(viewPortWidth:int, viewPortHeight:int)
        {
            this.viewPortHeight = viewPortHeight;
            this.viewPortWidth = viewPortWidth;

            init();
        }

        private function init():void
        {
            //TODO this entire thing is broken, good luck...


            // Configure Tile, Render and Darkness size
            tileWidth = tileHeight = TILE_SIZE * scale;

            renderWidth = Math.floor(viewPortWidth / tileWidth);
            renderHeight = Math.floor(viewPortHeight / tileHeight);

            darknessWidth = 5;
            darknessHeight = 4;

            map = new RandomMap();
            // Configure
            map.generateMap(10);

            populateMapHelper = new MapPopulater(map);

            tileInstanceManager = new TileInstanceManager(new TileFactory());

            mapSelection = new TCMapSelection(map, renderWidth, renderHeight, 3, null);

            mapBitmap = new Bitmap(new BitmapData(viewPortWidth / scale, viewPortHeight / scale, false, 0xff0000));
            mapBitmap.scaleX = mapBitmap.scaleY = scale;
            mapBitmap.y = 0;
            addChild(mapBitmap);

            renderer = new MQMapBitmapRenderer(mapBitmap.bitmapData, spriteSheet, tileInstanceManager);

            var startPoint:Point = populateMapHelper.getRandomEmptyPoint();

            mapSelection.setCenter(populateMapHelper.getRandomEmptyPoint());
            var point:Point = populateMapHelper.getRandomEmptyPoint();
            mapSelection.setCenter(point);


            renderer.renderMap(mapSelection);

            // Apply effect

            // Create a new rectangle from 0,0
            var rect:Rectangle = new Rectangle(0, 0, mapBitmap.width, mapBitmap.height);
            // Set sepia properties
            var greyColorMatrix = new ColorMatrixFilter();
            greyColorMatrix.matrix = [.3086    ,    .6094    ,    .0820    ,    0    ,    0,
                .3086    ,    .6094    ,    .0820    ,    0    ,    0,
                .3086    ,    .6094    ,    .0820    ,    0    ,    0,
                0    ,    0    ,    0    ,    1    ,    0
            ];


            var tmpBitmapData:BitmapData = mapBitmap.bitmapData.clone();
            tmpBitmapData.applyFilter(tmpBitmapData, rect, new Point(0, 0), greyColorMatrix);


            mapBitmap.bitmapData.draw(tmpBitmapData);

            var x:int = point.x - mapSelection.getOffsetX();
            var y:int = point.y - mapSelection.getOffsetY();

            renderer.renderPlayer(x, y, TileTypes.getTileSprite("@"));
        }

    }
}
