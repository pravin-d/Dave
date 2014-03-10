package {
	import framework.*;
	import physics.*;
	
	public class Images {
		
		[Embed(source='../lib/bar.png')]
		private static var Bar :Class;
		
		[Embed(source='../lib/dave.png')]
		private static var Dave :Class;

		[Embed(source='../lib/explosion.png')]
		private static var Explosion :Class;		
		
		[Embed(source='../lib/tiles.png')]
		private static var Tiles :Class;
		
		[Embed(source='../lib/gamefont.png')]
		private static var GameFont :Class;
		
		[Embed(source='../lib/browncircle.png')]
		private static var BrownCircle :Class;
		
		[Embed(source='../lib/bullet.png')]
		private static var DaveBullet :Class;
		
		[Embed(source='../lib/enemyray.png')]
		private static var BrownCircleBullet :Class;
		
		[Embed(source='../lib/gun.png')]
		private static var Gun :Class;
		
		[Embed(source='../lib/jetpackbar.png')]
		private static var JetpackBar :Class;
		
		[Embed(source='../lib/jetpackfill.png')]
		private static var JetpackFill :Class;
		
		[Embed(source='../lib/davejetpack.png')]
		private static var DaveJetpack :Class;		
		
		// Static
		
		public static var bar :ImageGrid =  new ImageGrid(new Bar(), 320, 2);
		public static var dave :ImageGrid = new ImageGrid(new Dave(), 16, 16);
		public static var explosion :ImageGrid = new ImageGrid(new Explosion(), 16, 16);
		public static var tiles :ImageGrid = new ImageGrid(new Tiles(), 16, 16);
		public static var gamefont :ImageGrid = new ImageGrid(new GameFont(), 12, 12);
		public static var browncircle :ImageGrid = new ImageGrid(new BrownCircle(), 27, 15);
		public static var davebullet :ImageGrid = new ImageGrid(new DaveBullet(), 8, 3);
		public static var browncirclebullet :ImageGrid = new ImageGrid(new BrownCircleBullet(), 18, 3);
		public static var gun :ImageGrid = new ImageGrid(new Gun(), 18, 11);
		public static var jetpackbar :ImageGrid = new ImageGrid(new JetpackBar(), 128, 12);
		public static var jetpackfill :ImageGrid = new ImageGrid(new JetpackFill(), 2, 4);
		public static var davejetpack :ImageGrid = new ImageGrid(new DaveJetpack(), 18, 16);
	}	
}
