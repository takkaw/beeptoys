require 'yaml'
# default config
BeepConfig = {
  :wave_dir    => 'wave' ,
  :sample_rate => 44100   ,
}
begin
  conf = YAML.load_file('config.yaml')
rescue
  conf = {}
end
BeepConfig.update conf

# load library
require 'lib/version.rb'
require 'lib/wav.rb'            # require narray
require 'lib/wav_helper.rb'     # require narray
require 'lib/narray_helper.rb'  # require narray
require 'lib/wav_reverse.rb'    # require narray
require 'lib/wav_play.rb'       # require rubysdl
require 'lib/plot.rb'           # require gnuplot


# Slot module for auto collection in irb.
module Collection
  wave_dir = BeepConfig[:wave_dir] + '/'
  s = Dir[wave_dir + '*.wav'].collect { |w|
    w.gsub(File.extname(w),'').gsub(wave_dir,'')
  }
  s.each { |collect|
    module_eval %-
      def #{collect}
        :#{collect}
      end
    -
  }
end

