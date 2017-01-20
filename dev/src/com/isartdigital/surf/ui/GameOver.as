package com.isartdigital.surf.ui 
{
	/**
	 * Classe Game OVer (Singleton)
	 * @author Ludovic BOURGUET
	 * @author Johann CANG
	 * @author Thibaut DAMMENMULLER
	 * @author Kilian DUFOUR
	 * @author Gregoire LEVILLAIN
	 * @author Sebastien RAYMONDAUD
	 * @author Quentin VERNET
	 */
	public class GameOver extends EndScreen 
	{
		/**
		 * instance unique de la classe GameOver
		 */
		protected static var instance: GameOver;
		
		public function GameOver() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GameOver {
			if (instance == null) instance = new GameOver();
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