package  
{
	import flash.display.Graphics;
	import framework.*;
	import physics.*;
	/**
	 * class that manages projectiles
	 * @author farinha
	 */
	public class Bullet extends Sprite implements ICollisionListener
	{
		// Static
				
		//info do davebullet
		private static const ANIMATION_FRAMES_BULLET :Array = [0];
		private static const ANIMATION_TIMES_BULLET :Array = [0];
		//info do browncirclebullet
		private static const ANIMATION_FRAMES_BLAST :Array = [3];
		private static const ANIMATION_TIMES_BLAST :Array = [50];
		
		private static const VELOCITY :Number = 120;
		
		// Attributes
		private var _speedX :Number = 120;
		private var isDaveBullet :Boolean = false;
		
		public var bulletListener :IBulletListener = null;
		
		
		
		// Constructors
		
		public function Bullet(level :DaveLevel, y :Number, x :Number, direction:Number, isDaveBullet :Boolean) {
			//TODO: mudar o construtor de bullet: speed, e direção não estão sendo contemplados no construtor
			super(level, Images.davebullet, ANIMATION_FRAMES_BULLET, ANIMATION_TIMES_BULLET);
			this.level = level;
			this.isDaveBullet = isDaveBullet;
			if (isDaveBullet) {
				this.animationFrames = ANIMATION_FRAMES_BULLET;
				this.animationTimes = ANIMATION_TIMES_BULLET;
				this.image = Images.davebullet;
			} else {
				this.animationFrames = ANIMATION_FRAMES_BLAST;
				this.animationTimes = ANIMATION_TIMES_BLAST;
				this.image = Images.browncirclebullet;
			}
			this.collisionListener = this;

			this.x = x * level.tileWidth;
			this.y = y * level.tileHeight + ((level.tileHeight - this.image.height) / 2);
			//this.animation = 0;

			if (direction < 0)  
			{
				flipX = true;
				_speedX = -_speedX;
			}
		}
		
		// Properties	
		override public function get collisionRectangle() :Rectangle {
			return new Rectangle(x +3, y +1, width - 6, height -1);
		}
		
		// Methods
/*		
		public function move(velocity :Number) :void {
			if (velocity < 0) {
				flipX = true;
			} else {
				flipX = false;
			}
			speedX = velocity;
		}
	*/	
		// Overrides
		
		override public function update(seconds :Number) :void {
			super.update(seconds);
			Physics.move(_speedX * seconds, 0, this, level);
			//verifica se saiu da área visível
			if (this.x - level.camera.x > level.camera.width - this.width 
				|| this.x - level.camera.x < 0
				) {
				removeBullet();
			}
		}
		
					
		//override 
		public function onCollision(result :CollisionResult) :void {
			//var bu :Bullet = result.moving as Bullet;
			if (result.other is Tile) {
				var tile :Tile = result.other as Tile;
				
				if (tile.id == 2 || tile.id == 3) {
					//wall
					if (result.direction == CollisionResult.EAST) {
						removeBullet();
					}
				}		
			}  
			//remover o bullet se acertar um sprite?
			//TODO: ajustar o BrownCircle pra ter seu próprio método de colisão
			else if (result.other is BrownCircle) {
				(result.other as BrownCircle).explode();
			}
		}
		
		private function removeBullet () : void
		{
			this.level.removeSprite(this);
			
			if (this.bulletListener != null) {
				this.bulletListener.onBulletRemoved();
			}
		}
		
	}

}