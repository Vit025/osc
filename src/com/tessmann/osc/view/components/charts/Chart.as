package com.tessmann.osc.view.components.charts {
	import com.tessmann.factory.component.ComponentBase;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 13:42 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class Chart extends ComponentBase {
		
		private var downEvent:String;
		private var moveEvent:String;
		private var upEvent:String;
		
		public function Chart() {
			graphics.clear();
			graphics.beginFill(0xFF0000, .5);
			graphics.drawRect(0, 0, 500, 500);
			graphics.endFill();
			
			downEvent = createEvent(MouseEvent.MOUSE_DOWN, downHandler);
			addEvent(downEvent);
		}
		
		private function downHandler(e:MouseEvent):void {
			stageRef ||= stage;
			moveEvent ||= createEvent(MouseEvent.MOUSE_MOVE, moveHandler, stage);
			upEvent ||= createEvent(MouseEvent.MOUSE_UP, upHandler, stage);
			
			addEvent(moveEvent);
			addEvent(upEvent);
			
			graphics.moveTo(mouseX, mouseY);
			graphics.lineStyle(4, 0xf7d649);
		}
		
		private function moveHandler(e:MouseEvent):void {
			graphics.lineTo(mouseX, mouseY);
		}
		
		private function upHandler(e:MouseEvent):void {
			graphics.lineTo(mouseX, mouseY);
			removeEvent(moveEvent);
			removeEvent(upEvent);
		}
	
	}

}