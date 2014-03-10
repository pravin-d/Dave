package {
	import flash.display.Graphics;
	import framework.*;
	import physics.*;
	
	public class Tile extends Sprite {
		
		// Static
		
		public static const PINK_FLOOR :Number = 7;
		public static const ID_TROOPHY :Number = 14;
		
		public static const ANIMATION_FRAMES :Array = [1,1,1,1,1, 1,1,1,1,1,  1,1,1,1,6,  4,4,5,1,1,  1,1,1,1,1, 1];
		public static const ANIMATION_TIMES :Array = [0,0,0,0,0,  0,0,0,0,0,  0,0,0,0,90,  90,90,90,0,0,  0,0,0,0,0, 0];
		
		// Attributes
		
		public var id :Number;
		
		// Constructors
		
		public function Tile(level :DaveLevel, image :ImageGrid, id :Number, y :Number, x :Number) {
			super(level, image, ANIMATION_FRAMES, ANIMATION_TIMES);
			this.x = x * level.tileWidth;
			this.y = y * level.tileHeight;
			this.id = id;
			this.animationX = 0;
			this.animationY = id;
		}
		
		// Properties
		
		public function get tileX() :Number { return x / level.tileWidth; }
		public function get tileY() :Number { return y / level.tileHeight; }
		
		override public function get collisionRectangle() :Rectangle {
			if (id == 8 || id == 9 || id == 10 || id == 11 || id == 12 || id == 13 || id == 14 || id == 23 || id == 24) 
				return new Rectangle(x + 2, y + 2, x - 4, y -4);
			if (id == PINK_FLOOR) return new Rectangle(x, y, width, height -5);
			else return super.collisionRectangle;
		}
		
	}
}