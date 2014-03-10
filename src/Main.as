package {
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import framework.*;
	import physics.*;
	import com.adobe.serialization.json.JSON;
	
	public class Main extends Game {
		
		// Attributes
		
		public var level :DaveLevel;
		public var fonte :Font;
		public var score :Number;
		public var lives :Number;
		public var portaAberta :Boolean;
		
		private var loader :URLLoader = new URLLoader();
		private var daveHud :DaveStatus = DaveStatus.GetInstance();
		
		// Override
		
		override public function load() :void {
			super.load();
			this.keyboard = new DaveKeyboard(this);
			
			if (loaderInfo.parameters['url']) {
				var request : URLRequest = new URLRequest(loaderInfo.parameters['url']);
				loader.addEventListener(Event.COMPLETE, onLevelLoaded);
				loader.load(request);
			} else {
				this.level = new DaveLevel(this, Levels.level3, new Camera(0, 16, 0, 0, 320, 200));
			}
			
			portaAberta = false;
			fonte = new Font (Images.gamefont);
		}
		
		override public function update(seconds :Number) :void {
			super.update(seconds);
			if (level) level.update(seconds);
		}
		
		override public function render(graphics :Graphics) :void {
			super.render(graphics);
			if (level)
			{
				level.render(graphics);
				fonte.render(graphics, "SCORE:" + Utils.leadingZeros(daveHud.score, 5), 0, 0);
				fonte.render(graphics, "DAVES:", 17 * 12, 0);
				for (var i:Number = 0; i < daveHud.lives; i++) {
					fonte.render(graphics, "$", (23 + i) * 12, 0);
				}
				Images.bar.render(graphics, 0, 13);
				graphics.beginFill(0x000000);
				graphics.drawRect(0, 171, 320, 29);
				Images.bar.render(graphics, 0, 172);
				
				//caso tenha obtido o graal
				if (portaAberta) {
					fonte.render(graphics, "#GO THRU THE DOOR!#", 12 * 4, 188);
				}
				//colocar jetpack e gun se ela for visivel
				if (daveHud.hasJetpack) {
					var fuel :Number = DaveStatus.GetInstance().jetpackFuel;
					fonte.render(graphics, "JETPACK", 0, 174);
					Images.jetpackbar.render (graphics, 12 * 8, 174);
					for (i = 0; i < 60 *fuel/100; i++) {
						Images.jetpackfill.render (graphics, (12 * 8) + 4 + (2 * i), 174 + 4);
					}
				}
				if (daveHud.hasGun) {
					fonte.render(graphics, "GUN", 12 * 21, 174);
					Images.gun.render (graphics, 12 * 25, 174); 
				}
			}
		}
		
		private function onLevelLoaded(e : Event):void {
			var o :Object = JSON.decode(loader.data) as Object
			this.level = new DaveLevel(this, o, new Camera(0, 16, 0, 0, 320, 200));
		}  
		
	}
}