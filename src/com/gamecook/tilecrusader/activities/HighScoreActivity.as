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
 * Date: 3/4/11
 * Time: 11:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.activities
{
    import com.bit101.components.Label;
    import com.gamecook.tilecrusader.scores.TileCrusaderScoreboard;
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.managers.IActivityManager;

    public class HighScoreActivity extends BaseActivity
    {
        private var scores:Array;
        private var highScored:Boolean = false;
        private var newScore:Object;
        private var newScorePosition:Number = -1;

        private var whichInitial:Number = 0;//the index of the initial being input, 0 through 2
        private var whichLetter:Number = 1;//what the current letter is, 0 through 26

        private var leftArrow:Label, rightArrow:Label, upArrow:Label, downArrow:Label;

        private var newInitials:Array;
        private var letterPreview:Label;
        private var scoreboard:TileCrusaderScoreboard;

        public function HighScoreActivity(stateManager:IActivityManager, data:*)
        {
            super(stateManager, data);
        }


        override protected function onCreate():void
        {
            super.onCreate();

            scoreboard = new TileCrusaderScoreboard();
            scores = scoreboard.scores;

            var score:Object;

            newInitials = [];

            highScored = scoreboard.canSubmitScore(playerScore);

            textItem = new Label(this, 0, fullSizeHeight / 6, "SCORE RANKING");

            //TODO need to generate score here
            var playerScore:int = 100;//FlxG.score;
            var xpos:Number;
            var i:int;
            var totalScores:int = TileCrusaderScoreboard.MAX_SCORES;

            //find out if scores can be inserted at the beginning
            if (!scores[0]) {
                score = {score:playerScore, initials:""};
                scores.push(score);
                newScore = score;
                highScored = true;
                newScorePosition = 0;
            }

            //first loop: find out if scores can be inserted in middle
            for (i = 0; i < totalScores; i++) {
                score = scores[i];
                if (highScored)
                    break; else if (score.score <= playerScore) {
                    score = {score:playerScore, initials:""};
                    newScorePosition = i;
                    scores.splice(i, 0, score);
                    if (totalScores > 10)
                        scores.pop();
                    highScored = true;
                    newScore = score;
                    break;
                }
            }

            //find out if scores can be inserted at end
            if (!highScored && totalScores < 5) {
                score = {score:playerScore, initials:""};
                scores.push(score);
                newScorePosition = totalScores - 1;
                highScored = true;
                newScore = score;
            }

            var ypos:int = textItem.y + textItem.height + 20;

            //second loop lay out the current high scores.
            for (i = 0; i < totalScores; i++) {
                var scoreObj:Object = scores[i];
                //display the current scores.

                var color:uint = (i == newScorePosition) ? 0xc83fbb : 0xffffff

                textItem = new Label(this, 140, ypos, (i + 1).toString());

                xpos = (textItem.x - textItem.width) + 30;

                //initials - loop to position each separately.
                for (var j:Number = 0; j < 3; j++) {

                    textItem = new Label(this, xpos, ypos, scoreObj.initials.charAt(j));
                    //new high scores forms gets colored red.
                    if (i == newScorePosition) {
                        textItem.textField.textColor = color;
                        newInitials.push(textItem);
                    } else
                        textItem.textField.textColor = color;

                    xpos += 20;
                }

                //scores
                textItem = new Label(this, xpos, ypos, scoreObj.score.toString());

                ypos += 20;

            }


            if (highScored) {
                var textItem:Label;


                letterPreview = new Label(this, (fullSizeWidth - 100 ) * .5, 500, "_");
                letterPreview.textField.textColor = 0xc83fbb

                //add in arrows for displaying position and possible motions
                leftArrow = new Label(null, (letterPreview.x - letterPreview.width) - 50, letterPreview.y + 10, " ");
                leftArrow.textField.textColor = 0xc83fbb

                /*rightArrow = new FlxText(letterPreview.right, letterPreview.y + 10, 200, " ");
                 rightArrow.textField.textColor = 0xc83fbb

                 upArrow = new FlxText(letterPreview.left, letterPreview.top - 60, 100, "+");
                 upArrow.textField.textColor = 0xc83fbb

                 downArrow = new FlxText(letterPreview.left, letterPreview.bottom - 30, 100, "-")
                 downArrow.textField.textColor = 0xc83fbb

                 textItem = new FlxText(0, upArrow.top - 30, FlxG.width, "ENTER YOUR INITIALS");
                 textItem.setFormat(null, 15, 0xc83fbb, "center", 0);
                 add(textItem);

                 textItem = new FlxText(0, downArrow.bottom, FlxG.width, "USE JOYSTICK TO SELECT LETTER");
                 textItem.setFormat(null, 15, 0xc83fbb, "center", 0);
                 add(textItem);*/

            } else {
                //TODO Need to add something here so you don't accidentally click through the next screen.
                nextActivity(StartActivity);
            }
        }

        override public function update(elapsed:Number = 0):void
        {
            /*if (highScored)
             {
             var str:String = newScore.initials;

             var clkX:Number = FlxG.mouse.x;
             var clkY:Number = FlxG.mouse.y;

             //figure out what motion needs to be done
             var letterUp:Boolean = FlxG.keys.justPressed("UP") || (FlxG.mouse.justPressed() && clkY < letterPreview.top && clkX > letterPreview.left && clkX < letterPreview.right);

             var letterDown:Boolean = FlxG.keys.justPressed("DOWN") || (FlxG.mouse.justPressed() && clkY > letterPreview.bottom && clkX > letterPreview.left && clkX < letterPreview.right);

             var letterLeft:Boolean = whichInitial > 0 && (FlxG.keys.justPressed("LEFT") || (FlxG.mouse.justPressed() && clkX < letterPreview.left));

             var letterRight:Boolean = whichInitial < 2 && (FlxG.keys.justPressed("RIGHT") || FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && clkX > letterPreview.right));

             var doneEdit:Boolean = whichInitial == 2 && (FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && clkX > letterPreview.right));

             //perform said motions
             if (letterUp)
             whichLetter = (whichLetter + 1) % 27; else if (letterDown)
             whichLetter = (whichLetter + 26) % 27; else if (letterLeft)
             {
             whichInitial--;
             whichLetter = str.charCodeAt(whichInitial) - 64;
             if (whichLetter < 0)
             whichLetter = 1;
             } else if (letterRight)
             {
             whichInitial++;
             whichLetter = str.charCodeAt(whichInitial) - 64;
             if (whichLetter < 0)
             whichLetter = 1;
             } else if (doneEdit)
             {
             scoreboard.scores = scores;
             FlxG.state = new CreditsState();
             }

             //update the arrows.
             leftArrow.text = "<";
             rightArrow.text = ">";

             if (whichInitial == 0)
             leftArrow.text = " "; else if (whichInitial == 2)
             rightArrow.text = "OK";

             //update the string.
             var arr:Array = new Array();
             for (var i:Number = 0; i < 3; i++)
             {
             if (i >= str.length)
             arr[i] = 32; else
             arr[i] = str.charCodeAt(i);
             }
             if (whichLetter == 0)
             arr[whichInitial] = 32; //space
             else
             arr[whichInitial] = 64 + whichLetter; //some uppercase letter

             str = String.fromCharCode(arr[0], arr[1], arr[2]);
             newScore.initials = str; //store the string
             for (i = 0; i < 3; i++)
             {
             //update the display
             newInitials[i].text = str.charAt(i);
             }

             //letterPreview.forms = String.fromCharCode(arr[whichInitial]);
             letterPreview.text = String.fromCharCode(arr[whichInitial]);
             }*/

            super.update(elapsed);
        }
    }
}
