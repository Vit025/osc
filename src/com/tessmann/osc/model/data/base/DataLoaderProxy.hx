package com.tessmann.osc.model.data.base {
	import com.tessmann.osc.model.app.constants.notifications.NotificationsData;
	import com.tessmann.osc.model.app.vo.DataLoadVO;
	import flash.net.URLRequest;
	import org.puremvc.haxe.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 12:23 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class DataLoaderProxy extends Proxy {
		
		public function DataLoaderProxy(proxyName:String = "DataLoaderProxy") {
			super(proxyName);
		}
		
		public function load(vo:DataLoadVO = null):Void {
			// override
		}
		
		protected function loadRequest(request:URLRequest, hashID:String):Void {
			var loader:DataLoader = new DataLoader(hashID, resultHandler, faultHandler);
		}
		
		protected function resultHandler(loader:DataLoader):Void {
			sendNotification(NotificationsData.N_DATA_LOADED, loader.data, loader.id);
			if (loader.hasFinished())
				disposeLoader(loader);
		}
		
		protected function faultHandler(loader:DataLoader):Void {
			sendNotification(NotificationsData.N_DATA_FAILED, loader.data, loader.id);
			if (loader.hasFinished())
				disposeLoader(loader);
		}
		
		private function disposeLoader(loader:DataLoader):Void {
			loader.dispose();
			loader = null;
		}
	
	}

}