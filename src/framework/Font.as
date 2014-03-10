package framework {
	import flash.display.Graphics;
	
	public class Font {
		
		public var image :ImageGrid;
		
		public function Font(image :ImageGrid) {
			this.image = image;
		}
		
		public function render (graphics :Graphics, texto :String, x :Number, y :Number) :void {
			for (var i :Number = 0; i < texto.length; i++) {
				var charCode :Number = texto.charCodeAt(i) - 32;
				var indiceY :int = charCode / 16;
				var indiceX :int = charCode % 16;
				image.render(graphics, x+ i*12, y, indiceX, indiceY);
			}
		}
		
	}

}