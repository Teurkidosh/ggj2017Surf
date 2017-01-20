package com.isartdigital.shmup.game.planes 
{
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.GameObject;
	import com.isartdigital.utils.game.GameStage;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Classe "Plan de scroll", chaque plan de scroll (y compris le GamePlane) est une instance de ScrollingPlane ou d'une classe fille de ScrollingPlane
	 * TODO: A part GamePlane, toutes les instances de ScrollingPlane contiennent 3 MovieClips dont il faut gérer le "clipping" afin de les faire s'enchainer correctement
	 * alors que l'instance de ScrollingPlane se déplace
	 * @author Mathieu ANTHOINE
	 */
	public class ScrollingPlane extends GameObject
	{
		protected var screenLimits:Rectangle;
		protected var baseSpeed:Number;
		protected var reference: ScrollingPlane;
		
		public function ScrollingPlane() 
		{
			super();
		}
		
		public function init(pBaseSpeed:Number, pReference:ScrollingPlane=null):void{
			reference = pReference;
			baseSpeed = pBaseSpeed;
		}
		
		override protected function doActionNormal():void 
		{
			x = reference.x * baseSpeed;
			setScreenLimits();
			
			//J'ai essayer de faire le clipping de la façon la plus économe possible
			//Tri de tableau d'affichage en as3 par rapport aux x plutôt qu'utiliser .sort pour éviter d'utiliser trop de process
			
			for (var j:int = 0; j < numChildren; j++){
				for (var i:int = j; i < numChildren; i++){
					if (getChildAt(j).x > getChildAt(i).x){
						setChildIndex(getChildAt(i), j);
					}
				}
			}
			
			if ((getChildAt(0).x + getChildAt(0).width) <= getScreenLimits().left){
				getChildAt(0).x = getChildAt(numChildren - 1).x + getChildAt(numChildren - 1).width;
				setChildIndex(getChildAt(0), numChildren-1);
			}
		}

		protected function setScreenLimits ():void {
			var lTopLeft:Point = new Point (0, 0);
			var lTopRight:Point = new Point (Config.stage.stageWidth, 0);
			
			lTopLeft = globalToLocal(lTopLeft);
			lTopRight = globalToLocal(lTopRight);
						
			screenLimits=new Rectangle(lTopLeft.x, 0, lTopRight.x-lTopLeft.x, GameStage.SAFE_ZONE_HEIGHT);
		}
		
		/**
		 * Retourne les coordonnées des 4 coins de l'écran dans le repère du plan de scroll concerné 
		 * Petite nuance: en Y, retourne la hauteur de la SAFE_ZONE, pas de l'écran, car on a choisi de condamner le reste de l'écran (voir cours Ergonomie Multi écran)
		 * @return Rectangle dont la position et les dimensions correspondant à la taille de l'écran dans le repère local
		 */
		public function getScreenLimits ():Rectangle {
			return screenLimits;
		}
		
	}

}