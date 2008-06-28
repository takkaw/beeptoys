# Collection module for auto collection in irb.
module Collection
  wave_dir = BeepConfig[:wave_dir] + '/'
  s = Dir[wave_dir + '*.wav'].collect { |w|
    w.gsub(File.extname(w),'').gsub(wave_dir,'')
  }
  s.each { |collect|
    collect = '_' + collect if /[0-9]/ =~ collect[0..0]
    module_eval %-
      def #{collect}
        :#{collect}
      end
    -
  }
end

