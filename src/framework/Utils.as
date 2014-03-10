package framework {
	public class Utils {
		
		public static function addAll(array :Array, elements :Array) :void {
			for (var i :String in elements) {
				array.push(elements[i]);
			}
		}
		
		public static function remove(array :Array, element :Object) :void {
			for (var i :int = 0; i < array.length; i++) {
				if (array[i] == element) {
					array.splice(i, 1);
				}
			}
		}
		
		public static function degreesToRadians(degrees :Number) :Number {
			return degrees * Math.PI / 180.0;
		}
		
		public static function leadingZeros(value :Number, size :Number) :String {
			var result :String = "";
			for (var i :int = 0; i < size - value.toString().length; i++) {
				result += "0";
			}
			result += value.toString();
			return result;
		}
		
	}
}