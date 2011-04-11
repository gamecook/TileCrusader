/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 2/11/11
 * Time: 2:18 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.enum
{
    public class GameModeOptions
    {
        public static const KILL_ALL_MONSTERS:String = "Kill All Monsters";
        public static const FIND_ALL_TREASURE:String = "Find All Treasure";
        public static const FIND_ARTIFACT:String = "Find Artifact";
        public static const KILL_BOSS:String = "Kill Boss";
        public static const POISONED:String = "Find A Cure";
        public static var EXPLORE:String = "Explore Map";
        public static const ESCAPE:String = "Escape";

        public static function getGameModeDescription(gameMode:String):String
        {
            var message:String;

            switch (gameMode) {
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
                case EXPLORE:
                    message = "explore map";

            }
            return message;
        }

        public static function getValues():Array
        {
            return [EXPLORE, /*ESCAPE, FIND_ALL_TREASURE, FIND_ARTIFACT, POISONED,*/ KILL_ALL_MONSTERS, KILL_BOSS];
        }
    }
}
