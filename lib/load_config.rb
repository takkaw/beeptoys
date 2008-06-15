require 'yaml'
# default config
BeepConfig = {
  :wave_dir    => 'wave' ,
  :sample_rate => 44100   ,
}
begin
  conf = YAML.load_file('../config.yaml')
rescue
  conf = {}
end
BeepConfig.update conf
