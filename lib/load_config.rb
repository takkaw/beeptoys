require 'yaml'

# default config
BeepConfig = {
  :wave_dir    => 'wave' ,
  :sample_rate => 44100   ,
}
begin
  conf_file_path = File.dirname(__FILE__) + '/../' 
  conf = YAML.load_file( conf_file_path + 'config.yaml' )
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


