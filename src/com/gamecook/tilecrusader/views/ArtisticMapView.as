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
package com.gamecook.tilecrusader.views
{
    import com.gamecook.frogue.helpers.MovementHelper;
    import com.gamecook.frogue.maps.MapPopulater;
    import com.gamecook.frogue.io.Controls;
    import com.gamecook.frogue.maps.FogOfWarMapSelection;
    import com.gamecook.frogue.maps.MapSelection;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.AbstractMapRenderer;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.combat.CombatHelper;
    import com.gamecook.tilecrusader.factory.TileFactory;
    import com.gamecook.tilecrusader.iterators.TreasureIterator;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.renderer.MQMapBitmapRenderer;
    import com.gamecook.tilecrusader.tiles.PlayerTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;

    public class ArtisticMapView extends Sprite
    {
        [Embed(source="../../../../../build/assets/tc_sprite_sheet.png")]
        public static var SpriteSheetImage:Class;

        public var map:RandomMap;
        private var renderer:AbstractMapRenderer;
        private var renderWidth:int;
        private var renderHeight:int;
        private var darknessWidth:int;
        private var darknessHeight:int;

        private var populateMapHelper:MapPopulater;
        private var movementHelper:MovementHelper;
        private var invalid:Boolean = true;
        public var player:PlayerTile;
        private var tileInstanceManager:TileInstanceManager;
        private var tileTypes:TileTypes;
        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);
        private var mapBitmap:Bitmap;
        private var mapDarkness:FogOfWarMapSelection;

        private static const TILE_SIZE:int = 32;
        private var scale:int = 2;
        private var tileWidth:int;
        private var tileHeight:int;
        private var viewPortWidth:int = 0;
        private var viewPortHeight:int = 0;
        private var blocked:Boolean = true;
        private var dir:int = 0;

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
            mapDarkness = new FogOfWarMapSelection(map, renderWidth, renderHeight, 3);
            mapDarkness.revealAll(true);

            populateMapHelper = new MapPopulater(map);

            movementHelper = new MovementHelper(map);

            tileTypes = new TileTypes();
            tileInstanceManager = new TileInstanceManager(new TileFactory(tileTypes));

            mapBitmap = new Bitmap(new BitmapData(viewPortWidth/scale, viewPortHeight/scale, false, 0xff0000));
            mapBitmap.scaleX = mapBitmap.scaleY = scale;
            mapBitmap.y = 0;
            addChild(mapBitmap);

            renderer = new MQMapBitmapRenderer(mapBitmap.bitmapData, spriteSheet, tileInstanceManager);


            // Configure
            map.generateMap(30);

            movementHelper.startPosition(populateMapHelper.getRandomEmptyPoint());
            //player = tileInstanceManager.getInstance("@", "@", {life:0, maxLife:"", attackRoll: ""}) as PlayerTile;

            render();
        }

        public function render():void
        {

            /*if (invalid)
            {
                mapDarkness.setCenter(movementHelper.playerPosition);
                renderer.renderMap(mapDarkness);
                invalid = false;
            }*/

        }

    }
}
