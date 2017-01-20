package com.isartdigital.surf.controller 
{
	import com.isartdigital.utils.Config;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * Controleur clavier
	 * @author Ludovic BOURGUET
	 * @author Johann CANG
	 * @author Thibaut DAMMENMULLER
	 * @author Kilian DUFOUR
	 * @author Gregoire LEVILLAIN
	 * @author Sebastien RAYMONDAUD
	 * @author Quentin VERNET
	 */
	public class ControllerKey extends Controller
	{
		/**
		 * instance unique de la classe ControllerKey
		 */
		protected static var instance: ControllerKey;
		
		public function ControllerKey() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): ControllerKey {
			if (instance == null) instance = new ControllerKey();
			return instance;
		}
				
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
		}
	}
}