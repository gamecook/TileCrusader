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
    import com.gamecook.frogue.helpers.PopulateMapHelper;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.enum.ApplicationShareObjects;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
    import com.jessefreeman.factivity.activities.BaseActivity;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.net.SharedObject;
    import flash.utils.getQualifiedClassName;

    public class MapLoadingActivity extends AdvancedActivity
    {
        [Embed(source="../../../../../build/assets/spritesheet_template.png")]
        public static var SpriteSheetImage:Class;

        private var splashScreen:Bitmap;
        private var spriteSheet:SpriteSheet;
        private var activeStateSO:SharedObject;
        private var map:RandomMap;

        public function MapLoadingActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            activeStateSO = SharedObject.getLocal(ApplicationShareObjects.ACTIVE_GAME);
            data = activeStateSO.data;

            parseSpriteSheet();

            //TODO need to clean this up so it covers up the display correctly.
            splashScreen = new Bitmap(spriteSheet.getSprite("splashScreen").clone());
            splashScreen.scaleX = splashScreen.scaleY = fullSizeWidth / splashScreen.width;
            splashScreen.y = (fullSizeHeight - splashScreen.height) * .5;

            addChild(splashScreen);

            createMap();

            data.lastActivity = getQualifiedClassName(MapLoadingActivity).replace("::", ".");
            activeStateSO.flush();

            data.mapInstance = map;

            startNextActivityTimer(GameActivity, 2, data);
        }

        private function createMap():void
        {
            map = new RandomMap();

            if (data.map)
            {
                map.tiles = data.map.tiles;
            }
            else
            {
                TimeMethodExecutionUtil.execute("generateMap", map.generateMap, data.size);

                data.startMessage = "You enter the dark dungeon.";

                generateMonsters();
                generateTreasure();

                var populateMapHelper:PopulateMapHelper = new PopulateMapHelper(map);
                populateMapHelper.populateMap.apply(this, data.monsters);
                populateMapHelper.populateMap.apply(this, data.chests);

                data.startPosition = populateMapHelper.getRandomEmptyPoint();

                data.cashPool = 100;
                data.cashRange = 10;

                data.map = map.toObject();
            }

            trace("Map Size", map.width, map.height, "was generated");

        }

        private function generateTreasure():void
        {

            // Config stuff
            var emptyTreasureChests:Boolean = true;
            var trapTreasureChests:Boolean = false;

            var totalChests:int = Math.floor((Math.random() * data.monsters.length) + .1);
            var chests:Array = [];
            var treasurePool:Array = [];

            // These are the types of treasure in the game
            var treasureTypes:Array = ["$","P"];

            if(emptyTreasureChests)
                treasureTypes.push("K");

            if(emptyTreasureChests)
                treasureTypes.push(" ");

            var treasureTypesTotal:int = treasureTypes.length;

            // Calculate the amount of treasure based on the total monsters in the game
            var treasurePoolTotal:int = Math.floor((Math.random() * data.monsters.length) + .1);

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


            data.chests = chests;
            data.treasurePool = treasurePool;
            trace("Treasure Pool", treasurePool.length, "in", chests.length, "values", treasurePool.toString());

        }

        private function generateMonsters():void
        {
            var monsterTypes:Array = ["1","2","3","4","5","6","7","8"];
            var monsterPercentage:Array = [.3,.2,.1, .1, .05, .02, .02, .01];
            var monsters:Array = [];
            var totalMonsterPercent:Number = .05;
            var i:int = 0;
            var j:int = 0;
            var total:int = monsterTypes.length;
            var monsterValues:Number;
            var monsterType:int;
            var totalTiles:int = Math.floor(RandomMap(map).getOpenTiles().length * totalMonsterPercent);

            for(i = 0; i < total; i++)
            {
                monsterValues = Math.ceil(monsterPercentage[i] * totalTiles);
                monsterType = monsterTypes[i] ;

                for(j = 0; j < monsterValues; j++)
                {

                    monsters.push(monsterType);
                }
            }

            if(data.gameType == GameModeOptions.KILL_BOSS)
            {
                monsters.push("9");
                trace("Boss was added to level");
            }

            data.monsters = monsters;

            trace("Created ", monsters.length, "monsters from ", totalTiles, "/", Math.floor(RandomMap(map).getOpenTiles().length), "possible tiles.\n Total treasure chests", data.chests);
        }

        private function parseSpriteSheet():void
        {
            spriteSheet = SingletonManager.getClassReference(SpriteSheet);
            spriteSheet.clear();

            // create sprite sheet
            var bitmap:Bitmap = new SpriteSheetImage();
            spriteSheet.bitmapData = bitmap.bitmapData;
            spriteSheet.registerSprite("splashScreen", new Rectangle(0, 0, 800, 480));

            var i:int;
            var rows:int = Math.floor(bitmap.height / 20);
            var total:int = Math.floor((bitmap.width - 800) / 20) * (bitmap.height / 20);
            var spriteRect:Rectangle = new Rectangle(800, 0, 20, 20);
            for (i = 0; i < total; ++i)
            {
                spriteSheet.registerSprite("sprite" + i, spriteRect.clone());
                spriteRect.y += 20;
                if (i % rows == (rows - 1))
                {
                    spriteRect.x += 20;
                    spriteRect.y = 0;
                }
            }
        }

        override public function onStart():void
        {
            soundManager.playMusic(TCSoundClasses.DungeonLooper, .5);
            super.onStart();
        }
    }
}
