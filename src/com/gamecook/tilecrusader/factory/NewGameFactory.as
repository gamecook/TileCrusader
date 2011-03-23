/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/22/11
 * Time: 4:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.factory
{
    import com.gamecook.tilecrusader.enum.PlayerClassTemplates;
    import com.gamecook.tilecrusader.states.ActiveGameState;
    import com.gamecook.tilecrusader.states.CustomTemplateState;
    import com.gamecook.tilecrusader.utils.ArrayUtil;

    public class NewGameFactory
    {
        private static var DEFAULT_POINTS:int = 20;

        public static function createCofferBreakGame(classOptions:Array, darknessOptions:Array, gameModeOptions:Array, mapSizeOptions:Array, showMonsterOptions:Array, dropTreasureOptions:Array):Boolean
        {
            var activeGameState:ActiveGameState = new ActiveGameState();
            activeGameState.load();

            activeGameState.clear();

            var success:Boolean = false;

            var playerClass:String = ArrayUtil.pickRandomArrayElement(classOptions);
            var playerObj:Object = PlayerClassTemplates.getTemplate(playerClass);



            // configure ActiveGameState SO
            activeGameState.activeGame = true;
            activeGameState.player = {name:"Random Name",
                            maxLife: playerObj.life,
                            attackRoll: playerObj.attackRoll,
                            defenseRoll: playerObj.defense,
                            maxPotions: playerObj.potions,
                            points: DEFAULT_POINTS,
                            characterPoints: DEFAULT_POINTS};

            activeGameState.size = ArrayUtil.pickRandomArrayElement(mapSizeOptions);
            activeGameState.gameType = ArrayUtil.pickRandomArrayElement(gameModeOptions);
            activeGameState.darkness = ArrayUtil.pickRandomArrayElement(darknessOptions);
            activeGameState.monstersDropTreasure = ArrayUtil.pickRandomArrayElement(dropTreasureOptions);
            activeGameState.showMonsters = ArrayUtil.pickRandomArrayElement(showMonsterOptions);

            //TODO this needs to be correctly connected
            success = true;
            var error:String = activeGameState.save();

            return success;
        }
    }
}
