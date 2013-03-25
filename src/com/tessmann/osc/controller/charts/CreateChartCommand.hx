package com.tessmann.osc.controller.charts;
import com.tessmann.factory.haxe.tools.getRandomString;
import com.tessmann.osc.model.app.vo.DataLoadVO;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author Vitaly Filinov @ TELEFISION TEAM
 */

class CreateChartCommand extends SimpleCommand {

	override public function execute(notification:INotification):void {
		super.execute(notification);
		
		loadDataTest();
	}
	
	private function loadDataTest():void {
		var vo:DataLoadVO = new DataLoadVO();
		vo.hashID = getRandomString();
		sendNotification(NotificationsData.N_DATA_LOAD, vo, "EURUSD=X");
	}
	
}