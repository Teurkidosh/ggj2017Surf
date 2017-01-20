﻿package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.planes.GamePlane;
	import com.isartdigital.utils.game.StateGraphic;
	
	/**
	 * Classe du joueur (Singleton)
	 * En tant que classe héritant de StateGraphic, Playuer contient un certain nombre d'états définis par les constantes LEFT_STATE, RIGHT_STATE, etc.
	 * @author Mathieu ANTHOINE
	 */
	public class Player extends StateGraphic
	{
		
		/**
		 * instance unique de la classe Player
		 */
		protected static var instance: Player;
		
		/**
		 * controleur de jeu
		 */
		protected var controller: Controller;
		
		/**
		 * vitesse du joueur
		 */
		protected var speed:Number = 30;
		
		/**
		 * marge par rapport aux bords de l'écran 
		 */
		protected const MARGIN_SCREEN:int = 100;
		
		public function Player() 
		{
			super();

			// crée le controleur correspondant à la configuration du jeu
			if (Controller.type == Controller.PAD) controller = ControllerPad.getInstance();
			else if (Controller.type == Controller.TOUCH) controller = ControllerTouch.getInstance();
			else controller = ControllerKey.getInstance();
		}
		
		override protected function doActionNormal():void 
		{
			//J'ai écrit le doActionNormal de façon a se que les autres états de doAction soit facile a definir, séparant les mouvements, l'utilisation de l'armement, la compensation etc...
			//checkScreenLimit();
			doCompensation();
			doMove();
		}
		
		protected function doCompensation():void
		{
			x += GamePlane.getInstance().getBaseSpeed();
		}
		
		protected function doMove():void
		{
			
			if (controller.up){
				y += controller.right * speed;
				setState("down", false, 0);
			}
			
			if (controller.down){
				y -= controller.left * speed;
				setState("up", false, 0);
			}
			
			if (!controller.up && !controller.down && state!="default")
			{
				setState("default", false, 0);
			}
			
		}
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Player {
			if (instance == null) instance = new Player();
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