package  
{
	import flash.display.Graphics;
	import framework.*;
	
	public class Explosion extends Sprite
	{

		public static const ANIMATION_FRAMES :Array = [4];
		public static const ANIMATION_TIMES :Array = [350];
		
		public function Explosion(level :DaveLevel, y:Number, x:Number) 
		{
			super(level, Images.explosion, ANIMATION_FRAMES, ANIMATION_TIMES);
			this.x = x;
			this.y = y;
			this.animation = 0;
			this.playAnimation = true;
		}
		
		
	}

}