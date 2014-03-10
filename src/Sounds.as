package {
	import flash.media.SoundChannel;
	import flash.events.Event;
	import framework.GameSound;
	
	public class Sounds {
		
		[Embed(source='../lib/death.mp3')]
		private static var Death :Class;
		
		[Embed(source='../lib/explosion.mp3')]
		private static var Explosion :Class;
		
		[Embed(source='../lib/falling.mp3')]
		private static var Falling :Class;
		
		[Embed(source='../lib/jump.mp3')]
		private static var Jump :Class;
		
		[Embed(source='../lib/pickup.mp3')]
		private static var Pickup :Class;
		
		[Embed(source='../lib/trophy.mp3')]
		private static var Trophy :Class;
		
		[Embed(source='../lib/walking.mp3')]
		private static var Walking :Class;
		
		[Embed(source='../lib/toogleJetpack.mp3')]
		private static var ToogleJetpack :Class;
		
		[Embed(source='../lib/jetpack.mp3')]
		private static var Jetpack :Class;
		
		public static var death :GameSound = new GameSound(Death);
		public static var explosion :GameSound = new GameSound(Explosion);
		public static var falling :GameSound = new GameSound(Falling);
		public static var jump :GameSound = new GameSound(Jump);
		public static var pickup :GameSound = new GameSound(Pickup);
		public static var trophy :GameSound = new GameSound(Trophy);
		public static var walking :GameSound = new GameSound(Walking);
		public static var toogleJetpack :GameSound = new GameSound(ToogleJetpack);
		public static var jetpack :GameSound = new GameSound(Jetpack);
	}

}