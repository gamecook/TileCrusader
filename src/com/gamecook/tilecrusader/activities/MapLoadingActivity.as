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
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.gamecook.frogue.maps.MapPopulater;
    import com.gamecook.frogue.maps.Map;
    import com.gamecook.frogue.maps.MapSelection;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.MapDrawingRenderer;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.gamecook.tilecrusader.states.ActiveGameState;
    import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.Rectangle;
    import flash.net.SharedObject;
    import flash.utils.getQualifiedClassName;

    import mx.graphics.shaderClasses.ColorBurnShader;

    public class MapLoadingActivity extends AdvancedActivity
    {
        [Embed(source="../../../../../build/assets/tc_sprite_sheet.png")]
        public static var SpriteSheetImage:Class;
        protected var textCounter:Number = 0;
        protected var textDelay:Number = 300;
        private var spriteSheet:SpriteSheet;
        private var map:RandomMap;
        private var label:Label;
        private const LOADING_TEXT:String = "Loading ";
        private var activeGameState:ActiveGameState;
        private var monsters:Array = [];
        private var chests:Array = [];
        private const TILE_SIZE:int = 32;

        public function MapLoadingActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            label = new Label(this, 0,0, LOADING_TEXT);
            label.scaleX = label.scaleY = 2;
            label.x = (fullSizeWidth - label.width) * .5
            label.y = (fullSizeHeight - label.height) * .5
            addChild(label);


            activeGameState = new ActiveGameState();

            loadState(null);

            parseSpriteSheet();


            createMap();

            saveState(null);

            // Create data object for next activity
            var activityObject:Object = {};
            activityObject.lastActivity = getQualifiedClassName(MapLoadingActivity).replace("::", ".");
            activityObject.mapInstance = map;

            startNextActivityTimer(GameActivity, 2, activityObject);
        }

        private function createMap():void
        {
            //Create new Random Map
            map = new RandomMap();

            // Test to see if the current active state already has map
            if (activeGameState.map)
            {
                // Get tiles from game state's map object
                map.tiles = activeGameState.map.tiles;
            }
            else
            {
                // If there were no tiles, generate a new map
                TimeMethodExecutionUtil.execute("generateMap", map.generateMap, activeGameState.size);

                activeGameState.startMessage = "You enter the dark dungeon.";

                generateMonsters();
                generateTreasure();

                //TODO Create start position and exit based on game mode.

                var populateMapHelper:MapPopulater = new MapPopulater(map);
                populateMapHelper.populateMap.apply(this, monsters);
                populateMapHelper.populateMap.apply(this, chests);

                var exitPosition:Point = populateMapHelper.getRandomEmptyPoint();
                map.swapTile(exitPosition, "E");

                if(activeGameState.gameType != GameModeOptions.ESCAPE)
                {
                    activeGameState.startPositionPoint = exitPosition;
                }
                else
                {
                    //TODO need to loop through all random points and find the longest one from the exit
                    activeGameState.startPositionPoint = populateMapHelper.getRandomEmptyPoint();
                }
                activeGameState.cashPool = 100;
                activeGameState.cashRange = 10;

                activeGameState.map = map.toObject();
            }

            trace("Map Size", map.width, map.height, "was generated");

        }

        private function generateTreasure():void
        {

            // Config stuff
            var emptyTreasureChests:Boolean = true;
            var trapTreasureChests:Boolean = false;

            var totalChests:int = Math.floor((Math.random() * monsters.length) + .1);
            var treasurePool:Array = [];

            // These are the types of treasure in the game
            var treasureTypes:Array = ["$","P"];

            if(emptyTreasureChests)
                treasureTypes.push("K");

            if(emptyTreasureChests)
                treasureTypes.push(" ");

            var treasureTypesTotal:int = treasureTypes.length;

            // Calculate the amount of treasure based on the total monsters in the game
            var treasurePoolTotal:int = Math.floor((Math.random() * monsters.length) + .1);

            var i:int;
            //var treasureChestTotal:int = treasurePoolTotal *
            for(i =0; i < treasurePoolTotal; i ++)
            {

                treasurePool.push(treasureTypes[Math.floor((Math.random() * treasureTypesTotal))]);
                if(i < totalChests)
                {
                    chests.push("T");
                }
            }

            activeGameState.treasurePool = treasurePool;
            trace("Treasure Pool", treasurePool.length, "in", chests.length, "values", treasurePool.toString());

        }

        private function generateMonsters():void
        {
            var monsterTypes:Array = ["1","2","3","4","5","6","7","8"];
            var monsterPercentage:Array = [.3,.2,.1, .1, .05, .02, .02, .01];
            var totalMonsterPercent:Number = .05;
            var i:int = 0;
            var j:int = 0;
            var total:int = monsterTypes.length;
            var monsterValues:Number;
            var monsterType:int;
            var totalTiles:int = Math.ceil(RandomMap(map).getOpenTiles().length * totalMonsterPercent);

            for(i = 0; i < total; i++)
            {
                //TODO need to look into why the values are sometimes larger then what they really are.
                monsterValues = Math.floor(monsterPercentage[i] * totalTiles);
                monsterType = monsterTypes[i] ;
                //trace("MonsterType", monsterType, "monsterValues", monsterValues);
                for(j = 0; j < monsterValues; j++)
                {

                    monsters.push(monsterType);
                }
            }

            if(activeGameState.gameType == GameModeOptions.KILL_BOSS)
            {
                monsters.push("9");
                trace("Boss was added to level");
            }

            //trace("Created ", monsters.length, "monsters from ", totalTiles, "/", Math.floor(RandomMap(map).getOpenTiles().length), "possible tiles.\n Total treasure chests", data.chests);
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

            createDarknessTiles();

        }

        private function createDarknessTiles():void
        {
            var i:int = 0;
            var total:int = 10;
            var bitmapData:BitmapData = new BitmapData(TILE_SIZE, TILE_SIZE, true, 0xFF000000);
            var rect:Rectangle = new Rectangle(0, 0, TILE_SIZE, TILE_SIZE);

            for (i = 0; i < total; i ++)
            {
                bitmapData.fillRect(rect, returnARGB(0x000000, i * 20));
                spriteSheet.cacheSprite("light"+i, bitmapData.clone());
            }

            // Black Tile
            bitmapData.fillRect(rect, 0x00000000);
            spriteSheet.cacheSprite("light10", bitmapData.clone());

        }

        private function returnARGB(rgb:uint, newAlpha:uint):uint{
          //newAlpha has to be in the 0 to 255 range
          var argb:uint = 0;
          argb += (newAlpha<<24);
          argb += (rgb);
          return argb;
        }

        override public function onStart():void
        {
            soundManager.playMusic(TCSoundClasses.DungeonLooper, .5);
            super.onStart();
        }

        override public function update(elapsed:Number = 0):void
        {
            textCounter += elapsed;

            if(label.text.length > 11)
            {
                label.text = LOADING_TEXT;
            }


            if (textCounter >= textDelay)
            {
                textCounter = 0;
                label.text += ".";
            }


            super.update(elapsed);
        }

        override public function loadState(obj:Object):void
        {
            activeGameState.load();
        }

        override public function saveState(obj:Object, activeState:Boolean = true):void
        {
            activeGameState.save();
        }
    }
}
