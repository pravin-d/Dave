package physics {
	import framework.*;
	
	public class Physics {
		
		public static function move(x :Number, y :Number, sprite :Sprite, level :Level) :void {
			moveX(x, sprite, level);
			moveY(y, sprite, level);
		}
		
		public static function moveX(x :Number, sprite :Sprite, level :Level) :void {
			var oldX :Number = sprite.x;
			sprite.x += x;
			
			var possibleCollisions :Array = collidingTiles(sprite, level);
			for each (var levelSprite :Sprite in level.sprites) {
				possibleCollisions.push(levelSprite);
			}
			
			// collision results
			var offset :Number = Number.MAX_VALUE;
			var otherSprite :Sprite;
			
			var spriteBox :Rectangle = sprite.collisionRectangle;
			for each (var other :Sprite in possibleCollisions) {
				if (other == sprite) continue;
				var otherBox :Rectangle = other.collisionRectangle;
				if (otherBox == null || !otherBox.intersects(spriteBox)) continue;
				
				if (oldX <= other.x) { // right collision
					var c1 :Number = otherBox.x - spriteBox.endX;
					if (Math.abs(c1) < Math.abs(offset)) {
						offset = c1;
						otherSprite = other;
					}
				} else { // left collision
					var c2 :Number = otherBox.endX - spriteBox.x;
					if (Math.abs(c2) < Math.abs(offset)) {
						offset = c2;
						otherSprite = other;
					}
				}
			}
			if (offset != Number.MAX_VALUE && sprite.collisionListener != null) {
				sprite.collisionListener.onCollision(new CollisionResult(sprite, otherSprite, offset, 0));
			}
		}
		
		public static function moveY(y :Number, sprite :Sprite, level :Level) :void {
			var oldY :Number = sprite.y;
			sprite.y += y;
			
			var possibleCollisions :Array = collidingTiles(sprite, level);
			for each (var levelSprite :Sprite in level.sprites) {
				possibleCollisions.push(levelSprite);
			}
			
			// collision results
			var offset :Number = Number.MAX_VALUE;
			var otherSprite :Sprite;
			
			var spriteBox :Rectangle = sprite.collisionRectangle;
			for each (var other :Sprite in possibleCollisions) {
				
				if (other == sprite) continue;
				var otherBox :Rectangle = other.collisionRectangle;
				if (otherBox == null || !otherBox.intersects(spriteBox)) continue;
				
				if (oldY <= other.y) { // south collision
					var c1 :Number = otherBox.y - spriteBox.endY;
					if (Math.abs(c1) < Math.abs(offset)) {
						offset = c1;
						otherSprite = other;
					}
				} else { // north collision
					var c2 :Number = otherBox.endY - spriteBox.y;
					if (Math.abs(c2) < Math.abs(offset)) {
						offset = c2;
						otherSprite = other;
					}
				}
			}
			if (offset != Number.MAX_VALUE && sprite.collisionListener != null) {
				sprite.collisionListener.onCollision(new CollisionResult(sprite, otherSprite, 0, offset));
			}
		}
		
		public static function collidingTiles(sprite :Sprite, level :Level) :Array {
			var result :Array = [];
			
			var spriteBox :Rectangle = sprite.collisionRectangle;
			var startX :int = (int) (spriteBox.x / level.tileWidth);
			var startY :int = (int) (spriteBox.y / level.tileHeight);
			var endX :int = (int) (spriteBox.x + spriteBox.width) / level.tileWidth;
			var endY :int = (int) (spriteBox.y + spriteBox.height) / level.tileHeight;
			
			if ((spriteBox.x + spriteBox.width) % level.tileWidth == 0) endX--;
			if ((spriteBox.y + spriteBox.height) % level.tileHeight == 0) endY--;
			
			for (var x :int = Math.max(startX, 0); x <= Math.min(endX, level.sizeX -1); x++) {
				for (var y :int = Math.max(startY, 0); y <= Math.min(endY, level.sizeY -1); y++) {
					if (level.tiles[y][x] != null) result.push(level.tiles[y][x]);
				}
			}
			return result;
		}
		
	}
}