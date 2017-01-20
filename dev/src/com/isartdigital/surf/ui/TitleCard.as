package com.isartdigital.surf.ui 
{
	import com.isartdigital.surf.ui.UIManager;
	import com.isartdigital.utils.ui.Screen;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	//import com.isartdigital.utils.Debug;
	
	/**
	 * Ecran principal
	 *@author Ludovic BOURGUET
	 * @author Johann CANG
	 * @author Thibaut DAMMENMULLER
	 * @author Kilian DUFOUR
	 * @author Gregoire LEVILLAIN
	 * @author Sebastien RAYMONDAUD
	 * @author Quentin VERNET
	 */
	public class TitleCard extends Screen
	{
		
		/**
		 * instance unique de la classe TitleCard
		 */
		protected static var instance: TitleCard;
		
		public var btnPlay:SimpleButton;
	
		public function TitleCard() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): TitleCard {
			if (instance == null) instance = new TitleCard();
			return instance;
		}
				
		override protected function init (pEvent:Event): void {
			super.init(pEvent);
			btnPlay.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick (pEvent:MouseEvent = null) : void {
			//Debug.getInstance().clear()
			UIManager.getInstance().addScreen(Help.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			btnPlay.removeEventListener(MouseEvent.CLICK, onClick);
			instance = null;
			super.destroy();
		}

	}
}