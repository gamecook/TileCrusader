/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 5/9/11
 * Time: 7:20 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.equipment {
    import com.gamecook.frogue.equipment.Equipment;
    import com.gamecook.frogue.enum.SlotsEnum;

import com.gamecook.frogue.tiles.PlayerTile;

import org.flexunit.Assert;

public class EquipmentTest {
    private var player:PlayerTile;

    public function EquipmentTest() {
    }

    [Before]
    public function setup():void
    {
        player= new PlayerTile();
    }

    [Test]
    public function equipWeaponTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyAttack", slotID:SlotsEnum.WEAPON});
        player.equip(weapon);

        Assert.assertEquals(player.getAttackRolls(),3);
    }

    [Test]
    public function unequipWeaponTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyAttack", slotID:SlotsEnum.WEAPON});
        player.equip(weapon);
        player.unequip(weapon);

        Assert.assertEquals(player.getAttackRolls(),1);
    }

    [Test]
    public function replaceEquipWeaponTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyAttack", slotID:SlotsEnum.WEAPON});
        player.equip(weapon);

        var weapon2:Equipment = new Equipment();
        weapon2.parseObject({tileID: "w2", modifyValue:10, modifyAttribute:"modifyAttack", slotID:SlotsEnum.WEAPON});
        player.equip(weapon2);

        Assert.assertEquals(player.getAttackRolls(),11);
    }

    [Test]
    public function equipArmorTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyDefense", slotID:SlotsEnum.ARMOR});
        player.equip(weapon);

        Assert.assertEquals(player.getDefenceRolls(),3);
    }

    [Test]
    public function unequipArmorTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyDefense", slotID:SlotsEnum.ARMOR});
        player.equip(weapon);
        player.unequip(weapon);

        Assert.assertEquals(player.getDefenceRolls(),1);
    }

    [Test]
    public function replaceEquipArmorTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyDefense", slotID:SlotsEnum.ARMOR});
        player.equip(weapon);

        var weapon2:Equipment = new Equipment();
        weapon2.parseObject({tileID: "w2", modifyValue:10, modifyAttribute:"modifyDefense", slotID:SlotsEnum.ARMOR});
        player.equip(weapon2);

        Assert.assertEquals(player.getDefenceRolls(),11);
    }

    [Test]
    public function equipFullArmorTest():void
    {
        var weapon:Equipment = new Equipment();
        weapon.parseObject({tileID: "w1", modifyValue:2, modifyAttribute:"modifyDefense", slotID:SlotsEnum.HELMET});
        player.equip(weapon);

        var weapon2:Equipment = new Equipment();
        weapon2.parseObject({tileID: "w2", modifyValue:3, modifyAttribute:"modifyDefense", slotID:SlotsEnum.ARMOR});
        player.equip(weapon2);

        var weapon3:Equipment = new Equipment();
        weapon3.parseObject({tileID: "w3", modifyValue:5, modifyAttribute:"modifyDefense", slotID:SlotsEnum.SHIELD});
        player.equip(weapon3);

        var weapon4:Equipment = new Equipment();
        weapon4.parseObject({tileID: "w4", modifyValue:5, modifyAttribute:"modifyDefense", slotID:SlotsEnum.SHOES});
        player.equip(weapon4);

        Assert.assertEquals(player.getDefenceRolls(),16);
    }
}
}
