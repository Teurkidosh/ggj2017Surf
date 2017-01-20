package com.isartdigital.shmup.ui {
	
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.ui.Screen;
	
	/**
	 * Manager (Singleton) en charge de gérer les écrans d'interface
	 * @author Mathieu ANTHOINE
	 */
	public class UIManager 
	{
		
		/**
		 * instance unique de la classe UIManager
		 */
		protected static var instance: UIManager;
	
		public function UIManager() 
		{
			
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): UIManager {
			if (instance == null) instance = new UIManager();
			return instance;
		}
		
		/**
		 * Ajoute un écran dans le conteneur de Screens en s'assurant qu'il n'y en a pas d'autres
		 * @param	pScreen
		 */
		public function addScreen (pScreen: Screen): void {
			closeScreens();
			GameStage.getInstance().getScreensContainer().addChild(pScreen);
		}
		
		/**
		 * Supprimer les écrans dans le conteneur de Screens
		 * @param	pScreen
		 */
		public function closeScreens (): void {
			while (GameStage.getInstance().getScreensContainer().numChildren > 0) {
				Screen(GameStage.getInstance().getScreensContainer().getChildAt(0)).destroy();
				GameStage.getInstance().getScreensContainer().removeChildAt(0);
			}
		}
		
		/**
		 * lance le jeu
		 */
		 public function startGame (): void {
			closeScreens();
			GameStage.getInstance().getHudContainer().addChild(Hud.getInstance());			
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			instance = null;
		}

	}
	
}