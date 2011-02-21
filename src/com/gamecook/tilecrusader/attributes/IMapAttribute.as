/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 2/19/11
 * Time: 10:40 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.attributes
{
    import com.gamecook.frogue.maps.IMap;
    import com.gamecook.frogue.maps.IMapSelection;

    public interface IMapAttribute extends IAttribute
    {
        function mapTarget(map:IMap, mapSelection:IMapSelection):void;
    }
}
