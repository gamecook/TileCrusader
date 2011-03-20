/**
 * User: John Lindquist
 * Date: 3/19/11
 * Time: 4:41 PM
 */
package com.gamecook.tilecrusader.tools.generator.weapons
{
	public interface IWeapon
	{
		function get type():String;
		function get description():String;
		function get damage():int;
	}
}