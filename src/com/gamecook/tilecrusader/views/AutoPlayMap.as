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

    public class AutoPlayMap extends Sprite
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

        public function AutoPlayMap(viewPortWidth:int, viewPortHeight:int)
        {
            this.viewPortHeight = viewPortHeight;
            this.viewPortWidth = viewPortWidth;

            init();
        }

        private function init():void
        {
            //TODO this entire thing is broken, good luck...

            /*parseSpriteSheet();

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
            player = tileInstanceManager.getInstance("@", "@", {life:0, maxLife:"", attackRoll: ""}) as PlayerTile;

            render();*/
        }

        private function parseSpriteSheet():void
        {
            spriteSheet = SingletonManager.getClassReference(SpriteSheet);
            spriteSheet.clear();

            // create sprite sheet
            var bitmap:Bitmap = new SpriteSheetImage();
            spriteSheet.bitmapData = bitmap.bitmapData;
            var tileSize:int = 32;
            var i:int;
            var total:int = Math.floor(bitmap.width / tileSize);
            var spriteRect:Rectangle = new Rectangle(0, 0, tileSize, tileSize);
            for (i = 0; i < total; ++i)
            {
                spriteRect.x = i * tileSize;
                spriteSheet.registerSprite("sprite" + i, spriteRect.clone());
            }
        }

        public function up():void
        {
            move(MovementHelper.UP);
        }

        public function down():void
        {
            move(MovementHelper.DOWN);
        }

        public function right():void
        {
            move(MovementHelper.RIGHT);
        }

        public function left():void
        {
            move(MovementHelper.LEFT);
        }

        public function move(value:Point):void
        {

            /*var tmpPoint:Point = movementHelper.previewMove(value.x, value.y);

            if (tmpPoint != null)
            {
                var tile:String = map.getTileType(tmpPoint);

                switch (tileTypes.getTileType(tile))
                {
                    case TileTypes.IMPASSABLE:
                        blocked = true;
                        return;

                    default:
                        movePlayer(value);
                        blocked = false;
                        break;
                }
                invalidate();
            }*/
        }

        private function movePlayer(value:Point):void
        {
            movementHelper.move(value.x, value.y);
        }

        protected function invalidate():void
        {
            invalid = true;
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

        public function nextMove():void
        {
            if(blocked || Math.random() > .8)
            {
                dir = Math.random() * 4;
            }

            switch(dir)
                {
                    case 0:
                        up();
                        break;
                    case 1:
                        right();
                        break;
                    case 2:
                        down();
                        break;
                    case 3:
                        left();
                        break;
                }
        }
    }
}
