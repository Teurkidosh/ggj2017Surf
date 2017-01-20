package com.isartdigital.shmup.ui 
{
	import com.isartdigital.utils.ui.Screen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	/**
	 * Classe mère des écrans de fin
	 * @author Mathieu ANTHOINE
	 */
	public class EndScreen extends Screen 
	{
		
		public var mcBackground:Sprite;
		
		public var btnNext:SimpleButton;
	
		public function EndScreen() 
		{
			super();
		}
	}
}