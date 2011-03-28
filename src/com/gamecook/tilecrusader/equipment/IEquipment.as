/**
 * User: John Lindquist
 * Date: 3/28/11
 * Time: 5:18 PM
 */
package com.gamecook.tilecrusader.equipment
{
	public interface IEquipment
	{
		function get attack():int;
		function get defense():int;

		function get type():String;

		function get description():String;
	}
}