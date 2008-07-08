# Collection module for auto collection in irb.
module Collection
  wave_dir = BeepConfig[:wave_dir] + '/'
  Dir[wave_dir + '*.wav'].collect { |w|
    w.gsub!(File.extname(w),'').gsub!(wave_dir,'')
    w = '_' + w if /[0-9]/ =~ w[0..0]
    w.to_sym
  }
end

