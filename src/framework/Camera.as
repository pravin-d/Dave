package framework {
	import framework.Level;
	
	public class Camera {
		
		// Attributes
		
		public var offsetX :Number;
		public var offsetY :Number;
		
		public var x :Number;
		public var y :Number;
		public var width :Number;
		public var height :Number;
		
		// Constructors
		
		public function Camera(offsetX :Number, offsetY :Number, x :Number, y :Number, width :Number, height :Number)  {
			this.offsetX = offsetX;
			this.offsetY = offsetY;
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
	}
	
}