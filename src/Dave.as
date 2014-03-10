package {
	import flash.display.Graphics;
	import framework.*;
	import physics.*;
	
	public class Dave extends Sprite implements IBulletListener {
		
		// Static
		
		public static const ANIMATION_FRAMES :Array = [1, 4, 1, 2];
		public static const ANIMATION_TIMES :Array = [0, 100, 0, 100];
		
		public static const ANIMATION_STANDING :Number = 0;
		public static const ANIMATION_WALKING :Number = 1;
		public static const ANIMATION_JUMPING :Number = 2;
		public static const ANIMATION_BLINKING:Number = 3;
		
		// Attributes
		
		public var speedX :Number = 0;
		public var speedY :Number = 0;
		
		public var jumping :Boolean = false;
		public var falling :Boolean = false;
		public var exploding :Boolean = false;
		public var usingJetpack :Boolean = false;
		
		public var hasBulletOnScreen :Boolean = false;
		
		// Constructors
		
		public function Dave(level :DaveLevel, y :Number, x :Number) {
			super(level, Images.dave, ANIMATION_FRAMES, ANIMATION_TIMES);
			
			//this.x = x * level.tileWidth;
			//this.y = y * level.tileHeight;
			//substituição do código comentado acima
			this.restart(y, x);
			
			this.collisionListener = new DaveCollisionListener();
		}
		
		// Properties
		
		override public function get collisionRectangle() :Rectangle {
			return new Rectangle(x +3, y +1, width - 6, height -1);
		}
		
		// Methods
		
		public function move(velocity :Number) :void {
			if (velocity < 0) {
				flipX = true;
			} else {
				flipX = false;
			}
			speedX = velocity;
			if (!jumping && !falling) {
				Sounds.walking.loop();
				playAnimation = true;
				animation = ANIMATION_WALKING;
			}
		}
		
		public function jump() :void {
			if (!jumping && !falling) {
				Sounds.jump.play();
				Sounds.walking.stop();
				animation = ANIMATION_JUMPING;
				speedY = -90;
				jumping = true;
			}
		}
		
		public function land() :void {
			speedY = 0;
			if (jumping) {
				Sounds.jump.stop();
				jumping = false;
				animation = ANIMATION_STANDING;
			}
			if (falling) {
				Sounds.falling.stop();
				falling = false;
			}
		}
		
		public function fall() :void {
			Sounds.walking.stop();
			Sounds.falling.play();
			falling = true;
			animation = ANIMATION_WALKING;
			playAnimation = false;
			speedY = 90;
		}
		
		public function restart(y:Number, x:Number) :void {
			this.x = x * level.tileWidth;
			this.y = y * level.tileHeight;
			this.animation = ANIMATION_BLINKING;
			playAnimation = true;
		}
		
		// Overrides
		
		override public function update(seconds :Number) :void {
			super.update(seconds);
			if (this.animation != ANIMATION_BLINKING) {
				if (!usingJetpack) {
					if (speedX == 0) {
						Sounds.walking.stop();
						playAnimation = false;
					}
					if (speedY > 0 && !jumping && !falling) {
						fall();
					}
					if (!falling) {
						var gravity :Number = 120 * seconds;
						speedY += gravity;
						speedY = Math.min(speedY, 90);
					}
					
					Physics.move(speedX * seconds, speedY * seconds, this, level);
					speedX = 0;
				} else {
					//mover utilizando o jetpack
					var status :DaveStatus = DaveStatus.GetInstance();
					status.jetpackFuel -= seconds * 10;
					if (status.jetpackFuel <= 0) {
						status.hasJetpack = false;
						toggleJetpack();
					}
					Physics.move(speedX * seconds, speedY * seconds, this, level);
					speedX = 0;
					speedY = 0;
				}
			}
			
		}
		
		public function explode() :void {
			if (this.exploding == false) {
				if (this.usingJetpack) {
					this.toggleJetpack();
				}
				
				var explosion:Explosion = new Explosion (this.level as DaveLevel, this.y, this.x);
				this.level.addSprite (explosion);
				this.exploding = true;
				this.visible = false; //variável adicionada à sprite
				Sounds.death.play();
				level.game.execute(3, function() :void {
					(level as DaveLevel).SetPlayerToInitialPosition();
					level.removeSprite (explosion); //mt louco, isso pega!!!
					exploding = false;
					visible = true;
				});
				
				//TODO: modificar esse código para não acessar diretamente a variável
				DaveStatus.GetInstance().lives --;
			}
		}
		
		public function shoot() :void {
			var daveStatus:DaveStatus = DaveStatus.GetInstance();
			if (daveStatus.hasGun && !this.hasBulletOnScreen) {
				var bulletX :Number = this.x / this.level.tileWidth;
				var bulletY :Number = this.y / this.level.tileHeight;
				var direction :int = ((this.flipX)? -1 : 1);
				var b :Bullet  = new Bullet(this.level as DaveLevel, bulletY, bulletX + direction, direction, true);
				b.bulletListener = this;
				this.level.addSprite(b);
				this.hasBulletOnScreen = true;
			}
		}
		
		public function onBulletRemoved () : void {
			//aplicando um delay
			this.level.game.execute (1, function () :void { hasBulletOnScreen = false; } );
		}
		
		//toogla o jetpack (desliga se estiver ligado e liga caso contrário)
		//seta a variável usingjetpack pra true	
		public function toggleJetpack () : void {
			//apenas executa se o dave tiver o item jetpack
			if (DaveStatus.GetInstance().hasJetpack) {
				if (this.usingJetpack) {
					this.usingJetpack = false;
					Sounds.jetpack.stop();
					
					playAnimation = true;
					image = Images.dave;
					animationFrames = ANIMATION_FRAMES;
					animationTimes = ANIMATION_TIMES;
					animation = 0;
					
				} else  {
					this.usingJetpack = true;
					Sounds.jetpack.loop();
					Sounds.toogleJetpack.play();

					playAnimation = true;
					image = Images.davejetpack;
					
					animationFrames = [4];
					animationTimes = [50];
					animation = 0;
					
					falling = false;
					jumping = false;
				}
			}
		}
		
		public function jetpackMove(velocityX :Number, velocityY :Number) :void {
			if (velocityX < 0) {
				flipX = true;
			} else {
				flipX = false;
			}
			speedX = velocityX;
			speedY = velocityY;
		}
	}
}