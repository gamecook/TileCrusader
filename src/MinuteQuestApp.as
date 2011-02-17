/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package
{
    import com.gamecook.frogue.helpers.MovementHelper;
    import com.gamecook.frogue.helpers.PopulateMapHelper;
    import com.gamecook.frogue.io.Controls;
    import com.gamecook.frogue.io.IControl;
    import com.gamecook.frogue.maps.MapSelection;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.AbstractMapRenderer;
    import com.gamecook.minutequest.combat.CombatHelper;
    import com.gamecook.minutequest.enum.GameModes;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.minutequest.map.MapFogOfWar;
    import com.gamecook.minutequest.renderer.MQMapBitmapRenderer;
    import com.gamecook.minutequest.status.DoubleAttackStatus;
    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.factory.TileFactory;
    import com.gamecook.minutequest.factory.TreasureFactory;
    import com.gamecook.minutequest.managers.TileInstanceManager;
    import com.gamecook.minutequest.tiles.BaseTile;
    import com.gamecook.minutequest.tiles.PlayerTile;
    import com.gamecook.minutequest.tiles.TileTypes;
    import com.gamecook.minutequest.views.CharacterSheetView;
    import com.gamecook.util.TimeMethodExecutionUtil;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.Font;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    [SWF(width="800",height="480",backgroundColor="#000000",frameRate="60")]
    public class MinuteQuestApp extends Sprite implements IControl
    {
        [Embed(source="../build/assets/spritesheet_template.png")]
        public static var SpriteSheetImage:Class;

        public var map:RandomMap;
        private var renderer:AbstractMapRenderer;
        private var renderWidth:int;
        private var renderHeight:int;
        private var darknessWidth:int;
        private var darknessHeight:int;
        private var controls:Controls;

        private var populateMapHelper:PopulateMapHelper;
        private var movementHelper:MovementHelper;
        private var invalid:Boolean = true;
        private var player:PlayerTile;
        private var combatHelper:CombatHelper;
        private var tileInstanceManager:TileInstanceManager;
        private var characterSheet:CharacterSheetView;
        private var mapSelection:MapSelection;
        private var tileTypes:TileTypes;
        private var treasureFactory:TreasureFactory;
        private var monsters:Array;
        private var chests:Array;
        private var gameMode:String;
        private var hasArtifact:Boolean;
        private var spriteSheet:SpriteSheet;
        private var mapBitmap:Bitmap;
        private var mapDarkness:MapFogOfWar;
        private var splashScreen:Bitmap;
        private var display:Sprite;
        private var overlayLayer:Sprite;
        private var delayRemoveSplashScreen:Number = 2000;
        private var statusLabel:TextField;
        private var status:String = "";
        private static const TILE_SIZE:int = 20;
        private var scale:int = 2;
        private var tileWidth:int;
        private var tileHeight:int;
        private const SIDEBAR_WIDTH:int = 200;
        private var viewPortWidth:int = 0;
        private var viewPortHeight:int = 0;

        /**
         *
         */
        public function MinuteQuestApp()
        {

            configureStage();

            parseSpriteSheet();

            display = addChild(new Sprite()) as Sprite;
            overlayLayer = addChild(new Sprite()) as Sprite;

            splashScreen = new Bitmap(spriteSheet.getSprite("splashScreen").clone());


            // Configure Tile, Render and Darkness size
            tileWidth = tileHeight = TILE_SIZE * scale;
            viewPortWidth = (stage.stageWidth - SIDEBAR_WIDTH);
            viewPortHeight = stage.stageHeight;


            renderWidth = Math.floor( viewPortWidth / tileWidth);
            renderHeight = Math.floor(viewPortHeight / tileHeight);

            darknessWidth = 5;
            darknessHeight = 4;

            map = new RandomMap();
            mapSelection = new MapSelection(map, renderWidth, renderHeight);
            mapDarkness = new MapFogOfWar(map, mapSelection, darknessWidth, darknessHeight);

            populateMapHelper = new PopulateMapHelper(map);
            treasureFactory = new TreasureFactory();
            movementHelper = new MovementHelper(map);

            tileTypes = new TileTypes();
            tileInstanceManager = new TileInstanceManager(new TileFactory(tileTypes));

            mapBitmap = new Bitmap(new BitmapData(viewPortWidth/scale, viewPortHeight/scale, false, 0xff0000));
            mapBitmap.scaleX = mapBitmap.scaleY = scale;
            display.addChild(mapBitmap);

            renderer = new MQMapBitmapRenderer(mapBitmap.bitmapData, spriteSheet, tileTypes, tileInstanceManager);

            controls = new Controls(this);
//            touchControls = new TouchControls(this, 40, 40, mapSelection);

            combatHelper = new CombatHelper();

            characterSheet = new CharacterSheetView();
            characterSheet.x = viewPortWidth;

            display.addChild(characterSheet);

            statusLabel = new TextField();
            statusLabel.autoSize = TextFieldAutoSize.LEFT;
            statusLabel.width = viewPortWidth;
            statusLabel.multiline = true;
            statusLabel.wordWrap = true;
            statusLabel.embedFonts = true;
            statusLabel.background = true;
            statusLabel.backgroundColor = 0x000000;
            statusLabel.defaultTextFormat = new TextFormat("system", 18, 0xffffff);
            addChild(statusLabel);

            configureGame();


        }

        private function configureGame():void
        {
            addChild(splashScreen);

            tileInstanceManager.clear();


            characterSheet.setPortrait(new Bitmap(spriteSheet.getSprite("sprite5").clone()));

            var tmpSize:int = 40;

            var t:Number = getTimer();

            TimeMethodExecutionUtil.execute("generateMap", map.generateMap, tmpSize);
            trace("Map Size", map.width, map.height);
            trace("Render Size", renderWidth, renderHeight);

            gameMode = GameModes.KILL_BOSS;

            monsters = ["1", "1", "1", "1", "2", "2", "2", "3", "3", "3", "4", "4", "4", "5", "5", "5", "6", "6", "6", "7", "7", "7", "8", "8", "9"];
            chests = ["T", "T", "T", "T", "T", "T", "T", "T", "T"];

            populateMapHelper.indexMap();
            populateMapHelper.populateMap.apply(this, monsters);
            populateMapHelper.populateMap.apply(this, chests);

            treasureFactory.addTreasure("$","$","$","$","P","P","P","P"," "," "," ");

            movementHelper.startPosition(populateMapHelper.getRandomEmptyPoint());


            player = tileInstanceManager.getInstance("@", "@", {life:8, maxLife:8, attackRoll: 3}) as PlayerTile;

            characterSheet.setPlayer(player);

            render();

            removeSplashScreen();

        }

        private function removeSplashScreen():void
        {
            var timer:Timer = new Timer(delayRemoveSplashScreen, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onRemoveSplashScreen);
            timer.start();
        }

        private function onRemoveSplashScreen(event:TimerEvent):void
        {
            event.target.addEventListener(TimerEvent.TIMER_COMPLETE, onRemoveSplashScreen);

            removeChild(splashScreen);

            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function parseSpriteSheet():void
        {
            spriteSheet = new SpriteSheet();

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

        private function onEnterFrame(event:Event):void
        {

            render();
        }

        private function configureStage():void
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
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

        public function render():void
        {
            if (invalid)
            {
                var t:int = getTimer();

                //TODO there is a bug in renderer that doesn't let you see the last row
                mapDarkness.setCenter(movementHelper.playerPosition);
                renderer.renderMap(mapSelection);
                characterSheet.refresh();

                if(status != "")
                {
                    statusLabel.text = status;
                    status = "";
                }
                else
                {
                    statusLabel.text = "";
                }
                invalid = false;

                t = (getTimer()-t);
                trace("Render executed in " + t + " ms\n");
            }
        }

        public function move(value:Point):void
        {

            var tmpPoint:Point = movementHelper.previewMove(value.x, value.y);

            if (tmpPoint != null)
            {
                var tile:String = map.getTileType(tmpPoint);

                switch (tileTypes.getTileType(tile))
                {
                    case TileTypes.IMPASSABLE:
                        return;
                    case TileTypes.MONSTER: case TileTypes.BOSS:
                        var uID:String = map.getTileID(tmpPoint.y, tmpPoint.x).toString();

                        var tmpTile:BaseTile = tileInstanceManager.getInstance(uID, tile);

                        if (tmpTile is IFight)
                        {
                            fight(tmpTile, tmpPoint, uID);
                        }
                        break;
                    case TileTypes.TREASURE:
                        openTreasure(tmpPoint);
                        break;
                    case TileTypes.PICKUP: case TileTypes.ARTIFACT:
                        pickup(tile, tmpPoint, value);
                        break;
                    case TileTypes.EXIT:
                        movePlayer(value);
                        if(canFinishLevel())
                        {
                            //TODO gameover
                            trace("Level Done");
                            configureGame();
                        }
                        else
                        {
                            addStatusMessage("You can not exit the level you, you have not completed the goal.");
                        }
                        break;
                    default:
                        movePlayer(value);
                        break;
                }
                invalidate();
            }
        }

        public function addStatusMessage(value:String, clear:Boolean = true):void
        {
            if(clear)
                status = "";
            status += value
        }
        
        private function canFinishLevel():Boolean
        {
            var success:Boolean;

            switch(gameMode)
            {
                case GameModes.FIND_ALL_TREASURE:
                    success = treasureFactory.hasNext();
                break;
                case GameModes.FIND_ARTIFACT:
                    success = hasArtifact;
                break;
                case GameModes.KILL_ALL_MONSTERS:
                    success = (monsters.length == 0);
                break;
                case GameModes.KILL_BOSS:
                    success = (monsters.indexOf("9") == -1);
                break;

            }

            return success;
        }

        private function fight(tmpTile:BaseTile, tmpPoint:Point, uID:String):void
        {
            var status:DoubleAttackStatus = combatHelper.doubleAttack(player, IFight(tmpTile));

            addStatusMessage(status.toString());

            if (status.attackStatus.kill)
            {
                var tile:String = map.getTileType(tmpPoint);
                monsters.splice(monsters.indexOf(tile),1);
                trace("Monsters Left", monsters.length, "Removed", tile, monsters);

                map.swapTile(tmpPoint, "X");
                tileInstanceManager.removeInstance(uID);

            }
            else if (player.getLife() == 0)
            {
                trace("Restart Game");
                addStatusMessage("Player was killed!", false);
            }
        }

        private function openTreasure(tmpPoint:Point):void
        {

            var treasure:String = treasureFactory.nextTreasure();

            addStatusMessage(player.getName() +" has opened a treasure chest.");

            map.swapTile(tmpPoint, treasure);
        }

        private function pickup(tile:String, tmpPoint:Point, value:Point):void
        {
            if (tile == "$")
            {
                player.addGold(100);
            }
            else if (tile == "P")
            {
                player.addPotion(1);
                addStatusMessage(player.getName() +" has picked up a health potion.");
            }
            else if (tile == "T")
            {
                trace("Trap");
            }
            else if (tile == "A")
            {
                hasArtifact = true;
                addStatusMessage(player.getName() +" has found an Artifact.");
            }

            map.swapTile(tmpPoint, " ");
            movePlayer(value);
        }

        private function movePlayer(value:Point):void
        {
            movementHelper.move(value.x, value.y);
        }

        protected function invalidate():void
        {
            invalid = true;
        }

    }
}
