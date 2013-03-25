package com.tessmann.factory.haxe.tools {
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-03-19 11:50 by Vitaly Filinov @ TELEFISION TEAM
	 */
	
	public function getRandomString(length:int = 20):String {
		const chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var nums:String = new Date().time.toString();
		var i:int = length / nums.length;
		while (i > 0) {
			nums += nums;
			i--;
		}
		
		var hlf:Number = length >> 1;
		nums = nums.substr((hlf > 0) ? (hlf + .5) >> 0 : (hlf - .5) >> 0);
		var num_chars:Number = chars.length - 1;
		var randomChar:String = "";
		i = length;
		while (i--)
			randomChar += nums.charAt(i) + chars.charAt(Math.floor(Math.random() * num_chars));
		return randomChar;
	}

}