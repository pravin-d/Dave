package framework {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	
	public class ImageGrid {
		
		// Attributes
		
		public var bitmap :Bitmap;
		public var width :Number;
		public var height :Number;
		
		// Constructors
		
		public function ImageGrid(bitmap :Bitmap, width :Number, height: Number) { 
			this.bitmap = bitmap;
			this.width = width;
			this.height = height;
		}
		
		// Methods
		
		public function render(graphics :Graphics, x :Number, y :Number, animationX :Number = 0, animationY :Number = 0, flipX :Boolean = false, flipY :Boolean = false) :void {
			var matrix :Matrix = new Matrix();
			x = Math.round(x);
			y = Math.round(y);
			var ax :Number = animationX * width;
			var ay :Number = animationY * height;
			
			if (flipX) {
				matrix.a = -1;
				matrix.tx = width;
			}
			if (flipY) {
				matrix.d = -1;
				matrix.ty = height;
			}
			matrix.translate(x - ax, y - ay);
			
			graphics.beginBitmapFill(bitmap.bitmapData, matrix);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}
		
	}
}