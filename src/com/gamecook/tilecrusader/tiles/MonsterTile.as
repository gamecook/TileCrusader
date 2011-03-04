/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/1/11
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles
{
    import com.gamecook.tilecrusader.combat.IFight;
    import com.gamecook.tilecrusader.dice.CombatDice;
    import com.gamecook.tilecrusader.dice.ICombatDice;

    public class MonsterTile extends BaseTile implements IFight, IMonster
    {
        protected var life:int = 1;
        protected var maxLife:int = 1;
        protected var dice:ICombatDice;
        protected var attackRoll:int = 1;
        protected var defenseRoll:int = 1;
        protected var characterPoints:int = 0;
        private var pointPercent:Number = 0;

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
            attackRoll = value;
        }

        public function getAttackRolls():int
        {
            return attackRoll;
        }

        public function setDefenseRolls(value:int):void
        {
            defenseRoll = value;
        }

        public function getDefenceRolls():int
       {
           return defenseRoll;
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

            // By default life is always set to same value as maxLife
            if(obj.hasOwnProperty("maxLife"))
                maxLife = life = obj.maxLife;

            if(obj.hasOwnProperty("life"))
                life = obj.life;

            if(obj.hasOwnProperty("attackRoll"))
                attackRoll = obj.attackRoll;

            if(obj.hasOwnProperty("defenseRoll"))
                defenseRoll = obj.defenseRoll;

            if(obj.hasOwnProperty("characterPoints"))
                characterPoints = obj.characterPoints;

            if(obj.hasOwnProperty("pointPercent"))
                pointPercent = Number(obj.pointPercent);

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

        public function addAttackRoll(i:int):void
        {
            attackRoll ++;
        }

        public function addDefenseRoll(i:int):void
        {
            defenseRoll ++;
        }

        public function getCharacterPoints():int
        {
            return characterPoints;
        }

        public function setCharacterPoints(value:int):void
        {
            characterPoints = value;
        }

        public function getCharacterPointPercent():Number
        {
            return pointPercent;
        }

        public function getDefenseRolls():int
        {
            return defenseRoll;
        }
    }
}
