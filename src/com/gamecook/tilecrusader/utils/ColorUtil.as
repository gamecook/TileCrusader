/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/24/11
 * Time: 11:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.utils
{
    import flash.display.BitmapData;

    public class ColorUtil
    {
        public static function returnARGB(rgb:uint, newAlpha:uint):uint
        {
            //newAlpha has to be in the 0 to 255 range
            var argb:uint = 0;
            argb += (newAlpha << 24);
            argb += (rgb);
            return argb;
        }

        public static function replaceColor(_pixels:BitmapData, Color:uint,NewColor:uint):void
		{
			//var positions:Array = null;
			/*if(FetchPositions)
				positions = new Array();*/

			var row:uint = 0;
			var column:uint;
			var rows:uint = _pixels.height;
			var columns:uint = _pixels.width;
            var tmpColor:uint;
			while(row < rows)
			{
				column = 0;
				while(column < columns)
				{
					tmpColor = _pixels.getPixel32(column,row);
                    if(tmpColor == Color)
					{
						_pixels.setPixel32(column,row,NewColor);
						/*if(FetchPositions)
							positions.push(new FlxPoint(column,row));
						dirty = true;*/
					}
					column++;
				}
				row++;
			}

			//return positions;
		}
    }
}
