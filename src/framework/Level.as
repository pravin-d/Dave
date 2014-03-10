package framework {
	import flash.display.Graphics;
	
	public class Level {
		
		// Attributes
		
		public var game :Game;
		public var camera :Camera;
		
		public var tileWidth :Number;
		public var tileHeight :Number;
		public var sizeX :Number;
		public var sizeY :Number;
		
		public var tiles :Array;
		public var sprites :Array = [];
		
		public var playerFired :Boolean = false;
		
		// Constructors
		
		public function Level(game :Game, camera :Camera) {
			this.game = game;
			this.camera = camera;
		}
		
		// Properties
		
		public function get worldWidth() :Number {
			return sizeX * tileWidth;
		}
		
		public function get worldHeight() :Number {
			return sizeY * tileHeight;
		}
		
		// Methods
		
		public function update(seconds :Number) :void {
			for (var y :int = 0; y < tiles.length; y++) {
				for (var x :int = 0; x < tiles[y].length; x++) {
					if (tiles[y][x] != null) {
						var tile : Tile = tiles[y][x];
						tile.update(seconds);
					}
				}
			}
			for each (var sprite :Sprite in sprites) {
				sprite.update(seconds);
			}
		}
		
		public function render(graphics :Graphics) :void {
			var offsetX :Number = camera.offsetX - camera.x;
			var offsetY :Number = camera.offsetY - camera.y;
			
			for (var y :int = 0; y < tiles.length; y++) {
				for (var x :int = 0; x < tiles[y].length; x++) {
					if (tiles[y][x] != null) {
						var tile :Tile = tiles[y][x];
						tile.render(graphics, offsetX, offsetY);
					}
				}
			}
			for each (var sprite :Sprite in sprites) {
				sprite.render(graphics, offsetX, offsetY);
			}
		}
		
		public function addSprite(sprite :Sprite) :void {
			sprites.push(sprite);
			sprite.level = this;
		}
		
		public function removeSprite(sprite :Sprite) :void {
			var i :Number = 0;
			for each (var gameSprite :Sprite in sprites) {
				if (gameSprite == sprite) {
					sprites.splice(i, 1);
				}
				i++;
			}
		}
		
	}
}