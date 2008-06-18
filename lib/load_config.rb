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

def try_require( lib )
  if BeepConfig[ lib.to_sym ]
    begin
      require lib
    rescue LoadError
    end
  end
end

try_require 'rubygems'


