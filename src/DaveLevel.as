package  {
	import framework.*;
	import physics.*;
	
	public class DaveLevel extends Level {
		
		// Attributes
		
		public var player :Dave;
		
		private var xLowerBound :Number;
		private var xUpperBound :Number;
		
		private var pan :Number = 0;
		private var count :Number = 0;
		
		private var playerInitialX:Number;
		private var playerInitialY:Number;
		
		// Constructors
		
		public function DaveLevel(game :Main, level :Object, camera :Camera) {
			super(game, camera);
			
			this.tileWidth = 16;
			this.tileHeight = 16;
			
			this.sizeY = level.data.length;
			tiles = new Array(sizeY);
			for (var y :int = 0; y < level.data.length; y++) {
				this.sizeX = level.data[y].length;
				tiles[y] = new Array(sizeX);
				for (var x :int = 0; x < level.data[y].length; x++) {
					var id :int = level.data[y][x];
					if (id == 1) {
						player = new Dave(this, y, x);
						playerInitialX = x;
						playerInitialY = y;
						this.addSprite(player);
					}
					else if (id == 25) {
						var brownCircle :BrownCircle = new BrownCircle(this, y, x);
						this.addSprite(brownCircle);
					}
					else if (id != 0) {
						tiles[y][x] = new Tile(this, Images.tiles, id, y, x);
					}
				}
			}
			
			this.xLowerBound = 0;
			this.xUpperBound = this.worldWidth - camera.width;
		}
			
		// Override
		
		override public function update(seconds :Number) :void {
			super.update(seconds);
			
			if (pan != 0) {
				if (pan > 0) {
					incrementCameraX(pan * tileWidth);
					count += 1;
					if (count == 15) {
						pan = 0;
					}
				}
				if (pan < 0) {
					incrementCameraX(pan * tileWidth);
					count -= 1;
					if (count == -15) {
						pan = 0;
					}
				}
			} else {
				if (camera.x + camera.width - player.x < 48) {
					if (camera.x >= xUpperBound) return;
					count = 0;
					pan = 1;
				}
				if (player.x - camera.x < 16) {
					if (camera.x <= xLowerBound) return;
					count = 0;
					pan = -1;
				}
			}
		}
		
		private function incrementCameraX(value :Number) :void {
			if (value > 0) {
				if (camera.x + value > xUpperBound) {
					camera.x = xUpperBound;
				} else {
					camera.x += value;
				}
			}
			if (value < 0) {
				if (camera.x + value < xLowerBound) {
					camera.x = xLowerBound;
				} else {
					camera.x += value;
				}
			}
		}
		
		public function SetPlayerToInitialPosition () :void {
			player.restart(this.playerInitialY, this.playerInitialX);
		}
	}
}