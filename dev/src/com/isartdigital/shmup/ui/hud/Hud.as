package com.isartdigital.shmup.ui.hud 
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.ui.Screen;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * Classe en charge de gérer les informations du Hud
	 * @author Mathieu ANTHOINE
	 */
	public class Hud extends Screen 
	{
		
		/**
		 * instance unique de la classe Hud
		 */
		protected static var instance: Hud;
		
		public var mcTopLeft:MovieClip;
		public var mcTopCenter:MovieClip;
		public var mcTopRight:MovieClip;
		public var mcBottomRight:MovieClip;
		
		protected var score:TextField;
	
		public function Hud() 
		{
			super();
			if (!Config.debug && Controller.type != Controller.TOUCH) {
				removeChild(mcBottomRight);
				mcBottomRight = null;
			}
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Hud {
			if (instance == null) instance = new Hud();
			return instance;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			super.destroy();
		}

	}
}