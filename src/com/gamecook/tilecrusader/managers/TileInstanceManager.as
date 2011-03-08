/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/8/11
 * Time: 8:04 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers
{
    import com.gamecook.tilecrusader.factory.ITileFactory;
    import com.gamecook.tilecrusader.serialize.ISerializeToObject;
    import com.gamecook.tilecrusader.tiles.BaseTile;

    public class TileInstanceManager implements ISerializeToObject
    {
        protected var singletons:Array = [];
        private var factory:ITileFactory;

        public function TileInstanceManager(factory:ITileFactory)
        {
            this.factory = factory;
        }

        public function getInstance(uniqueID:String, type:String = "null", values:Object = null):BaseTile
        {
            if(!singletons[uniqueID])
            {
                trace("Create new Tile for", type, uniqueID);
                singletons[uniqueID] = factory.createTile(type);
            }

            if(values)
                BaseTile(singletons[uniqueID]).parseObject(values);

            return singletons[uniqueID];
        }

        public function getInstances():Array
        {
            return singletons;
        }

        public function toString():String
        {
            return "TileInstanceManager[]";
        }

        public function hasInstance(uniqueID:String):Boolean
        {
            return singletons[uniqueID]
        }

        public function removeInstance(uID:String):void
        {
            singletons[uID] = null;
        }

        public function clear():void
        {
            singletons.length = 0;
        }

        public function parseObject(value:Object):void
        {
            var tmpInstances = value.instances;
            var total:int = tmpInstances;
            var i:int;
            var instanceTemplate:Object;

            for(i = 0; i < total; i++)
            {
                instanceTemplate = tmpInstances[i];
                getInstance[tmpInstances.id,  tmpInstances.type, instanceTemplate];
            }
        }

        public function toObject():Object
        {
            var obj:Object = {};
            obj.instances = [];
            var baseTile:BaseTile;
            for (baseTile in singletons)
            {
                obj.instances.push(baseTile.toObject());
                trace(baseTile);
            }
            return obj;
        }
    }
}
