package com.isartdigital.surf.game.levelDesign 
{
	import com.isartdigital.surf.game.sprites.Obstacle;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe qui permet de générer des Obstacles dans le GamePlane
	 * @author Ludovic BOURGUET
	 * @author Johann CANG
	 * @author Thibaut DAMMENMULLER
	 * @author Kilian DUFOUR
	 * @author Gregoire LEVILLAIN
	 * @author Sebastien RAYMONDAUD
	 * @author Quentin VERNET
	 */
	public class ObstaclesGenerator extends GameObjectsGenerator 
	{
		
		public function ObstaclesGenerator() 
		{
			super();
		}
		
		/**
		 * Méthode generate surchargeant la méthode de la classe mère
		 * Crée un Obstacle à l'endroit du générateur et retire le générateur
		 * transmet le nom de la classe du generateur à l'instance d'Obstacle lui permettant ainsi de savoir quel Obstacle créer
		 */
		override public function generate (): void {
			var lNum:String = getQualifiedClassName(this).substr( -1);
			
			var lObstacle:Obstacle = new Obstacle("Obstacle"+lNum);
			
			lObstacle.x = x;
			lObstacle.y = y;
			//lObstacle.start();
			parent.addChild(lObstacle);
			
			super.generate();
		}
		
		
	}

}