/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 2/11/11
 * Time: 2:18 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.enum
{
    public class GameModes
    {
        public static const KILL_ALL_MONSTERS:String = "killAllMonsters";
        public static const FIND_ALL_TREASURE:String = "findAllTreasure";
        public static const FIND_ARTIFACT:String = "findArtifact";
        public static const KILL_BOSS:String = "killBoss";
        public static const POISONED:String = "poisoned";

        public static function getGameModeDescription(gameMode:String):String
        {
            var message:String;

            switch(gameMode)
            {
                case KILL_ALL_MONSTERS:
                    message = "kill all monsters";
                    break;
                case FIND_ALL_TREASURE:
                    message = "find all treasure";
                case FIND_ARTIFACT:
                    message = "find artifact";
                case KILL_BOSS:
                    message = "kill the boss";
                case POISONED:
                    message = "find the cure";

            }
            return message;
        }
    }
}
