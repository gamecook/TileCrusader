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
    import com.gamecook.frogue.maps.RandomMap;

    import com.gamecook.frogue.renderer.MapDrawingRenderer;

    import com.gamecook.minutequest.tiles.TileTypes;
    import com.gamecook.minutequest.renderer.MQMapRenderer;
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
        private var renderWidth:int = 800/20;
        private var renderHeight:int = 480/20;
        private var controls:Controls;

        private var populateMapHelper:PopulateMapHelper;
        private var movementHelper:MovementHelper;
        private var invalid:Boolean = true;

        /**
		 *
		 */
        public function MinuteQuestApp()
		{

			configureStage();

            var tmpSize:int = 40;

            var t:Number = getTimer();
            map = new RandomMap();
            TimeMethodExecutionUtil.execute("generateMap",map.generateMap, tmpSize);

            populateMapHelper = new PopulateMapHelper(map);
            populateMapHelper.populateMap("G","G","G","O","O","O","F","F","F","C","C","C","S","S","S","Z","Z","Z","M","M","M","L","L","L","W","W","W");

            movementHelper = new MovementHelper(map, populateMapHelper.getRandomEmptyPoint());
            renderer = new MQMapRenderer(this.graphics, new Rectangle(0, 0, 20, 20), new TileTypes());

            controls = new Controls(this);

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
            var tiles =TimeMethodExecutionUtil.execute("getSurroundingTiles", map.getSurroundingTiles, movementHelper.playerPosition, renderWidth, renderHeight);

            TimeMethodExecutionUtil.execute("renderMap", renderer.renderMap,tiles);
                invalid = false;
            }
        }

        public function move(value:Point):void
        {

            var tmpPoint:Point = movementHelper.previewMove(value.x, value.y);

            if(tmpPoint != null)
            {
                var tile:String = map.getTileType(tmpPoint);
                switch(tile)
                {
                    case " ": case "x":
                        movementHelper.move(value.x, value.y);
                        invalidate();
                        break;
                }
            }
        }

        protected function invalidate():void
        {
            invalid = true;
        }

    }
}
