package framework {
	import flash.display.Graphics;
	import physics.ICollisionListener;
	import physics.Rectangle;
	
	public class Sprite {
		
		// Attributes
		
		private var _x :Number;
		private var _y :Number;
		public var width :Number;
		public var height :Number;
		
		public var level :Level;
		public var image :ImageGrid;
		public var collisionListener :ICollisionListener;
		
		public var animationX :Number = 0;
		public var animationY :Number = 0;
		
		public var animationFrames :Array;
		public var animationTimes :Array;
		
		public var playAnimation :Boolean = true;
		public var flipX :Boolean;
		public var flipY :Boolean;
		
		private var animationCounter :Number = 0;
		
		public var visible :Boolean;
		
		// Constructors
		
		public function Sprite(level :Level, image :ImageGrid, animationFrames :Array = null, animationTimes :Array = null) {
			this.level = level;
			this.x = 0;
			this.y = 0;
			this.width = image.width;
			this.height = image.height;
			
			this.image = image;
			this.animationFrames = (animationFrames != null) ? animationFrames : [1];
			this.animationTimes = (animationTimes != null) ? animationTimes : [0];
			
			visible = true;
		}
		
		// Properties
		
		public function get x() :Number { return _x; }
		public function set x(value :Number) :void { this._x = Math.round(value * 100) / 100.0; }
		
		public function get y() :Number { return _y; }
		public function set y(value :Number) :void { this._y = Math.round(value * 100) / 100.0; }
		
		public function get collisionRectangle() :Rectangle {
			return new Rectangle(x, y, width, height);
		}
		
		public function get animation() :Number {
			return animationY;
		}
		
		public function set animation(animation :Number) :void {
			if (animation != animationY) {
				animationX = 0;
				animationY = animation;
			}
		}
		
		// Methods
			
		public function render(graphics :Graphics, offsetX :Number = 0, offsetY :Number = 0) :void {
			if (visible) {
				image.render(graphics, x + offsetX, y + offsetY, animationX, animationY, flipX, flipY);
			}
		}
		
		// Overrides
		
		public function update(seconds :Number) :void {
			if (!playAnimation || animationFrames[animationY] <= 1) return;
			
			animationCounter += seconds * 1000;
			if (animationCounter > animationTimes[animationY]) {
				animationCounter = 0;
				animationX = (animationX +1) % animationFrames[animationY];
			}
		}
		
		public function toString() :String {
			return "Sprite[x=" + x + ",y=" + y + "]";
		}
		
	}
}