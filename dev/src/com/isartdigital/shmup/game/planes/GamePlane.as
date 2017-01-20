package com.isartdigital.shmup.game.planes 
{
	//import com.isartdigital.utils.Debug;
	
	/**
	 * Classe "plan de jeu", elle contient tous les éléments du jeu, Generateurs, Player, Ennemis, shoots...
	 * @author Mathieu ANTHOINE
	 */
	public class GamePlane extends ScrollingPlane 
	{
		
		/**
		 * instance unique de la classe GamePlane
		 */
		protected static var instance: GamePlane;

		public function GamePlane() 
		{
			super();
		}

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GamePlane {
			if (instance == null) instance = new GamePlane();
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