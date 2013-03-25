package com.tessmann.osc.model.data.yahoo {
	import com.tessmann.osc.model.app.vo.DataLoadVO;
	import com.tessmann.osc.model.data.base.DataLoaderProxy;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 12:23 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class YahooDataLoader extends DataLoaderProxy {
		
		public function new() {
			super("YahooDataLoader");
		}
		
		override public function load(vo:DataLoadVO = null):Void {
			var urlRequest:URLRequest = new URLRequest("http://ichart.yahoo.com/table.csv?s=EURUSD=X&a=0&b=1&c=2000&d=0&e=31&f=2010&g=w&ignore=.csv");
			loadRequest(urlRequest, vo.hashID);
		}
	
	}

}