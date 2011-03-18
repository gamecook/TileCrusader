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
        protected var dataObject:Object;
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
                dataObject = sharedObject.data;
            }
            catch(error:Error)
            {
                trace("Could not load shared obj");
            }
        }

        public function save():void
        {
            sharedObject.flush()
        }

        public function clear():void
        {
            sharedObject.clear();
        }
    }
}
