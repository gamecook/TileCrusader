/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/15/11
 * Time: 8:51 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers {
    import com.gamecook.tilecrusader.sounds.TCSound;

    public class SoundManager {

        private var sounds:Array = [];
        private var music:TCSound;
        private var _mute:Boolean = false;
        private var _volume:Number = 1;

        public function SoundManager()
        {
        }

        /**
		 * Set up and play a looping background soundtrack.
		 *
		 * @param	Music		The sound file you want to loop in the background.
		 * @param	Volume		How loud the sound should be, from 0 to 1.
		 */
		public function playMusic(Music:Class,Volume:Number=1.0):void
		{
			if(music == null)
				music = new TCSound(this);
			else if(music.active)
				music.stop();
			music.loadEmbedded(Music,true);
			music.volume = Volume;
			music.survive = true;
			music.play();
		}

		/**
		 * Creates a new sound object from an embedded <code>Class</code> object.
		 *
		 * @param	EmbeddedSound	The sound you want to play.
		 * @param	Volume			How loud to play it (0 to 1).
		 * @param	Looped			Whether or not to loop this sound.
		 *
		 * @return	A <code>FlxSound</code> object.
		 */
		public function play(EmbeddedSound:Class,Volume:Number=1.0,Looped:Boolean=false):TCSound
		{
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
				if(!(sounds[i] as TCSound).active)
					break;
			if(sounds[i] == null)
				sounds[i] = new TCSound(this);
			var s:TCSound = sounds[i];
			s.loadEmbedded(EmbeddedSound,Looped);
			s.volume = Volume;
			s.play();
			return s;
		}

		/**
		 * Creates a new sound object from a URL.
		 *
		 * @param	EmbeddedSound	The sound you want to play.
		 * @param	Volume			How loud to play it (0 to 1).
		 * @param	Looped			Whether or not to loop this sound.
		 *
		 * @return	A TCSound object.
		 */
		public function stream(URL:String,Volume:Number=1.0,Looped:Boolean=false):TCSound
		{
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
				if(!(sounds[i] as TCSound).active)
					break;
			if(sounds[i] == null)
				sounds[i] = new TCSound(this);
			var s:TCSound = sounds[i];
			s.loadStream(URL,Looped);
			s.volume = Volume;
			s.play();
			return s;
		}

		/**
		 * Set <code>mute</code> to true to turn off the sound.
		 *
		 * @default false
		 */
		public function get mute():Boolean
		{
			return _mute;
		}

		/**
		 * @private
		 */
		public function set mute(Mute:Boolean):void
		{
			_mute = Mute;
			changeSounds();
		}

		/**
		 * Get a number that represents the mute state that we can multiply into a sound transform.
		 *
		 * @return		An unsigned integer - 0 if muted, 1 if not muted.
		 */
		public function getMuteValue():uint
		{
			if(_mute)
				return 0;
			else
				return 1;
		}

		/**
		 * Set <code>volume</code> to a number between 0 and 1 to change the global volume.
		 *
		 * @default 0.5
		 */
		 public function get volume():Number { return _volume; }

		/**
		 * @private
		 */
		public function set volume(Volume:Number):void
		{
			_volume = Volume;
			if(_volume < 0)
				_volume = 0;
			else if(_volume > 1)
				_volume = 1;
			changeSounds();
		}

		/**
		 * Called by FlxGame on state changes to stop and destroy sounds.
		 *
		 * @param	ForceDestroy		Kill sounds even if they're flagged <code>survive</code>.
		 */
		public function destroySounds(ForceDestroy:Boolean=false):void
		{
			if(sounds == null)
				return;
			if((music != null) && (ForceDestroy || !music.survive))
				music.destroy();
			var s:TCSound;
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
			{
				s = sounds[i] as TCSound;
				if((s != null) && (ForceDestroy || !s.survive))
					s.destroy();
			}
		}

		/**
		 * An internal function that adjust the volume levels and the music channel after a change.
		 */
		protected function changeSounds():void
		{
			if((music != null) && music.active)
				music.updateTransform();
			var s:TCSound;
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
			{
				s = sounds[i] as TCSound;
				if((s != null) && s.active)
					s.updateTransform();
			}
		}

		/**
		 * Called by the game loop to make sure the sounds get updated each frame.
		 */
		internal function updateSounds():void
		{
			if((music != null) && music.active)
				music.update();
			var s:TCSound;
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
			{
				s = sounds[i] as TCSound;
				if((s != null) && s.active)
					s.update();
			}
		}

		/**
		 * Internal helper, pauses all game sounds.
		 */
		protected function pauseSounds():void
		{
			if((music != null) && music.active)
				music.pause();
			var s:TCSound;
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
			{
				s = sounds[i] as TCSound;
				if((s != null) && s.active)
					s.pause();
			}
		}

		/**
		 * Internal helper, pauses all game sounds.
		 */
		protected function playSounds():void
		{
			if((music != null) && music.active)
				music.play();
			var s:TCSound;
			var sl:uint = sounds.length;
			for(var i:uint = 0; i < sl; i++)
			{
				s = sounds[i] as TCSound;
				if((s != null) && s.active)
					s.play();
			}
		}
    }
}
