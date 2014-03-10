package physics {
	
	public class Rectangle {
		
		public var x :Number;
		public var y :Number;
		public var width :Number;
		public var height :Number;
		
		public function Rectangle(x :Number, y :Number, width :Number, height :Number) {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function get endX() :Number { return x + width; }
		public function get endY() :Number { return y + height; }
		
		public function intersects(other :Rectangle) :Boolean {
			if ((this.x + this.width) <= other.x) return false;
			if (this.x >= (other.x + other.width)) return false;
			if ((this.y + this.height) <= other.y) return false;
			if (this.y >= (other.y + other.height)) return false;
			return true;
		}
		
		public function toString() :String {
			return "Rectangle[x="+x+",y="+y+",width="+width+",height="+height+"]";
		}
		
	}
	
}