package 
{
	import com.spikything.utils.SWFIdle;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * SWFIdle demo
	 * How to idle a SWF when not interacting with it
	 * @author Liam O'Donnell
	 */
	[SWF(frameRate="30", width="800", height="600", backgroundColor="#FFFFFF")]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SWFIdle.setup(stage);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			graphics.clear();
			graphics.beginFill(Math.random() * 0xffffff);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
		}
		
	}
	
}