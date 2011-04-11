/**
 * ...
 * @author Jeff Fulton
 * @version 0.1
 */

package  com.gamecook.tilecrusader.utils
{
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.events.*;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.Timer;

    public class FrameCounter
    {
        private var format:TextFormat = new TextFormat();
        private var messageText:String;
        private var messageBitmapData:BitmapData;
        private var messageTextField:TextField = new TextField();
        public var frameTimer:Timer;
        public var framesCounted:int = 0;
        public var parent:MovieClip;
        public var x:int;
        public var y:int;
        public var canvasBD:BitmapData;
        public var messagePoint:Point;
        public var messageRect:Rectangle;


        public function FrameCounter():void
        {
            /*x=xval;
             y=yval;
             canvasBD=canvasval;*/
            format.size = 12;
            format.font = "Arial";
            format.color = "0xffffff";
            format.bold = true;
            messageText = "0";
            messageTextField.text = messageText;
            messageTextField.setTextFormat(format);
            //messageTextField.width=(messageText.length+2)*int(format.size);
            messageTextField.width = 30;
            //messageTextField.height=int(format.size)*2;
            messageTextField.height = 20;
            messageBitmapData = new BitmapData(messageTextField.width, messageTextField.height, true, 0xffff0000);
            //parent=parentVal;
            frameTimer = new Timer(1000, 0);
            frameTimer.addEventListener(TimerEvent.TIMER, frameCounter, false, 0, true);
            frameTimer.start();
            messagePoint = new Point(x, y);
            messageRect = new Rectangle(0, 0, messageTextField.width, messageTextField.height);

        }

        public function frameCounter(e:TimerEvent):void
        {
            messageText = framesCounted.toString();
            trace("FPS", messageText);
            //trace("frameRate:" + framesCounted.toString());
            framesCounted = 0;
        }

        public function toString():String
        {
            return "FPS" + messageText;
        }

        public function countFrames():void
        {
            framesCounted++;
        }

    } // end class

} // end package