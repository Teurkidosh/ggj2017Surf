package com.isartdigital.shmup.sound 
{
	import com.isartdigital.shmup.Shmup;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.loader.AssetsLoader;
	import com.isartdigital.utils.sound.SoundFX;
	/**
	 * ...
	 * @author Mathieu ANTHOINE
	 */
	public class SoundManager 
	{
		
		/**
		 * instance unique de la classe SoundManager
		 */
		protected static var instance: SoundManager;

		protected static var isInit:Boolean;		
		
		public function SoundManager() 
		{
			
		}
		
		protected static function init():void{
			if (!isInit) isInit = true;
			
			var lJson : Object = JSON.parse(AssetsLoader.getContent(Shmup.SOUND_PATH).toString());
			SoundFX.mainVolume	=	lJson.volumes.master * int(Config.mainSound);
			
			var i:String;
			
			// FXS
			var lFxs : Object = lJson.files.fxs;

			for (i in lFxs) {
				addSound(i, new SoundFX(lFxs[i].asset, (lFxs[i].volume) * lJson.volumes.fxs));
			}
			
			// MUSICS
			var lMusics : Object = lJson.files.musics;
			
			for (i in lMusics) {
				addSound(i, new SoundFX(lMusics[i].asset, (lMusics[i].volume) * lJson.volumes.lMusics));
			}
		}
		
		/**
		 * ajoute un son à la liste
		 * @param	pName identifiant du son
		 * @param	pSound son
		 */
		protected static function addSound (pName:String, pSound:SoundFX):void {
			SoundManager[pName] = pSound;
		}
		
		/**
		* retourne une référence vers le son par l'intermédiaire de son identifiant
		 * @param	pName identifiant du son
		 * @return le son
		 */
		public static function getSound(pName:String): SoundFX {
			if (!isInit) init();
			return SoundManager[pName];
		}
	}
}