package com.isartdigital.shmup.game {
	
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.planes.GamePlane;
	import com.isartdigital.shmup.game.planes.ScrollingPlane;
	import com.isartdigital.shmup.game.sprites.Player;
	import com.isartdigital.shmup.ui.GameOver;
	import com.isartdigital.shmup.ui.UIManager;
	import com.isartdigital.shmup.ui.WinScreen;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.Debug;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateGraphic;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Manager (Singleton) en charge de gérer le déroulement d'une partie
	 * @author Mathieu ANTHOINE
	 */
	public class GameManager
	{
		/**
		 * instance unique de la classe GameManager
		 */
		protected static var instance: GameManager;

		/**
		 * jeu en pause ou non
		 */
		protected var isPause:Boolean = true;
		
		/**
		 * controlleur
		 */
		protected var controller:Controller;

		protected static const SCROLL_SPEED:int=5;
		protected var background1:ScrollingPlane;
		protected var background2:ScrollingPlane;
		protected var background3:ScrollingPlane;
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GameManager {
			if (instance == null) instance = new GameManager();
			return instance;
		}
		
		public function GameManager() 
		{
			// Lorsque la partie démarre, le GameManager est instancié et le type de controleur déterminé est actionné
			if (Controller.type == Controller.PAD) controller = ControllerPad.getInstance();
			else if (Controller.type == Controller.TOUCH) controller = ControllerTouch.getInstance();
			else controller = ControllerKey.getInstance();
		}
		
		public function start (): void {
			Debug.getInstance().addButton("box", cheatBox);
			Debug.getInstance().addButton("anim", cheatAnim);

			UIManager.getInstance().startGame();
			
			// TODO: votre code d'initialisation commence ici
			// créer les plans, les poser à l'affichage
			
			background1 = initBackground(0.3, "Background1");
			background2 = initBackground(0.7, "Background2");
			
			
			GameStage.getInstance().getGameContainer().addChild(GamePlane.getInstance());
			GamePlane.getInstance().init(SCROLL_SPEED);
			GamePlane.getInstance().start();
			
			GamePlane.getInstance().addChild(Player.getInstance());
			Player.getInstance().x = 300/*GamePlane.getInstance().getScreenLimits().top/3*/;
			Player.getInstance().y = 300/*GamePlane.getInstance().getScreenLimits().left/2*/;
			Player.getInstance().start();
			
			background3 = initBackground(1.3, "Foreground");
			
			resume();
		}
		
		public function initBackground(pCoef:Number, pString:String):ScrollingPlane{
			var lClass:Class = Class(getDefinitionByName(pString));
			var lBackground:ScrollingPlane = ScrollingPlane(new lClass());
			GameStage.getInstance().getGameContainer().addChild(lBackground);
			lBackground.init(pCoef, GamePlane.getInstance());
			lBackground.start();
			return lBackground;
		}
		// ==== Mode Cheat =====
		
		protected function cheatBox (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			if (StateGraphic.boxAlpha < 1) StateGraphic.boxAlpha = 1; else StateGraphic.boxAlpha = 0;
		}
		
		protected function cheatAnim (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			if (StateGraphic.animAlpha < 1) StateGraphic.animAlpha = 1; else StateGraphic.animAlpha = 0;
		}
		
		/**
		 * boucle de jeu (répétée à la cadence du jeu en fps)
		 * @param	pEvent
		 */
		protected function gameLoop (pEvent:Event): void {
			// TODO: votre code de gameloop commence ici
			background1.doAction();
			background2.doAction();
			background3.doAction();
			
			GamePlane.getInstance().doAction();
			Player.getInstance().doAction();
		}

		public function gameOver ():void {
			pause();
			UIManager.getInstance().addScreen(GameOver.getInstance());
		}
		
		public function win():void {
			pause();
			UIManager.getInstance().addScreen(WinScreen.getInstance());
		}
		
		public function pause (): void {
			if (!isPause) {
				isPause = true;
				Config.stage.removeEventListener (Event.ENTER_FRAME, gameLoop);
			}
		}
		
		public function resume (): void {
			// donne le focus au stage pour capter les evenements de clavier
			Config.stage.focus = Config.stage;
			if (isPause) {
				isPause = false;
				Config.stage.addEventListener (Event.ENTER_FRAME, gameLoop);
			}
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			Config.stage.removeEventListener (Event.ENTER_FRAME, gameLoop);
			instance = null;
		}

	}
}