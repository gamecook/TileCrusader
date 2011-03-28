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

    public interface IMonster extends ICombatant
    {
        function getCharacterPointPercent():Number;
    }
}
