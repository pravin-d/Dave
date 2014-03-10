package physics {
	import framework.Sprite;
	
	public class CollisionResult {
		
		// Static
		
		public static const NORTH :Number = 1;
		public static const NORTHEAST :Number = 2;
		public static const EAST :Number = 3;
		public static const SOUTHEAST :Number = 4;
		public static const SOUTH :Number = 5;
		public static const SOUTHWEST :Number = 6;
		public static const WEST :Number = 7;
		public static const NORTHWEST :Number = 8;
		
		public static const DESCRIPTIONS :Array = ['NONE', 'NORTH', 'NORTHEAST', 'EAST', 'SOUTHEAST', 'SOUTH', 'SOUTHWEST', 'WEST', 'NORTHWEST'];
		
		// Attributes
		
		public var moving :Sprite;
		public var other :Sprite;
		public var offsetX :Number;
		public var offsetY :Number;
		
		// Constructors
		
		public function CollisionResult(moving :Sprite, other :Sprite, offsetX :Number, offsetY :Number) {
			this.moving = moving;
			this.other = other;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
		}
		
		// Properties
		
		public function get directionString() :String {
			return DESCRIPTIONS[direction];
		}
		
		public function get direction() :Number {
			if (offsetX == 0 && offsetY  < 0) return CollisionResult.SOUTH;
			if (offsetX  > 0 && offsetY  < 0) return CollisionResult.SOUTHWEST;
			if (offsetX  > 0 && offsetY == 0) return CollisionResult.WEST;
			if (offsetX  > 0 && offsetY  > 0) return CollisionResult.NORTHWEST;
			if (offsetX == 0 && offsetY  > 0) return CollisionResult.NORTH;
			if (offsetX  < 0 && offsetY  > 0) return CollisionResult.NORTHEAST;
			if (offsetX  < 0 && offsetY == 0) return CollisionResult.EAST;
			if (offsetX  < 0 && offsetY  < 0) return CollisionResult.SOUTHEAST;
			return 0;
		}
		
		// Overrides
		
		public function toString() :String {
			return "CollisionResult[direction=" + directionString + ", offsetX=" + offsetX + ", offsetY=" + offsetY + "]";
		}
		
	}
}