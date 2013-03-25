package com.tessmann.osc.view.base {
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 14:55 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class MediatorBase extends Mediator implements IMediator {
		
		private var _name:String;
		
		public function MediatorBase(name:String, viewComponent:Object = null) {
			super(viewComponent);
			_name = name;
		}
		
		override public function getMediatorName():String {
			return _name;
		}
	
	}

}