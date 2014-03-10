package framework {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class GameSound {
		
		private var looping :Boolean = false;
		private var sound :Sound;
		private var channel :SoundChannel;
		
		public function GameSound(clazz :Class) {
			this.sound = new clazz() as flash.media.Sound;
		}
		
		public function play() :void {
			if (channel) channel.stop();
			channel = sound.play();
		}
		
		public function loop() :void {
			if (looping == false) {
				looping = true;
				channel = sound.play(0, 999999);
			}
		}
		
		public function stop() :void {
			looping = false;
			if (channel) channel.stop();
		}
	}
}