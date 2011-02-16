/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.minutequest.tiles
{
    import com.gamecook.minutequest.combat.IFight;
    import com.gamecook.minutequest.dice.CombatDice;
    import com.gamecook.minutequest.dice.ICombatDice;

    public class MonsterTile extends BaseTile implements IFight
    {
        protected var life:int = 1;
        protected var maxLife:int = 1;
        protected var dice:ICombatDice;
        protected var attackRoll:int = 1;
        protected var defenseRoll:int = 1;

        public function MonsterTile()
        {
        }

        public function getDice():ICombatDice
        {
            if(!dice)
                dice = new CombatDice();
            return dice;
        }

        public function setAttackRolls(value:int):void
        {
            attackRoll;
        }

        public function getAttackRolls():int
        {
            return attackRoll;
        }

        public function setDefenseRolls(value:int):void
        {
            defenseRoll;
        }

        public function getDefenceRolls():int
       {
           return attackRoll;
       }

        public function getLife():int
        {
            return life;
        }

        public function setLife(value:int):void
        {
            life = value;
        }

        public function getMaxLife():int
        {
            return maxLife;
        }

        public function setMaxLife(value:int):void
        {
            maxLife = value;
        }

        public function getHitValue():int
        {
            return getDice().attackRoll(attackRoll);
        }

        public function getDefenseValue():int
        {
            return getDice().monsterDefenseRoll(defenseRoll);
        }

        override public function parseObject(obj:Object):void
        {
            super.parseObject(obj);

            if(obj.hasOwnProperty("life"))
                life = obj.life;
            if(obj.hasOwnProperty("maxLife"))
                maxLife = obj.maxLife;
            if(obj.hasOwnProperty("attackRoll"))
                attackRoll = obj.attackRoll;
            if(obj.hasOwnProperty("defenseRoll"))
                defenseRoll = obj.defenseRoll;
        }

        public function subtractLife(value:int):void
        {
            life -= value;
            if(life < 0) life = 0;
        }

        public function addLife(value:int):void
        {
            life += value;
            if(life > maxLife) life = maxLife;
        }

    }
}
