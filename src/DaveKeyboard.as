package {
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import framework.*;
	import physics.*;
	
	public class DaveKeyboard extends GameKeyboard {
		
		// Static
		
		public static const VELOCITY :Number = 60;
		
		// Attributes
		
		public var game :Main;
		
		// Constructors
		
		public function DaveKeyboard(game :Main) {
			this.game = game;
		}
		
		// Overrides
		
		override public function update(seconds :Number) :void {
			if (game.level == null) return;
			var player :Dave = game.level.player;
			if (player == null) return;
			
			if (!player.exploding) {
				if (!player.usingJetpack) {
					if (pressedKeys[Keyboard.LEFT]) {
						player.move( -VELOCITY);
					}
					if (pressedKeys[Keyboard.RIGHT]) {
						player.move( +VELOCITY);
					}
					if (pressedKeys[Keyboard.UP]) {
						player.jump();
					}
					//atira se o player apertou crtl
					if (pressedKeys[Keyboard.CONTROL]) {
						player.shoot();
					}
					//toogla jetpack se o player apertar espaço e tiver jetpack
					if (toogledKeys[Keyboard.SPACE]) {
						toogledKeys[Keyboard.SPACE] = false;
						if (DaveStatus.GetInstance().hasJetpack) 
						{
							player.toggleJetpack();
						}	
					}
				} else {
					if (pressedKeys[Keyboard.LEFT]) {
						player.jetpackMove ( -VELOCITY, 0);
					}
					if (pressedKeys[Keyboard.RIGHT]) {
						player.jetpackMove( +VELOCITY, 0);
					}
					if (pressedKeys[Keyboard.UP]) {
						player.jetpackMove( 0, -VELOCITY);
					}
					if (pressedKeys[Keyboard.DOWN]) {
						player.jetpackMove( 0, +VELOCITY);
					}
					//atira se o player apertou crtl
					if (pressedKeys[Keyboard.CONTROL]) {
						player.shoot();
					}
					if (toogledKeys[Keyboard.SPACE]) {
						toogledKeys[Keyboard.SPACE] = false;
						player.toggleJetpack();
					}
				}
			}
		}
		
	}
}