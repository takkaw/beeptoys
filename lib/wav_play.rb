require 'tempfile'
require 'rubygems'
require 'sdl'

class Wav
  #include Wav_init

  def test_play
    open("wave/dancemusic8_kick.wav"){|f|
      kick = SDL::Mixer::Wave.load_from_io f
      SDL::Mixer.play_channel(0,kick,0 ) until SDL::Mixer::play?(0)
    }
  end

  def play
        
    unless self.wave.empty?
      t = Tempfile.new('beeptoys')
      t.write make_wav
      t.close
      t.open
      begin
        snd = SDL::Mixer::Wave.load_from_io( t )
        SDL::Mixer.play_channel(-1,snd,0 ) #until SDL::Mixer::play?(0)
      rescue
        SDL.init SDL::INIT_AUDIO
        SDL::Mixer.open(44100, SDL::Mixer::DEFAULT_FORMAT, 2, 1024)
        retry
      end

      t.close(true)
    end
  end

end

