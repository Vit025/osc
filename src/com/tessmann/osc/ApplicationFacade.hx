package com.tessmann.osc;

	import com.tessmann.osc.controller.app.StartupCommand;
	import com.tessmann.osc.controller.data.LoadDataCommand;
	import com.tessmann.osc.model.app.constants.notifications.NotificationsData;
	import com.tessmann.osc.model.app.constants.notifications.NotificationsMain;
	import com.tessmann.osc.model.data.yahoo.YahooDataLoader;
	import flash.display.DisplayObject;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.haxe.interfaces.IFacade;
	import org.puremvc.haxe.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 13:40 by Vitaly Filinov @ TELEFISION TEAM
	 */
	class ApplicationFacade extends Facade implements IFacade {
		
		static private var instance:ApplicationFacade;
		
		private var mainApp:DisplayObject;
		
		
		public function new(main:DisplayObject = null) {
			mainApp = main;
		}
		
		public static function getInstance():ApplicationFacade {
			if (instance == null) {
				instance = new ApplicationFacade();
			}
			return instance;
		}
		
		override private function initializeController():Void {
			super.initializeController();
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//{	>>>>>>	MAIN CONTROLLER
			//////////////////////////////////////////////////////////////////////////////////////////////////
			registerCommand(NotificationsMain.N_MAIN_START, StartupCommand);
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//{	>>>>>>	DATA CONTROLLER
			//////////////////////////////////////////////////////////////////////////////////////////////////
			registerCommand(NotificationsData.N_DATA_LOAD, LoadDataCommand);

		}
		
		override private function initializeModel():Void {
			super.initializeModel();
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//{	>>>>>>	DATA MODEL
			//////////////////////////////////////////////////////////////////////////////////////////////////
			registerProxy(new YahooDataLoader());
		}
		
		override private function initializeView():Void {
			super.initializeView();
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//{	>>>>>>	MAIN VIEW
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//registerMediator(new ApplicationMediator(mainApp));
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//{	>>>>>>	DATA VIEW
			//////////////////////////////////////////////////////////////////////////////////////////////////
		}
		
		public function startup():Void {
			sendNotification(NotificationsMain.N_MAIN_START);
		}

	}