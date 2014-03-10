package framework {
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Graphics;
	
	public class Game extends MovieClip {
		
		// Attributes
		
		private var lastTime :Number = 0;
		
		public var functions :Array = [];
		public var keyboard :GameKeyboard;

		// Constructors
		
		public function Game() {
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.quality = 'low';
		}
		
		// Public Methods
		
		public function execute(seconds :Number, functionToExecute :Function) :void {
			var timedFunction :TimedFunction = new TimedFunction(this, seconds, functionToExecute);
			functions.push(timedFunction);
		}
		
		// Abstract Methods
		
		public function load() :void { }
		
		public function update(seconds :Number) :void {
			for (var i :int; i < functions.length; i++) {
				var timedFunction :TimedFunction = functions[i];
				timedFunction.update(seconds);
			}
		}
		
		public function render(graphics :Graphics) :void { }
		
		// Private Methods
		
		private function addedToStage(event :Event) :void { 
			load(); 
		}
		
		private function enterFrame(event :Event) :void {
			// calculate seconds since last game frame
			if (lastTime == 0) {
				lastTime = new Date().getTime();
			}
			var currentTime :Number = new Date().getTime();
			var seconds :Number = (currentTime - lastTime) / 1000.0;
			if (seconds > 0.016 * 4) seconds = 0.016 * 4;
			lastTime = currentTime;
			
			// update game
			if (keyboard != null) {
				keyboard.update(seconds);
			}
			update(seconds);
			
			// render screen
			graphics.clear();
			render(graphics);
		}
		
		private function keyDown(event :KeyboardEvent) :void {
			if (keyboard != null) {
				keyboard.pressedKeys[event.keyCode] = true;
				if (keyboard.toogledKeys [event.keyCode] is Boolean)
					keyboard.toogledKeys[event.keyCode] = !keyboard.toogledKeys[event.keyCode];
				else 
					keyboard.toogledKeys[event.keyCode] = true;
			}
		}
		
		private function keyUp(event: KeyboardEvent) :void {
			if (keyboard != null) {
				keyboard.pressedKeys[event.keyCode] = false;
			}
		}
		
	}
}