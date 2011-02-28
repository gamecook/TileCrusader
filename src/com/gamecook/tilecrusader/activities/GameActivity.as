/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:58 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.gamecook.tilecrusader.effects.Quake;
    import com.gamecook.tilecrusader.effects.TypeTextEffect;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.gamecook.frogue.helpers.MovementHelper;
    import com.gamecook.frogue.helpers.PopulateMapHelper;
    import com.gamecook.frogue.io.Controls;
    import com.gamecook.frogue.io.IControl;
    import com.gamecook.frogue.maps.FogOfWarMapSelection;
    import com.gamecook.frogue.maps.MapSelection;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.AbstractMapRenderer;
    import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
    import com.gamecook.tilecrusader.combat.CombatHelper;
    import com.gamecook.tilecrusader.enum.GameModes;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.renderer.MQMapBitmapRenderer;
    import com.gamecook.tilecrusader.status.DoubleAttackStatus;
    import com.gamecook.tilecrusader.combat.IFight;
    import com.gamecook.tilecrusader.factory.TileFactory;
    import com.gamecook.tilecrusader.iterators.TreasureIterator;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.tiles.BaseTile;
    import com.gamecook.tilecrusader.tiles.PlayerTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;
    import com.gamecook.tilecrusader.views.CharacterSheetView;

    import com.gamecook.tilecrusader.views.VirtualKeysView;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getTimer;

    public class GameActivity extends BaseActivity implements IControl
    {


        public var map:RandomMap;
        private var renderer:AbstractMapRenderer;
        private var renderWidth:int;
        private var renderHeight:int;
        private var darknessWidth:int;
        private var darknessHeight:int;
        private var controls:Controls;
        private var movementHelper:MovementHelper;
        private var invalid:Boolean = true;
        private var player:PlayerTile;
        private var combatHelper:CombatHelper;
        private var tileInstanceManager:TileInstanceManager;
        private var characterSheet:CharacterSheetView;
        private var mapSelection:MapSelection;
        private var tileTypes:TileTypes;
        private var treasureIterator:TreasureIterator;
        private var monsters:Array;
        private var chests:Array;
        private var gameMode:String;
        private var hasArtifact:Boolean;
        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);
        private var mapBitmap:Bitmap;
        private var mapDarkness:FogOfWarMapSelection;

        private var display:Sprite;
        private var overlayLayer:Sprite;
        private var statusLabel:TextField;
        private var status:String = "";
        private static const TILE_SIZE:int = 20;
        private var scale:int = 2;
        private var tileWidth:int;
        private var tileHeight:int;
        private const SIDEBAR_WIDTH:int = 200;
        private var viewPortWidth:int = 0;
        private var viewPortHeight:int = 0;
        private const MESSAGE_HEIGHT:int = 40;
        private var cashPool:int = 0;
        private var cashRange:int = 10;
        private var virtualKeys:VirtualKeysView;
        private var treasurePool:Array;
        private var quakeEffect:Quake;
        private var textEffect:TypeTextEffect;

        private var pollKeyPressCounter:int = 0;
        private var keyPressDelay:int = 0;
        private var _nextMove:Point;

        public function GameActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            display = addChild(new Sprite()) as Sprite;
            overlayLayer = addChild(new Sprite()) as Sprite;

            map = data.map;
            gameMode = data.gameType;
            monsters = data.monsters;
            treasurePool = data.treasuePool;
            cashPool = data.cashPool;
            cashRange = data.cashRange;


            // Configure Tile, Render and Darkness size
            tileWidth = tileHeight = TILE_SIZE * scale;
            viewPortWidth = (fullSizeWidth - SIDEBAR_WIDTH);
            viewPortHeight = fullSizeHeight - tileHeight;


            renderWidth = Math.floor(viewPortWidth / tileWidth);
            renderHeight = Math.floor(viewPortHeight / tileHeight);

            darknessWidth = 5;
            darknessHeight = 4;


            mapSelection = new MapSelection(map, renderWidth, renderHeight);
            mapDarkness = new FogOfWarMapSelection(map, mapSelection, darknessWidth, darknessHeight);



            movementHelper = new MovementHelper(map);

            tileTypes = new TileTypes();
            tileInstanceManager = new TileInstanceManager(new TileFactory(tileTypes));

            mapBitmap = new Bitmap(new BitmapData(viewPortWidth/scale, viewPortHeight/scale, false, 0xff0000));
            mapBitmap.scaleX = mapBitmap.scaleY = scale;
            mapBitmap.y = MESSAGE_HEIGHT;
            display.addChild(mapBitmap);



            renderer = new MQMapBitmapRenderer(mapBitmap.bitmapData, spriteSheet, tileTypes, tileInstanceManager);

            combatHelper = new CombatHelper();

            player = tileInstanceManager.getInstance("@", "@", {life:8, maxLife:8, attackRoll: 3}) as PlayerTile;

            var characterSheetData:Object = {player:player};

            characterSheet = new CharacterSheetView(stateManager, characterSheetData);
            characterSheet.x = viewPortWidth;

            display.addChild(characterSheet);

            //TODO need to make this it's own class
            statusLabel = new TextField();
            statusLabel.width = viewPortWidth - 5;
            statusLabel.height = MESSAGE_HEIGHT;
            statusLabel.multiline = true;
            statusLabel.wordWrap = true;
            statusLabel.embedFonts = true;
            statusLabel.background = true;
            statusLabel.backgroundColor = 0x000000;
            statusLabel.x = 5;
            statusLabel.y = 2;
            statusLabel.defaultTextFormat = new TextFormat("system", 14, 0xffffff);
            addChild(statusLabel);

            configureGame();

            //TODO May need to slow this down for mobile
            keyPressDelay = .25 * MILLISECONDS;

            virtualKeys = new VirtualKeysView(this);
            addChild(virtualKeys);
            virtualKeys.x = fullSizeWidth - (virtualKeys.width + 10);
            virtualKeys.y = fullSizeHeight - (virtualKeys.height + 10);

            quakeEffect = new Quake(mapBitmap);
            textEffect = new TypeTextEffect(statusLabel, onTextEffectFinish);
        }

        private function onTextEffectFinish():void
        {
            // Clear status since it has been printed to the screen.
            //status = "";
        }

        private function configureGame():void
        {
            mapDarkness.clear();

            tileInstanceManager.clear();

            characterSheet.setPortrait(spriteSheet.getSprite("sprite6").clone());


            treasureIterator = new TreasureIterator(treasurePool);

            movementHelper.startPosition(data.startPosition);





            characterSheet.setPlayer(player);

        }

        //TODO need to clean up movement so it only happens once per second
        public function up():void
        {
            nextMove(MovementHelper.UP);
        }

        public function down():void
        {
            nextMove(MovementHelper.DOWN);
        }

        public function right():void
        {
            nextMove(MovementHelper.RIGHT);
        }

        public function left():void
        {
            nextMove(MovementHelper.LEFT);
        }

        private function nextMove(value:Point):void
        {
            _nextMove = value;
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
                            addStatusMessage("You can not leave until you "+GameModes.getGameModeDescription(gameMode))+".";
                        }
                        break;
                    default:
                        movePlayer(value);
                        break;
                }
                invalidate();
            }
           if(status.length > 0)
           {
                textEffect.newMessage(status, 2);
                 addThread(textEffect);
                status = "";
           }
            else
           {
               statusLabel.text = status;
           }
        }

        public function addStatusMessage(value:String, clear:Boolean = true):void
        {
            if(clear)
                status = "";
            status += value;
        }

        private function canFinishLevel():Boolean
        {
            var success:Boolean;

            switch(gameMode)
            {
                case GameModes.FIND_ALL_TREASURE:
                    success = treasureIterator.hasNext();
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

            addThread(quakeEffect);

            addStatusMessage(status.toString());

            if (status.attackStatus.kill)
            {
                var tile:String = map.getTileType(tmpPoint);
                monsters.splice(monsters.indexOf(tile),1);

                player.addKill();

                map.swapTile(tmpPoint, "X");
                tileInstanceManager.removeInstance(uID);



            }
            else if (player.getLife() == 0)
            {

                if(player.getPotions() == 0)
                {
                    addStatusMessage("Player was killed!", true);
                    stateManager.setCurrentActivity(GameOverActivity);
                }
                else
                {
                    player.setLife(player.getMaxLife());
                    player.subtractPotion();
                    addStatusMessage("You have taken a potion and restored your health.", true);
                }
            }
        }

        private function openTreasure(tmpPoint:Point):void
        {


            addStatusMessage(player.getName() +" has opened a treasure chest.");

            var treasure:String = treasureIterator.hasNext() ? treasureIterator.getNext() : " ";

            map.swapTile(tmpPoint, treasure);
        }

        private function pickup(tile:String, tmpPoint:Point, value:Point):void
        {
            if (tile == "$")
            {
                var foundGold:int = Math.random() * cashRange;

                if(foundGold > cashPool)
                    foundGold = cashPool;

                cashPool -= foundGold;

                player.addGold(foundGold);

                addStatusMessage(player.getName() +" has picked up $"+foundGold+" gold.");
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

        override public function update(elapsed:Number = 0):void
        {
            if(virtualKeys)
                virtualKeys.update(elapsed);

            pollKeyPressCounter += elapsed;
            if(pollKeyPressCounter >= keyPressDelay)
            {
                pollKeyPressCounter = 0;
                if(_nextMove)
                {
                    move(_nextMove);
                    _nextMove = null
                }
            }

            super.update(elapsed);

        }

        override protected function render():void
        {
            super.render();

            if (invalid)
            {
                var t:int = getTimer();

                //TODO there is a bug in renderer that doesn't let you see the last row
                mapDarkness.setCenter(movementHelper.playerPosition);
                renderer.renderMap(mapSelection);
                characterSheet.refresh();

                invalid = false;

                t = (getTimer()-t);

                if(status == "")
                    addStatusMessage("Render executed in " + t + " ms\n", true);
            }
        }

        override public function onStart():void
        {
            super.onStart();

            controls = new Controls(this);
        }
    }
}
