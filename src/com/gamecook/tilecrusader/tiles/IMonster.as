/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/4/11
 * Time: 10:37 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.tiles
{
import com.gamecook.tilecrusader.combat.ICombatant;
import com.gamecook.tilecrusader.equipment.IEquip;

public interface IMonster extends ICombatant, IEquip, ISlot
    {
        function getCharacterPointPercent():Number;
    }
}
