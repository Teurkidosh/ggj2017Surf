package com.isartdigital.shmup.controller 
{
	import com.isartdigital.utils.Config;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * Controleur clavier
	 * @author Mathieu ANTHOINE
	 */
	public class ControllerKey extends Controller
	{
		/**
		 * instance unique de la classe ControllerKey
		 */
		protected static var instance: ControllerKey;
		
		protected var keyRight:Boolean;
		protected var keyUp:Boolean;
		protected var keyDown:Boolean;
		protected var keyLeft:Boolean;
		protected var keyFire:Boolean;
		protected var keyBomb:Boolean;
		protected var keySpecial:Boolean;
		protected var keyGod:Boolean;
		protected var keyPause:Boolean;
		
		public function ControllerKey() 
		{
			super();
			Config.stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKey);
			Config.stage.addEventListener(KeyboardEvent.KEY_UP, unregisterKey);
			
			
		}
		
		
		protected function registerKey (pEvent:KeyboardEvent): void {
			if (pEvent.keyCode==Keyboard[Config["keyLeft"]]) keyLeft=true;
			else if (pEvent.keyCode==Keyboard[Config["keyRight"]]) keyRight=true;
			else if (pEvent.keyCode==Keyboard[Config["keyUp"]]) keyUp=true;
			else if (pEvent.keyCode==Keyboard[Config["keyDown"]]) keyDown=true;
			else if (pEvent.keyCode==Keyboard[Config["keyFire"]]) keyFire=true;
			else if (pEvent.keyCode==Keyboard[Config["keyBomb"]]) keyBomb=true;
			else if (pEvent.keyCode==Keyboard[Config["keySpecial"]]) keySpecial=true;
			else if (pEvent.keyCode==Keyboard[Config["keyGod"]]) keyGod=true;
			else if (pEvent.keyCode==Keyboard[Config["keyPause"]]) keyPause=true;
		}

		protected function unregisterKey (pEvent:KeyboardEvent): void {
			if (pEvent.keyCode==Keyboard[Config["keyLeft"]]) keyLeft=false;
			else if (pEvent.keyCode==Keyboard[Config["keyRight"]]) keyRight=false;
			else if (pEvent.keyCode==Keyboard[Config["keyUp"]]) keyUp=false;
			else if (pEvent.keyCode==Keyboard[Config["keyDown"]]) keyDown=false;
			else if (pEvent.keyCode==Keyboard[Config["keyFire"]]) keyFire=false;
			else if (pEvent.keyCode==Keyboard[Config["keyBomb"]]) keyBomb=false;
			else if (pEvent.keyCode==Keyboard[Config["keySpecial"]]) keySpecial=false;
			else if (pEvent.keyCode==Keyboard[Config["keyGod"]]) keyGod=false;
			else if (pEvent.keyCode==Keyboard[Config["keyPause"]]) keyPause=false;
		}
		
		override public function get right():Number 
		{
			return Number(keyRight);
		}
		
		override public function get left():Number 
		{
			return Number(keyLeft);
		}
		
		override public function get up():Number 
		{
			return Number(keyUp);
		}
		
		override public function get down():Number 
		{
			return Number(keyDown);
		}
		
		override public function get fire():Boolean 
		{
			return keyFire;
		}
		
		override public function get bomb():Boolean 
		{
			return keyBomb;
		}
		
		override public function get special():Boolean 
		{
			return keySpecial;
		}
		
		override public function get god():Boolean 
		{
			return keyGod;
		}
		
		override public function get pause():Boolean 
		{
			return keyPause;
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