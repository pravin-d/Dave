package {
	import framework.*;
	import physics.*;
	
	public class DaveCollisionListener implements ICollisionListener {
			
		//override 
		public function onCollision(result :CollisionResult) :void {
			var player :Dave = result.moving as Dave;
			var daveStatus: DaveStatus = DaveStatus.GetInstance();
			//não pode fazer pickup se estiver exploding
			if (result.other is Tile) {
				var tile :Tile = result.other as Tile;
				var level :Level = tile.level;
				var main :Main = level.game as Main;
				var pickup :Boolean = true;
				//if (this.bla == false) {
				switch (tile.id) {
					case 8: case 9: case 10: case 11:case 12: case 13: 
						Sounds.pickup.play();
						level.tiles[tile.tileY][tile.tileX] = null;
						daveStatus.score += Levels.scores[tile.id];
					break;
					case 23: //gun
						DaveStatus.GetInstance().hasGun = true;
						level.tiles[tile.tileY][tile.tileX] = null;
					break;
					case 24: //jetpack
						DaveStatus.GetInstance().hasJetpack = true;
						level.tiles[tile.tileY][tile.tileX] = null;
					break;
					case 14:
						Sounds.trophy.play();
						level.tiles[tile.tileY][tile.tileX] = null;
						daveStatus.score += Levels.scores[tile.id];
						//TODO: colocar essa variável no level
						main.portaAberta = true;
					break;
					case 15: case 16: case 17:
						pickup = false;
						// reinicia a posição do dave
						// diminue a quantidade dos daves					
						player.explode();
					break;
					default:
						pickup = false;
					break;
				}
			//não há colisão com explosion
			} else if (result.other is Explosion) {
				return;
				
			} else if (result.other is Sprite) {
				pickup = false;
				player.explode();
			}
			
			//gambi para evitar fazer colisão com a explosion
			//TODO: melhorar esse código
			if (player.exploding) { 
				player.land();
			}
			else if (!pickup && player.animation != Dave.ANIMATION_BLINKING) {
				player.x += result.offsetX;
				player.y += result.offsetY;
				
				if (result.direction == CollisionResult.SOUTH) {
					player.land();
				}
				if (result.direction == CollisionResult.NORTH) {
					player.speedY = 0;
				}
			}
		}
		
	}
}