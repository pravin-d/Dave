package  
{
	/**
	 * class that keeps global information about dave
	 * implemented as a singleton keeps information needed in "Game.as" and "Dave.as" methods
	 * @author farinha
	 */
	public class DaveStatus
	{
	
		public var hasGun :Boolean;
		public var hasJetpack :Boolean;
		public var lives :Number;
		public var jetpackFuel :Number;
		public var score :Number;
		private static var instance :DaveStatus;
		
		public function DaveStatus() 
		{
			hasGun = false;
			hasJetpack = false;
			lives = 3;
			jetpackFuel = 100;
			score = 0;
		}
		
		public static function GetInstance() : DaveStatus
		{
			if (instance == null) {
				instance = new DaveStatus();
			}
			return instance;
		}
	}

}