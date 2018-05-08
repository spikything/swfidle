package com.spikything.utils 
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * SWFIdle - simple SWF idling
	 * Lets you to save CPU by idling a SWF when not interacting with it
	 * @author Liam O'Donnell
	 * @version 1.0
	 * @usage Call SWFIdle.setup(stage).
	 * @copy © spikything.com
	 * This code is licensed under Creative Commons Attribution 3.0 License:
	 * http://creativecommons.org/licenses/by/3.0/
	 * You are free to utilise this class in any manner you see fit, but it is
	 * provided 'as is' without expressed or implied warranty. The author should
	 * be acknowledged and credited appropriately wherever this work is used.
	 */
	public class SWFIdle
	{
		static private const FPS_DIFF_MIN :Number = 0.1;
		static private var _defaultFramerate :Number;
		static private var _idleFramerate :Number;
		static private var _stage :Stage;
		
		public function SWFIdle() 
		{
			throw new IllegalOperationError("Don't instantiate SWFIdle, call SWFIdle.setup(stage) instead.");
		}
		
		public static function setup(stage:Stage, defaultFramerate:Number = -1, idleFramerate:Number = 0):void
		{
			_stage = stage;
			_defaultFramerate = defaultFramerate == -1 ? stage.frameRate : defaultFramerate;
			_idleFramerate = idleFramerate;
			
			if (_defaultFramerate < 0) 
				throw new ArgumentError("Invalid defaultFramerate value.");
			
			if (_idleFramerate < 0) 
				throw new ArgumentError("Invalid idleFramerate value.");
			
			_stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, update);
			update();
		}
		
		public static function kill():void
		{
			_stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, update);
			update();
		}
		
		private static function onMouseLeave(e:Event = null):void 
		{
			_stage.frameRate = _idleFramerate;
		}
		
		private static function update(e:MouseEvent = null):void 
		{
			var rateDiff:Number = Math.abs(_stage.frameRate - _defaultFramerate);
			
			if (rateDiff > FPS_DIFF_MIN) 
				_stage.frameRate = _defaultFramerate;
		}
		
	}
	
}