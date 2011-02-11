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

    import com.gamecook.frogue.renderer.MapDrawingRenderer;

    import com.gamecook.minutequest.combat.AttackStatus;
    import com.gamecook.minutequest.combat.CombatHelper;
    import com.gamecook.minutequest.combat.DoubleAttackStatus;
    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.factory.TileFactory;
    import com.gamecook.minutequest.managers.TileInstanceManager;
    import com.gamecook.minutequest.tiles.BaseTile;
    import com.gamecook.minutequest.tiles.ITreasure;
    import com.gamecook.minutequest.tiles.PlayerTile;
    import com.gamecook.minutequest.tiles.TileTypes;
    import com.gamecook.minutequest.renderer.MQMapRenderer;
    import com.gamecook.minutequest.views.CharacterSheetView;
    import com.gamecook.util.TimeMethodExecutionUtil;

    import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;

    [SWF(width="800",height="480",backgroundColor="#000000",frameRate="60")]
    public class MinuteQuestApp extends Sprite implements IControl
    {
        public var map:RandomMap;
        private var renderer:MapDrawingRenderer;
        private var renderWidth:int = Math.floor(650/20);
        private var renderHeight:int = 480/20;
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

        /**
		 *
		 */
        public function MinuteQuestApp()
		{

			configureStage();

            var tmpSize:int = 30;

            var t:Number = getTimer();
            map = new RandomMap();
            TimeMethodExecutionUtil.execute("generateMap",map.generateMap, tmpSize);
            trace("Map Size", map.width, map.height);
            trace("Render Size", renderWidth, renderHeight);

            mapSelection = new MapSelection(map, renderWidth, renderHeight);

            populateMapHelper = new PopulateMapHelper(map);
            populateMapHelper.populateMap("G","G","G","O","O","O","F","F","F","C","C","C","S","S","S","Z","Z","Z","M","M","M","L","L","L","T","T","T","T","T","T","T","T","T");

            movementHelper = new MovementHelper(map, populateMapHelper.getRandomEmptyPoint());

            tileInstanceManager = new TileInstanceManager(new TileFactory(new TileTypes()));
            tileTypes = new TileTypes();
            renderer = new MQMapRenderer(this.graphics, new Rectangle(0, 0, 20, 20), tileTypes, tileInstanceManager);

            controls = new Controls(this);

            player = tileInstanceManager.getInstance("@", "@", {life:8, maxLife:8, attackRoll: 3}) as PlayerTile;
            combatHelper = new CombatHelper();

            characterSheet = new CharacterSheetView(player);
            characterSheet.x = 650;
            addChild(characterSheet);

            addEventListener(Event.ENTER_FRAME, onEnterFrame);

		}

        private function onEnterFrame(event:Event):void
        {
            render();
        }

		private function configureStage() : void
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
            if(invalid)
            {
                //TODO there is a bug in renderer that doesn't let you see the last row
                mapSelection.setCenter(movementHelper.playerPosition);
                TimeMethodExecutionUtil.execute("renderMap", renderer.renderMap, mapSelection);
                characterSheet.refresh();
                invalid = false;
            }
        }

        public function move(value:Point):void
        {

            var tmpPoint:Point = movementHelper.previewMove(value.x, value.y);

            if(tmpPoint != null)
            {
                var tile:String = map.getTileType(tmpPoint);
                if (tileTypes.isPassable(tile) || tileTypes.isPickupable(tile))
                {

                    if(tileTypes.isPickupable(tile))
                    {
                        //var tmpTile:BaseTile = tileInstanceManager.getInstance(uID, tile);
                        if(tile == "$")
                        {
                            player.addGold(100);
                        }
                        else if (tile == "P")
                        {
                            player.addPotion(1);
                        }

                        map.swapTile(tmpPoint," ");
                    }

                    movementHelper.move(value.x, value.y);

                    invalidate();
                }
                else if(tileTypes.isMonster(tile))
                {
                    var uID:String = map.getTileID(tmpPoint.y, tmpPoint.x).toString();

                    var tmpTile:BaseTile = tileInstanceManager.getInstance(uID, tile);

                    if(tmpTile is IFight)
                    {
                        trace("Fight");
                        var status:DoubleAttackStatus = combatHelper.doubleAttack(player, IFight(tmpTile));
                        trace(status);
                        if(status.attackStatus.kill)
                        {
                            trace("Monster was killed!");
                            map.swapTile(tmpPoint,"X");
                            tileInstanceManager.removeInstance(uID);

                        }
                        else if(player.getLife() == 0)
                        {
                            trace("Player Died");
                        }
                        invalidate();
                    }

                }
                else if(tileTypes.isTreasure(tile))
                {
                    map.swapTile(tmpPoint,"$");
                    invalidate();
                }
            }
        }

        protected function invalidate():void
        {
            invalid = true;
        }

    }
}
