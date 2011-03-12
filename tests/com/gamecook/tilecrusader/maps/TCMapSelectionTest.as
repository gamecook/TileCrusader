/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/11/11
 * Time: 9:22 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.maps {
    import com.gamecook.frogue.maps.Map;

    import flash.net.SharedObject;

    import org.flexunit.Assert;

    public class TCMapSelectionTest extends TCMapSelection{

    public function TCMapSelectionTest() {

        var map:Map = new Map();
        super(map, 10, 10, 5);
    }

    [Test]
    public function toObjectTest()
    {

        exploredTiles.push(0);
        exploredTiles.push(1);
        exploredTiles.push(2);
        exploredTiles.push(3);
        exploredTiles.push(4);
        exploredTiles.push(5);


        var obj:Object = toObject();

        Assert.assertEquals(obj.exploredTiles.toString(), exploredTiles.toString());
    }

    [Test]
    public function parseObjectTest():void
    {
        var obj:Object = {exploredTiles:[0,1,2,3]};
        parseObject(obj);

        Assert.assertEquals(exploredTiles.toString(), obj.exploredTiles.toString());
        Assert.assertNotNull(exploredTilesHashMap[0]);
        Assert.assertNotNull(exploredTilesHashMap[1]);
        Assert.assertNotNull(exploredTilesHashMap[2]);
        Assert.assertNotNull(exploredTilesHashMap[3]);

    }

        [Test]
        public function saveAndLoadDataFromSOTest():void
        {
            var tmpSO:SharedObject = SharedObject.getLocal("TCMapSelectionTest");
            var soData:Object = tmpSO.data;

            exploredTiles.push(0);
            exploredTiles.push(1);
            exploredTiles.push(2);
            exploredTiles.push(3);
            exploredTiles.push(4);
            exploredTiles.push(5);

            var value:String = exploredTiles.toString();

            soData.selection = toObject();

            tmpSO.flush();

            var tmpSO2:SharedObject = SharedObject.getLocal("TCMapSelectionTest");
            var soData2:Object = tmpSO2.data;

            exploredTiles.length = 0;

            parseObject(soData2.selection);

            Assert.assertEquals(value, exploredTiles.toString());
            Assert.assertNotNull(exploredTilesHashMap[0]);
            Assert.assertNotNull(exploredTilesHashMap[1]);
            Assert.assertNotNull(exploredTilesHashMap[2]);
            Assert.assertNotNull(exploredTilesHashMap[3]);

            tmpSO2.clear();

        }

}
}
