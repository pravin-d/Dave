package {
	import framework.Sprite;
	import framework.Level;
	import framework.Utils;
	import physics.*;
	
	public class BrownCircle extends Sprite implements ICollisionListener, IBulletListener {
		
		private var hasBulletOnScreen :Boolean = false;
		
		//override 
		public function onCollision(result :CollisionResult) :void {
			this.level.removeSprite(this);
			//if (result.other is Bullet) {
			//	this.level.removeSprite(this);
			//}
		}
		
		private var xCenter :Number;
		private var yCenter :Number;
		private var angle :Number = 270;
		
		public function BrownCircle(level :DaveLevel, y :Number, x :Number) {
			super(level, Images.browncircle, [1], [0]);
			this.x = x * level.tileWidth;
			this.y = y * level.tileHeight;
			this.xCenter = this.x -6;
			this.yCenter = this.y;
			this.collisionListener = this;
		}
		
		override public function update(seconds :Number) :void {
			angle = (angle + (180 * seconds)) % 360;
			this.x = xCenter + Math.cos(Utils.degreesToRadians(angle)) * 32;
			this.y = yCenter + Math.sin(Utils.degreesToRadians(angle)) * 16;
			
			//TODO: fazer calculo de colisão ou colocar parte desse método em physics
			
			this.shoot();
		}
		
		public function explode() :void {
			var explosion :Explosion = new Explosion (this.level as DaveLevel, this.y, this.x);
			this.level.addSprite (explosion);
			this.level.removeSprite(this);

			Sounds.explosion.play();
			level.game.execute(3, function() :void {
				level.removeSprite (explosion); //mt louco, isso pega!!!
			});			
		}
		
		private function shoot () :void {
			//TODO: implementar IA (atirar apenas quando o player estiver na mesma linha (mesmo valor de y)
			if (!hasBulletOnScreen && this.xCenter - this.level.camera.x < this.level.camera.width)
			{
				var bulletX :Number = this.x / this.level.tileWidth;
				var bulletY :Number = this.y / this.level.tileHeight;
				var direction :int = -1;
				var b :Bullet  = new Bullet(this.level as DaveLevel, bulletY, bulletX + direction, direction, false);
				b.bulletListener = this;
				this.level.addSprite(b);
				this.hasBulletOnScreen = true;
			}
		}
		
		public function onBulletRemoved () : void {
			//aplicando um delay
			this.level.game.execute (1, function () :void { hasBulletOnScreen = false; } );
		}
		
	}

}