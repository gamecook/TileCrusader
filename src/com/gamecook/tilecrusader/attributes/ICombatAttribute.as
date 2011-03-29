/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 10:34 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.attributes
{
    import com.gamecook.tilecrusader.combat.ICombatant;

    public interface ICombatAttribute extends IAttribute
    {
        function combatTargets(targetA:ICombatant, targetB:ICombatant):void;
    }
}
