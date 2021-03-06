require 'tempfile'

try_require 'sdl'

if defined? SDL
  class Wav

    def play( ch = -1 )
      unless self.wave.empty?
        t = Tempfile.new('beeptoys')
        t.write make_header
        t.write make_wave
        t.close
        t.open
        begin
          snd = SDL::Mixer::Wave.load_from_io( t )
          wait_play( ch )
          SDL::Mixer.play_channel( ch, snd, 0 )

          wait_play( ch ) unless BeepConfig[:live]

        rescue
          SDL.init SDL::INIT_AUDIO
          SDL::Mixer.open( 44100, SDL::Mixer::DEFAULT_FORMAT, 2, 1024 )
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
end
