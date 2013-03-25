package com.tessmann.osc.model.data.base {
	import flash.display.Loader;
	import flash.errors.Error;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Function;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-20 17:13 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class FileLoader extends Loader {
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
		
		override public function load(request:URLRequest, context:LoaderContext = null):Void {
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
			super.load(request, context);
			busy = true;
		}
		
		private function createListeners():Void {
			contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			contentLoaderInfo.addEventListener(Event.UNLOAD, unLoadHandler);
		}
		
		private function removeListeners():Void {
			contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			contentLoaderInfo.removeEventListener(Event.OPEN, openHandler);
			contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			contentLoaderInfo.removeEventListener(Event.UNLOAD, unLoadHandler);
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
		
		private function httpStatusHandler(event:HTTPStatusEvent):Void {
			trace("httpStatusHandler: " + event);
		}
		
		private function initHandler(event:Event):Void {
			trace("initHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):Void {
			if (faultHandler != null)
				faultHandler(this, event.text);
			if (stock != null && stock.length > 0)
				load(stock.shift());
		}
		
		private function openHandler(event:Event):Void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):Void {
			trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		private function unLoadHandler(event:Event):Void {
			trace("unLoadHandler: " + event);
		}
		
		public function hasFinished():Bool {
			return stock.length == 0;
		}
		
		public function destroy():Void {
			if (_destroyed)
				return;
			unload();
			removeListeners();
			resultHandler = null;
			faultHandler = null;
		}
	
	}

}