/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 12/15/10
 * Time: 7:41 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;

public class MouseManager {

    private var _mouseHidden:Boolean = false;
    private var _mouseDown:Boolean = false;
    private var target:DisplayObject;
    private var position:Point = new Point();

    public function get isMouseDown():Boolean {
        return _mouseDown;
    }

    public function set isMouseDown(value:Boolean):void {
        _mouseDown = value;
    }

    public function MouseManager() {

    }

    public function activate(target:DisplayObject):void
    {
        this.target = target;
        addEventListeners();
    }

    public function deactivate():void
    {
        removeEventListeners();
    }

    private function addEventListeners():void {
        target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
        target.addEventListener(MouseEvent.MOUSE_UP, onMouseUP, false, 0, true);
    }

    private function onMouseUP(event:MouseEvent):void {
        _mouseDown = false;
    }

    private function onMouseDown(event:MouseEvent):void {
        _mouseDown = true;
    }

    private function removeEventListeners():void {
    }

    public function hideMouse(value:Boolean):void
    {
        if(value)
            Mouse.hide();
        else
            Mouse.show();

        mouseHidden = value;
    }

    public function get mouseHidden():Boolean {
        return _mouseHidden;
    }

    public function set mouseHidden(value:Boolean):void {
        _mouseHidden = value;
    }

    public function get mousePosition():Point
    {
        position.x = target.mouseX;
        position.y = target.mouseY;
        return position;
    }
}
}
