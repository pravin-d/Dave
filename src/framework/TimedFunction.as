package framework {
	
	public class TimedFunction {
		
		private var game :Game;
		private var secondsTillExecute :Number;
		private var functionToExecute :Function;
		
		public function TimedFunction(game :Game, seconds :Number, functionToExecute :Function) {
			this.game = game;
			this.secondsTillExecute = seconds;
			this.functionToExecute = functionToExecute;
		}
		
		public function update(seconds :Number) :void {
			this.secondsTillExecute -= seconds;
			if (this.secondsTillExecute <= 0) {
				this.functionToExecute();
				Utils.remove(this.game.functions, this);
			}
		}
		
	}
	
}