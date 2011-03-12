/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/12/11
 * Time: 1:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers {
    import com.gamecook.tilecrusader.factory.TileFactory;
    import com.gamecook.tilecrusader.tiles.MonsterTile;
    import com.gamecook.tilecrusader.tiles.TileTypes;

    import org.flexunit.Assert;

    public class TileInstanceManagerTest extends TileInstanceManager{

        MonsterTile;

        public function TileInstanceManagerTest()
        {
            super(new TileFactory(new TileTypes()));

        }

        [Before]
        public function before():void
        {
            getInstance("123", "1", {maxLife:5});
        }

        [Test]
        public function toObjectTest():void
        {
            var obj:Object = toObject();

            Assert.assertNotNull(obj.instances);
            Assert.assertEquals(obj.instances.length, 1);

            var tile:Object = obj.instances[0];
            Assert.assertEquals(tile.id, "123");
            Assert.assertEquals(tile.type, "1");
            Assert.assertEquals(tile.maxLife, 5);
        }

        [Test]
        public function toObjectMultipleItemsTest():void
        {

            getInstance("456", "3", {maxLife:1});
            getInstance("789", "5", {maxLife:2});
            getInstance("101112", "9", {maxLife:3});

            var obj:Object = toObject();

            Assert.assertEquals(obj.instances.length, 4);

        }

        [Test]
        public function clearTest():void
        {
            clear();
            Assert.assertEquals(singletons.length, 0);
        }

        [Test]
        public function parseObjectTest():void
        {
            clear();

            var instanceManager = new TileInstanceManager(new TileFactory(new TileTypes()));
            instanceManager.getInstance("34", "9", {maxLife:100});

            parseObject(instanceManager.toObject());

            Assert.assertNotNull(singletons["34"]);

            var tile:MonsterTile = singletons["34"] as MonsterTile;
            Assert.assertEquals(tile.id, "34");
            Assert.assertEquals(tile.type, "9");
            Assert.assertEquals(tile.getMaxLife(), 100);


        }


    }
}
