require 'tempfile'
require 'rubygems'
require 'sdl'

class Wav

  def play( ch = -1 )
    unless self.wave.empty?
      t = Tempfile.new('beeptoys')
      t.write make_wav_header
      t.close
      t.open
      begin
        snd = SDL::Mixer::Wave.load_from_io( t )
        wait_play( ch )
        SDL::Mixer.play_channel( ch, snd, 0 )

        wait_play( ch ) if $TEST

      rescue
        SDL.init SDL::INIT_AUDIO
        SDL::Mixer.open( 44100, SDL::Mixer::DEFAULT_FORMAT, 2, 1024)
        retry
      end

      t.close(true)
    end
  end

  private

  def wait_play( ch )
    while true
      break unless SDL::Mixer::play?( ch )
    end
  end

end

def play(obj)
  obj.play
end
