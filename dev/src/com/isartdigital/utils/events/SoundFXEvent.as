package com.isartdigital.utils.events 
{
	import flash.events.Event;
	
	/**
	 * Classe d'Evenements associée à la classe SoundFX.
	 * @author Ludovic BOURGUET
	 * @author Johann CANG
	 * @author Thibaut DAMMENMULLER
	 * @author Kilian DUFOUR
	 * @author Gregoire LEVILLAIN
	 * @author Sebastien RAYMONDAUD
	 * @author Quentin VERNET
	 */
	public class SoundFXEvent extends Event 
	{
		
		/**
		 * diffusé à la fin de la lecture d'un son
		 */
		public static const COMPLETE:String = "complete";
		
		public function SoundFXEvent(pType:String) 
		{
			super(pType);
		}
		
		
		
	}

}