package com.tessmann.osc.view.components.charts {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-20 16:40 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class TestChartDesign extends Sprite {
		
		public var bg:Sprite;
		public var window:Sprite;
		public var notUsed:Sprite;
		
		public function TestChartDesign() {
			bg = new Sprite;
			bg.name = "bg";
			bg.graphics.clear();
			bg.graphics.beginFill(0xFF0000);
			bg.graphics.drawRect(0, 0, 200, 200);
			bg.graphics.endFill();
			addChild(bg);
			
			window = new Sprite;
			window.name = "window";
			window.graphics.clear();
			window.graphics.beginFill(0x0000FF);
			window.graphics.drawRect(0, 0, 20, 20);
			window.graphics.endFill();
			window.x = window.y = 50;
			addChild(window);
			
			notUsed = new Sprite;
			notUsed.name = "notUsed";
			notUsed.graphics.clear();
			notUsed.graphics.beginFill(0xCCCCCC);
			notUsed.graphics.drawRect(40, 40, 20, 20);
			notUsed.graphics.endFill();
			addChild(notUsed);
		}
	
	}

}