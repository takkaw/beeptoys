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
        while true
          break unless SDL::Mixer::play?( ch )
        end
        SDL::Mixer.play_channel( ch, snd, 0 )
      rescue
        SDL.init SDL::INIT_AUDIO
        SDL::Mixer.open( 44100, SDL::Mixer::DEFAULT_FORMAT, 2, 1024)
        retry
      end

      t.close(true)
    end
  end

end

