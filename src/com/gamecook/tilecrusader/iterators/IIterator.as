/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 10:02 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.iterators
{
    public interface IIterator
    {
        function hasNext():Boolean;
        function getNext():*;
        function setIndex(value:int = -1):void;
    }
}
