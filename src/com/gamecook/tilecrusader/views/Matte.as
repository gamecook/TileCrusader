/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 12/15/10
 * Time: 8:25 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.views {
import flash.display.Shape;

public class Matte extends Shape{

    public function Matte(x:int, y:int, width:int, height:int, color:uint = 0xff0000, alpha:Number = 1) {

        graphics.beginFill(color, alpha);
        graphics.drawRect(0,0,width,height);
        graphics.endFill();
        this.x = x;
        this.y = y;

    }
}
}
