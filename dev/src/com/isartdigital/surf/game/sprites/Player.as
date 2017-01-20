package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.planes.GamePlane;
	import com.isartdigital.utils.Debug;
	import com.isartdigital.utils.game.StateGraphic;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * Classe du joueur (Singleton)
	 * En tant que classe héritant de StateGraphic, Playuer contient un certain nombre d'états définis par les constantes LEFT_STATE, RIGHT_STATE, etc.
	 * @author Mathieu ANTHOINE
	 */
	public class Player extends Shooters
	{
		
		/**
		 * instance unique de la classe Player
		 */
		protected static var instance: Player;
		
		/**
		 * controleur de jeu
		 */
		protected var controller: Controller;
		
		public var speedShip:Point=new Point();
		
		/**
		 * marge par rapport aux bords de l'écran 
		 */
		protected const MARGIN_SCREEN:int = 100;
		
		/**
		 * référence vers le moviclip de l'arme actuelle 
		 */
		protected var weapon:MovieClip;
		
		/*
		 * Rayon max que le spécial atteind
		 */
		protected var rayonActionSpecial:int=500;
		
		protected var cooldownSpecial:int=60;
		protected var timerSpecial:int;
		
		public function Player() 
		{
			super();
			// crée le controleur correspondant à la configuration du jeu
			if (Controller.type == Controller.PAD) controller = ControllerPad.getInstance();
			else if (Controller.type == Controller.TOUCH) controller = ControllerTouch.getInstance();
			else controller = ControllerKey.getInstance();
			
			
			Debug.getInstance().addSlideBar("WEAPON level", 0, 2, shootLevel, 1, updateLevel);
			Debug.getInstance().addSlideBar("SHOOT power", 0, 2, shootPower, 1, updatePower);
			Debug.getInstance().addSlideBar("SHOOT cooldown", 0, 120, cooldownShoot, 1, updateCooldown);
			Debug.getInstance().addSlideBar("SPECIAL range", 0, 1000, rayonActionSpecial, 1, updateSpecialRange);
			Debug.getInstance().addSlideBar("SPECIAL cooldown", 0, 120, cooldownSpecial, 1, updateCooldownSpecial);
		}
		
		protected function updateCooldownSpecial(pEvent:Event):void{
			timerSpecial = 0;
			cooldownSpecial = pEvent.target.value;
		}
		
		protected function updateCooldown(pEvent:Event):void{
			timerShoot = 0;
			cooldownShoot = pEvent.target.value;
		}
		
		protected function updatePower(pEvent:Event):void{
			shootPower = pEvent.target.value;
		}
		
		protected function updateSpecialRange(pEvent:Event):void{
			rayonActionSpecial = pEvent.target.value;
		}
		
		protected function updateLevel(pEvent:Event=void):void{
			if(pEvent!=null) shootLevel = pEvent.target.value;
			MovieClip(MovieClip(anim.getChildAt(0)).getChildByName("mcWeapon")).removeChildAt(0);
			var lClass:Class=Class(getDefinitionByName("Weapon" + shootLevel));
			weapon = new lClass;
			MovieClip(MovieClip(anim.getChildAt(0)).getChildByName("mcWeapon")).addChildAt(weapon,0);
		}
		
		
		override protected function doActionNormal():void 
		{
			//J'ai écrit le doActionNormal de façon a se que les autres états de doAction soit facile a definir, séparant les mouvements, l'utilisation de l'armement, la compensation etc...
			checkScreenLimit();
			doCompensation();
			doMove();
			doShoot();
			doSpecial();
		}
		
		/**
		 * Compense la vitesse du scrolling
		 */
		protected function doCompensation():void
		{
			x += GamePlane.getInstance().getBaseSpeed();
		}
		
		/**
		 * Mouvement du player
		 */
		override protected function doMove():void
		{
			
			if (controller.right){
				speedShip.x += controller.right * speed;
				setState("right", false, 0);
			}
			
			if (controller.left){
				speedShip.x-= controller.left * speed;
				setState("left", false, 0);
			}
			
			if (controller.up){
				speedShip.y-= controller.up * speed;
				setState("up", false, 0);
			}
			
			if (controller.down){
				speedShip.y+= controller.down * speed;
				setState("down", false, 0);
			}
			
			if (!controller.right && !controller.left && !controller.up && !controller.down && state!="default")
			{
				setState("default", false, 0);
			}
			
			x += speedShip.x;
			y += speedShip.y;
			
			speedShip.x = 0;
			speedShip.y = 0;
		}
		
		override protected function doShoot():void 
		{
			
			if (timerShoot < cooldownShoot){
				timerShoot++;
			}
			if (controller.fire && timerShoot == cooldownShoot){
				timerShoot = 0;
				var lShoot:Shoot;
				var lPoint:Point;
				var lString:String = getQualifiedClassName(this);
				lString = lString.split("::").pop() ;
				if (lString != "Player"){
					lString = lString.substring(0,lString.length-1);
				}
				lString += shootPower;
				var lClass:Class=Class(getDefinitionByName("com.isartdigital.shmup.game.sprites.Shoot" + lString));
				
				for (var i:int = 0; i < (shootLevel*2)+1; i++)
				{
					lShoot = new lClass();
					var lCanon:DisplayObject = box.getChildByName("mcWeapon" + i);
					
					lPoint = new Point(lCanon.x, lCanon.y);
					lPoint =this.localToGlobal(lPoint);
					lPoint = GamePlane.getInstance().globalToLocal(lPoint);
					
					lShoot.x = lPoint.x;
					lShoot.y = lPoint.y;
					lShoot.rotation = lCanon.rotation;
					
					lShoot.start();
					parent.addChild(lShoot);
				}
				
			}
		}
		
		/**
		 * Special du player
		 */
		protected function doSpecial():void
		{
			if (timerSpecial < cooldownSpecial){
				timerSpecial++;
			}
			if (controller.special && timerSpecial == cooldownSpecial && Enemy.list.length != 0){
				
				timerSpecial = 0;
				var index:int = 0;
				var distanceMin:int = Math.sqrt(Math.pow(x - Enemy.list[0].x, 2) + Math.pow(y - Enemy.list[0].y, 2));
				
				for (var i:int = 1; i < Enemy.list.length; i++){
					var distancePE:int = Math.sqrt(Math.pow(x - Enemy.list[i].x, 2) + Math.pow(y - Enemy.list[i].y, 2));
					if (distancePE < distanceMin){
						distanceMin = distancePE;
						index = i;
					}
				}
				
				if (distanceMin <= rayonActionSpecial){
					
					//Inversion des coordonnées sans passer par une variable intermédiaire
					x += Enemy.list[index].x;
					y += Enemy.list[index].y;
					Enemy.list[index].x = x - Enemy.list[index].x;
					Enemy.list[index].y = y - Enemy.list[index].y;
					x = x - Enemy.list[index].x;
					y = y - Enemy.list[index].y;
					
				}
			}
		}
		
		//protected function doPause()
		
		/**
		 * Limite les mouvements du player dans l'écran
		 */
		protected function checkScreenLimit():void
		{
			if (x < GamePlane.getInstance().getScreenLimits().left + MARGIN_SCREEN) x = GamePlane.getInstance().getScreenLimits().left + MARGIN_SCREEN;
			if (x > GamePlane.getInstance().getScreenLimits().right - MARGIN_SCREEN) x = GamePlane.getInstance().getScreenLimits().right - MARGIN_SCREEN;
			if (y < GamePlane.getInstance().getScreenLimits().top + MARGIN_SCREEN) y = GamePlane.getInstance().getScreenLimits().top + MARGIN_SCREEN;
			if (y > GamePlane.getInstance().getScreenLimits().bottom - MARGIN_SCREEN) y = GamePlane.getInstance().getScreenLimits().bottom - MARGIN_SCREEN;
		}
		
		/**
		 * Limite les mouvements du player dans l'écran
		 */
		override protected function setState(pState:String, pLoop:Boolean = false, pStart:uint = 1):void 
		{
			var lState:String = state;
			
			super.setState(pState, pLoop, pStart);
			
			if (lState != pState)
			{
				updateLevel();
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