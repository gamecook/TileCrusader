/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 9:58 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.gamecook.frogue.maps.MapAnalytics;
    import com.gamecook.tilecrusader.effects.Quake;
    import com.gamecook.tilecrusader.effects.TypeTextEffect;
    import com.gamecook.tilecrusader.enum.DarknessOptions;
    import com.gamecook.tilecrusader.enum.TemplateProperties;
    import com.gamecook.tilecrusader.factory.TCTileFactory;
    import com.gamecook.tilecrusader.managers.SingletonManager;
    import com.gamecook.tilecrusader.maps.TCMapSelection;
    import com.gamecook.tilecrusader.sounds.TCSoundClasses;
    import com.gamecook.tilecrusader.states.ActiveGameState;
    import com.gamecook.tilecrusader.templates.Template;
    import com.gamecook.tilecrusader.templates.TemplateCollection;
    import com.gamecook.tilecrusader.templates.TemplateApplicator;
    import com.gamecook.frogue.helpers.MovementHelper;
    import com.gamecook.frogue.io.Controls;
    import com.gamecook.frogue.io.IControl;
    import com.gamecook.frogue.maps.RandomMap;
    import com.gamecook.frogue.renderer.AbstractMapRenderer;
    import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
    import com.gamecook.tilecrusader.combat.CombatHelper;
    import com.gamecook.tilecrusader.enum.GameModeOptions;
    import com.gamecook.frogue.sprites.SpriteSheet;
    import com.gamecook.tilecrusader.renderer.MQMapBitmapRenderer;
    import com.gamecook.tilecrusader.status.DoubleAttackStatus;
    import com.gamecook.tilecrusader.combat.IFight;
    import com.gamecook.tilecrusader.iterators.TreasureIterator;
    import com.gamecook.tilecrusader.managers.TileInstanceManager;
    import com.gamecook.tilecrusader.tiles.PlayerTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;
    import com.gamecook.tilecrusader.views.CharacterSheetView;

    import com.gamecook.tilecrusader.views.VirtualKeysView;

    import com.jessefreeman.factivity.managers.ActivityManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.system.Capabilities;
    import flash.ui.Keyboard;
    import flash.utils.getTimer;

    public class GameActivity extends AdvancedActivity implements IControl
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
        private var tileTypes:TileTypes;
        private var treasureIterator:TreasureIterator;
        //private var monsters:Array;
        private var chests:Array;
        private var gameMode:String;
        private var hasArtifact:Boolean;
        private var spriteSheet:SpriteSheet = SingletonManager.getClassReference(SpriteSheet);
        private var mapBitmap:Bitmap;
        private var mapSelection:TCMapSelection;

        private var display:Sprite;
        private var overlayLayer:Sprite;
        private var statusLabel:Label;
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
        private var monstersDropTreasure:Boolean;
        private var isPlayerDead:Boolean;
        private var templateApplicator:TemplateApplicator;
        private var monsterTemplates:TemplateCollection;
        private var exploredTiles:Number;
        private var activeGameState:ActiveGameState;
        private var analytics:MapAnalytics;
        private var invalidMapAnalytics:Boolean;
        private var monstersLeft:int;

        public function GameActivity(activityManager:ActivityManager, data:* = null)
        {
            super(activityManager, data);
        }

        override protected function onCreate():void
        {

            activeGameState = new ActiveGameState();
            loadState(null);

            super.onCreate();

            display = addChild(new Sprite()) as Sprite;
            overlayLayer = addChild(new Sprite()) as Sprite;

            map = data.mapInstance;
            analytics = new MapAnalytics(map);

            TimeMethodExecutionUtil.execute("updateMapAnalytics", analytics.update);
            var remainingMonsters:int = TimeMethodExecutionUtil.execute("remainingMonsters", analytics.getTotal, "1","2","3","4","5","6","7","8","9");
            trace("Monsters in MapAnalytics", remainingMonsters);


            gameMode = activeGameState.gameType;
            //monsters = activeGameState.monsters;
            treasurePool = activeGameState.treasurePool;
            cashPool = activeGameState.cashPool;
            cashRange = activeGameState.cashRange;
            monstersDropTreasure = activeGameState.monstersDropTreasure;

            // Configure Tile, Render and Darkness size
            tileWidth = tileHeight = TILE_SIZE * scale;
            viewPortWidth = (fullSizeWidth - SIDEBAR_WIDTH);
            viewPortHeight = fullSizeHeight - tileHeight;


            renderWidth = Math.floor(viewPortWidth / tileWidth);
            renderHeight = Math.floor((viewPortHeight- tileHeight) / tileHeight) ;

            darknessWidth = 5;
            darknessHeight = 4;


            mapSelection = new TCMapSelection(map, renderWidth, renderHeight, 3);

            if(activeGameState.mapSelection)
            {
                mapSelection.parseObject(activeGameState.mapSelection);
            }

            // Apply darkness setting
            switch (activeGameState.darkness)
            {
                case DarknessOptions.LONG_RANGE:
                    mapSelection.fullLineOfSight(true);
                break;
                case DarknessOptions.TORCH:
                    mapSelection.tourchMode(true);
                break;
            }


            movementHelper = new MovementHelper(map);

            configureMonsterTemplates();


            tileTypes = new TileTypes();
            tileInstanceManager = new TileInstanceManager(new TCTileFactory(tileTypes, monsterTemplates, templateApplicator, activeGameState.player.characterPoints, 0));

            mapBitmap = new Bitmap(new BitmapData(viewPortWidth/scale, viewPortHeight/scale, false, 0x000000));
            mapBitmap.scaleX = mapBitmap.scaleY = scale;
            mapBitmap.y = MESSAGE_HEIGHT;
            display.addChild(mapBitmap);



            renderer = new MQMapBitmapRenderer(mapBitmap.bitmapData, spriteSheet, tileTypes, tileInstanceManager);

            combatHelper = new CombatHelper();

            if(activeGameState.tileInstanceManager)
                tileInstanceManager.parseObject(activeGameState.tileInstanceManager);

            player = tileInstanceManager.getInstance("@", "@", activeGameState.player) as PlayerTile;

            var characterSheetData:Object = {player:player};

            characterSheet = new CharacterSheetView(activityManager, characterSheetData, onQuit);
            characterSheet.x = viewPortWidth;

            overlayLayer.addChild(characterSheet);

            //TODO need to make this it's own class
            statusLabel = new Label(this, 5, 2, "");
            statusLabel.textField.width = viewPortWidth - 5;
            statusLabel.textField.autoSize = "none";
            statusLabel.textField.height = MESSAGE_HEIGHT;
            statusLabel.textField.multiline = true;
            statusLabel.textField.wordWrap = true;
            statusLabel.x = 5;
            statusLabel.y = 2;
            statusLabel.scaleX = statusLabel.scaleY = 1.5;
            overlayLayer.addChild(statusLabel);

            addStatusMessage(activeGameState.startMessage);

            configureGame();

            //TODO May need to slow this down for mobile
            keyPressDelay = .25 * MILLISECONDS;

            virtualKeys = new VirtualKeysView(this);
            addChild(virtualKeys);
            virtualKeys.x = fullSizeWidth - (virtualKeys.width + 10);
            virtualKeys.y = fullSizeHeight - (virtualKeys.height + 10);

            if(Capabilities.version.substr(0,3) != "IOS")
            {
                quakeEffect = new Quake(display);
                textEffect = new TypeTextEffect(statusLabel.textField, onTextEffectUpdate);
            }

        }

        private function onQuit():void
        {
            //TODO Took this out since it got called twice. May not need this call back.
            //saveState(null);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            switch(event.keyCode)
            {
                case Keyboard.L:
                    cycleThroughLighting();
                    break;
                case Keyboard.P:
                    player.setLife(player.getMaxLife());
                    break;
            }

            invalidate();
        }

        private function cycleThroughLighting():void
        {
            var types:Array = [DarknessOptions.LONG_RANGE, DarknessOptions.REVEAL, DarknessOptions.TORCH, DarknessOptions.NONE];
            var id:int = types.indexOf(activeGameState.darkness);
            id ++;
            if(id >= types.length)
                id = 0;
            var lightingFlags:Array;
            activeGameState.darkness = types[id];
            if(id == 0)
            {
                lightingFlags = [false, false, false];
            }else if (id == 1)
            {
                lightingFlags = [false, true, false];
            }
            else if (id == 2)
            {
               lightingFlags = [true, false, false];
            }
            else
            {
                lightingFlags = [false, false, true];
            }

            mapSelection.tourchMode(lightingFlags[0]);
            mapSelection.fullLineOfSight(lightingFlags[1]);
            mapSelection.revealAll(lightingFlags[2]);

            statusLabel.text = "Changing lighting mode "+activeGameState.darkness;
        }
        private function configureMonsterTemplates():void
        {
            templateApplicator = new TemplateApplicator();
            monsterTemplates = new TemplateCollection();

            monsterTemplates.addTemplate("1", new Template("Regular", [TemplateProperties.LIFE, TemplateProperties.ATTACK, TemplateProperties.DEFENSE, TemplateProperties.LIFE]), 30);
            monsterTemplates.addTemplate("2", new Template("Tank", [TemplateProperties.LIFE, TemplateProperties.DEFENSE, TemplateProperties.LIFE, TemplateProperties.ATT_DEF]),4);
            monsterTemplates.addTemplate("3", new Template("Chaos", [TemplateProperties.RANDOM]),1);
            monsterTemplates.addTemplate("4", new Template("Brute", [TemplateProperties.ATTACK, TemplateProperties.ATTACK, TemplateProperties.DEFENSE, TemplateProperties.LIFE]),3);
            monsterTemplates.addTemplate("5", new Template("Attack Specialist", [TemplateProperties.ATTACK, TemplateProperties.ATTACK, TemplateProperties.LIFE, TemplateProperties.DEFENSE]),2);
            monsterTemplates.addTemplate("6", new Template("Defense Specialist", [TemplateProperties.DEFENSE, TemplateProperties.DEFENSE, TemplateProperties.LIFE, TemplateProperties.ATTACK]),2);
            monsterTemplates.addTemplate("7", new Template("Life Specialist", [TemplateProperties.LIFE, TemplateProperties.LIFE, TemplateProperties.LIFE, TemplateProperties.ATT_DEF]),3);
            monsterTemplates.addTemplate("8", new Template("Chaos Specialist", [TemplateProperties.RANDOM, TemplateProperties.LIFE, TemplateProperties.RANDOM, TemplateProperties.ATT_DEF]),1);

        }

        private function onTextEffectUpdate():void
        {
            soundManager.play(TCSoundClasses.TypeSound);
        }

        private function configureGame():void
        {
            //mapSelection.clear();

            //tileInstanceManager.clear();

            characterSheet.setPortrait(spriteSheet.getSprite("sprite6").clone());


            treasureIterator = new TreasureIterator(treasurePool);

            movementHelper.startPosition(activeGameState.startPositionPoint);

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

            if(isPlayerDead)
                return;

            var tmpPoint:Point = movementHelper.previewMove(value.x, value.y);

            if (tmpPoint != null)
            {
                var tile:String = map.getTileType(tmpPoint);

                switch (tileTypes.getTileType(tile))
                {
                    case TileTypes.IMPASSABLE:
                            soundManager.play(TCSoundClasses.WallHit);
                        return;
                    case TileTypes.MONSTER: case TileTypes.BOSS:
                        var uID:String = map.getTileID(tmpPoint.y, tmpPoint.x).toString();

                        var tmpTile:IFight = tileInstanceManager.getInstance(uID, tile) as IFight;

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
                            //TODO play heroic theme here?
                            trace("Level Done");
                            isPlayerDead = true;
                            var newData:Object = {player:{name:player.getName(),
                            maxLife: player.getMaxLife(),
                            attackRoll: player.getAttackRolls(),
                            defenseRoll: player.getDefenceRolls(),
                            maxPotions: player.getMaxPotion(),
                            potions: player.getPotions(),
                            characterPoints:player.getCharacterPoints()}};

                            //TODO save out activeState but remove
                            startNextActivityTimer(FinishMapActivity, 1, newData);
                        }
                        else
                        {
                            //TODO let player leave the level, use a pop up to ask
                            addStatusMessage("You can not leave until you "+GameModeOptions.getGameModeDescription(gameMode))+".";
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
                if(textEffect)
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
                case GameModeOptions.FIND_ALL_TREASURE:
                    success = treasureIterator.hasNext();
                break;
                case GameModeOptions.FIND_ARTIFACT:
                    success = hasArtifact;
                break;
                case GameModeOptions.KILL_ALL_MONSTERS:
                    success = (monstersLeft == 0);
                break;
                case GameModeOptions.KILL_BOSS:
                    var value:int = analytics.getTotal(false, "9");
                    success = (value == 0);
                break;
                case GameModeOptions.EXPLORE:
                    success = (exploredTiles == 1);
                 break;
            }

            return success;
        }

        private function fight(tmpTile:IFight, tmpPoint:Point, uID:String):void
        {
            var status:DoubleAttackStatus = combatHelper.doubleAttack(player, IFight(tmpTile));

            if(quakeEffect)
                addThread(quakeEffect);

            // Run the check to see if the player is dead
            checkIfPlayerIsDead();

            //Check the isPlayerDead flag, if dead exit out of the fight update
            if(isPlayerDead)
                return;

            //TODO keep track of this sound, may need a player hit as well.
            soundManager.play(TCSoundClasses.EnemyAttack);

            // Player is still alive so display combat message
            //TODO this may need to cleaned up and only show combat message when monster is not dead and do different message once killed
            addStatusMessage(status.toString());

            // Test to see if the monster is dead
            if (tmpTile.getLife() <= 0)
            {

                /*var tile:String = map.getTileType(tmpPoint);
                var index:int = monsters.indexOf(Number(tile));
                monsters.splice(index,1);

                trace("Monster", tile, "was killed", monsters.length, "left index",index,  monsters);
*/

                player.addKill();

                soundManager.play(TCSoundClasses.WinBattle);

                swapTileOnMap(tmpPoint, "X");

                if(monstersDropTreasure){
                    var treasure:String = treasureIterator.hasNext() ? treasureIterator.getNext() : "X";
                    if(treasure == "K")
                        treasurePool.push(treasure);
                    else
                        swapTileOnMap(tmpPoint, treasure);
                }

                tileInstanceManager.removeInstance(uID);

            }

        }

        private function openTreasure(tmpPoint:Point):void
        {


            addStatusMessage(player.getName() +" has opened a treasure chest.");

            var treasure:String = treasureIterator.hasNext() ? treasureIterator.getNext() : " ";
            if(treasure == "K")
            {
                addStatusMessage("\nA trap was sprung dealing 1 point of damage.", false);
                player.subtractLife(1);
                if(quakeEffect)
                    addThread(quakeEffect);
                treasure = " ";
            }

            swapTileOnMap(tmpPoint, treasure);
        }

        protected function swapTileOnMap(point:Point, tile:String):void
        {
            map.swapTile(point, tile);
            invalidateMapAnalytics();
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
                if(player.getPotions() < player.getMaxPotion())
                {
                    player.addPotion(1);
                    addStatusMessage(player.getName() +" has picked up a health potion.");
                }
                else
                {
                    if(player.getLife() < player.getMaxLife())
                    {
                        player.setLife(player.getMaxLife());
                        addStatusMessage(player.getName() +" can not carry any more health potions.\nHe was able to drink it now and restore his health.");
                        soundManager.play(TCSoundClasses.PotionSound);
                    }
                    else
                    {
                    addStatusMessage(player.getName() +" can not carry any more health potions.\nThis one was thrown away.");
                    }
                }
            }
            else if (tile == "A")
            {
                hasArtifact = true;
                addStatusMessage(player.getName() +" has found an Artifact.");
            }

            swapTileOnMap(tmpPoint, " ");
            movePlayer(value);
        }

        private function movePlayer(value:Point):void
        {
            movementHelper.move(value.x, value.y);
            player.addStep();
        }

        protected function invalidate():void
        {
            invalid = true;
        }

        override public function update(elapsed:Number = 0):void
        {
            var t:int = getTimer();


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

            if(invalidMapAnalytics)
            {
                TimeMethodExecutionUtil.execute("updateMapAnalytics", analytics.update);

                monstersLeft = TimeMethodExecutionUtil.execute("remainingMonsters", analytics.getTotal, false, "1","2","3","4","5","6","7","8","9");


                trace("Monsters in MapAnalytics", monstersLeft);


                invalidMapAnalytics = false;

            }
            super.update(elapsed);

            exploredTiles = mapSelection.getVisitedTiles()/map.getOpenTiles().length;

            t = (getTimer()-t);

            if(status == "")
                statusLabel.text = "Render executed in " + t + " ms.\n"+Math.round(exploredTiles*100) + "% of the map was explored.", true;

            characterSheet.refresh();
        }

        override protected function render():void
        {
            super.render();

            checkIfPlayerIsDead();

            if (invalid)
            {

                mapSelection.setCenter(movementHelper.playerPosition);
                renderer.renderMap(mapSelection);

                invalid = false;
            }
        }

        private function checkIfPlayerIsDead():void
        {
            if (player.getLife() == 0)
            {

                if (player.getPotions() == 0)
                {
                    addStatusMessage("Player was killed!", true);
                    //stateManager(GameOverActivity);
                    isPlayerDead = true;
                    //TODO build stat Data Object
                    startNextActivityTimer(GameOverActivity, 1);
                }
                else
                {
                    player.setLife(player.getMaxLife());
                    player.subtractPotion();
                    soundManager.play(TCSoundClasses.PotionSound);
                    addStatusMessage("You have taken a potion and restored your health.", true);
                }
            }
        }

        override public function onStart():void
        {
            super.onStart();
            //This needs to be a compiler argument for debug
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

            controls = new Controls(this);

            soundManager.play(TCSoundClasses.WalkStairsSound);
        }

        override public function loadState(obj:Object):void
        {
            activeGameState.load();
        }

        override public function saveState(obj:Object, activeState:Boolean = true):void
        {
            if(!isPlayerDead)
            {
                activeGameState.player = player.toObject();
                activeGameState.tileInstanceManager = tileInstanceManager.toObject();
                activeGameState.mapSelection = mapSelection.toObject();
                activeGameState.startPosition = movementHelper.playerPosition;
                activeGameState.map = map.toObject();
                activeGameState.save();
            }

        }

        override public function onStop():void
        {
            saveState(null);
            super.onStop();
        }

        public function invalidateMapAnalytics():void
        {
            invalidMapAnalytics = true;
        }


    }
}
