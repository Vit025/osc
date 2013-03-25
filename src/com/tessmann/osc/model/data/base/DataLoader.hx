package com.tessmann.osc.model.data.base {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 11:16 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class DataLoader extends URLLoader {
		
		public var id:String;
		
		private var stock:Array<URLRequest>;
		
		private var resultHandler:Function;
		private var faultHandler:Function;
		private var busy:Boolean = false;
		private var _destroyed:Boolean = false;
		
		public function new(loaderID:String, resultCallBack:Function = null, faultCallBack:Function = null) {
			id = loaderID;
			resultHandler = resultCallBack;
			faultHandler = faultCallBack;
		}
		
		override public function load(request:URLRequest):Void {
			if (_destroyed) {
				throw new Error("loader " + id + " is disposed");
			}
			if (busy) {
				if(stock == null)
					stock = new Array<URLRequest>();
				stock.push(request);
				return;
			}
			createListeners();
			super.load(request);
			busy = true;
		}
		
		private function createListeners():Void {
			addEventListener(Event.COMPLETE, completeHandler);
			addEventListener(Event.OPEN, openHandler);
			addEventListener(ProgressEvent.PROGRESS, progressHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function removeListeners():Void {
			removeEventListener(Event.COMPLETE, completeHandler);
			removeEventListener(Event.OPEN, openHandler);
			removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		protected function completeHandler(event:Event):Void {
			busy = false;
			removeListeners();
			
			if (resultHandler != null)
				resultHandler(this);
			
			if (stock != null && stock.length > 0)
				load(stock.shift());
			else
				destroy();
		
		}
		
		private function openHandler(event:Event):Void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):Void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):Void {
			trace("httpStatusHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):Void {
			if (faultHandler != null)
				faultHandler(this, event.text);
			if (stock != null && stock.length > 0)
				load(stock.shift());
		}
		
		private function ioErrorHandler(event:IOErrorEvent):Void {
			if (faultHandler != null)
				faultHandler(this, event.text);
			if (stock != null && stock.length > 0)
				load(stock.shift());
		}
		
		public function hasFinished():Boolean {
			return stock.length == 0;
		}
		
		public function destroy():Void {
			if (_destroyed)
				return;
			removeListeners();
			resultHandler = null;
			faultHandler = null;
		}
	
	}

}