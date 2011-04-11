/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 3/18/11
 * Time: 3:46 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.states
{
import flash.net.SharedObject;

public class AbstractStateObject implements IStateObject
    {
        protected var sharedObject:SharedObject;
        protected var _dataObject:Object;
        protected var id:String;

        public function AbstractStateObject(self:AbstractStateObject, id:String)
        {
            this.id = id;
            if (!(self is AbstractStateObject))
                throw Error("This is an Abstract Class.");
        }

        public function load():void
        {
            try
            {
                sharedObject = SharedObject.getLocal(id);
                _dataObject = sharedObject.data;
            }
            catch(error:Error)
            {
                trace("Could not load shared obj");
            }
        }

        public function save():String
        {
            //TODO need to add some logic to make sure this actually saves
            var success:String = sharedObject.flush();
            trace("StateObject",id,"Size:", (sharedObject.size/1,024), "k");

            return success;
        }

        public function clear():void
        {
            sharedObject.clear();
            _dataObject = sharedObject.data;
        }

        public function get dataObject():Object
        {
            return _dataObject;
        }
    }
}
