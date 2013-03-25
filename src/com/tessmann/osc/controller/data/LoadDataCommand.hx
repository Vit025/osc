package com.tessmann.osc.controller.data;
	import com.tessmann.osc.model.app.conf.data.DataConfig;
	import com.tessmann.osc.model.app.vo.DataLoadVO;
	import com.tessmann.osc.model.data.base.DataLoaderProxy;
	import org.puremvc.haxe.interfaces.INotification;
	import org.puremvc.haxe.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 13:40 by Vitaly Filinov @ TELEFISION TEAM
	 */
	class LoadDataCommand extends SimpleCommand {
		
		private var dataLoader:DataLoaderProxy;
		
		override public function execute(note:INotification) {
			if(dataLoader == null)
				dataLoader = facade.retrieveProxy(DataConfig.DATA_PROXY);
			dataLoader.load(note.getBody());
		}
	
	}