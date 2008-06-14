# wavfile.rb by takkaw.

class Wav
  attr_reader :wave,
              :channels,
              :sample_rate,
              :sample_bit

  def initialize( *args )
    # default value
    @channels    = 1
    @sample_rate = 44100
    @sample_bit  = 16
    wave = nil

    # config by args
    args.each { |arg|
      case arg
      when Channel ; @channels    = arg.to_i 
      when Freq    ; @sample_rate = arg.to_i
      when Bit     ; @sample_bit  = arg.to_i
      else wave = arg
      end
    }

    unless wave
      if monoral?
        @wave = empty
      elsif stereo?
        @wave = empty,empty
      end
    else
      if monoral?
        @wave = wave.to_na
      elsif stereo?
        @wave = wave[0].to_na,wave[1].to_na
      end
    end

  end
  
  def save(filename)
    filename = filename.to_s
    filename += ".wav" unless File.extname(filename) == ".wav"
    filename = 'wave/' + filename 
    
    File.open( filename, "w" ){ |f|
      f.write( make_wav_header )
    }
  end
  
  def self.load(filename)
    filename = filename.to_s
    filename += ".wav" unless File.extname(filename) == ".wav"
    filename = 'wave/' + filename 

    ch,rate,bit,wave=\
    File.open(filename,"rb") { |file|
      load_riff(file)
      load_wave(file)
    }
    self.new( wave , ch.ch , rate.hz , bit.bit )
  end

  def monoral? ; @channels   == 1  ; end
  def stereo?  ; @channels   == 2  ; end
  def _8bit?   ; @sample_bit == 8  ; end
  def _16bit?  ; @sample_bit == 16 ; end

  def [](t)
    if monoral?
      @wave[t]
    elsif stereo?
      [@wave[0][t],@wave[1][t]]
    end
  end

  def size
    if monoral?
      @wave.size
    elsif stereo?
      @wave[0].size
    end
  end
  alias :length :size

  private

  def empty
    [].to_na
  end

  
  def make_wav_header
    'RIFF' +                                            # RIFF header
    (36 + self.length*@sample_bit/8*@channels).pack32 + # (36 = 44-8)
    'WAVE' +                                            # WAVE header
    'fmt ' +                                            # fmt  chunk
    16.pack32 +                                         # chunk size
    1.pack16  +                                         # format ID
    @channels.pack16 +                                  # channel
    @sample_rate.pack32 +                               # sample rate
    (@sample_rate * @sample_bit/8 * @channels).pack32 +	# byte/sec
    (@sample_bit/8 * @channels).pack16 +	            # block size
    @sample_bit.pack16 +                                # bit/sample
    'data' +                                            # data header
    (self.length*@sample_bit/8*@channels).pack32 +      # chunk size
    wave_pack
  end
  
  def wave_pack
    if _16bit?
      if stereo?
        (@wave[0].to_a.zip(@wave[1].to_a).flatten).pack16
      elsif monoral?
        @wave.to_a.pack16
      end
    elsif _8bit?
      if stereo?
        (@wave[0].to_a.zip(@wave[1].to_a).flatten).pack8
      elsif monoral?
        @wave.to_a.pack8
      end
    end
  end

  def self.load_chunk(file)
    type = file.read(4)
    size = file.read(4).unpack("V")[0]
    data = file.read(size)
    return {:type => type , :size => size, :data => data }
  end

  def self.load_riff(file)
    riff = file.read(4)
    data_size = file.read(4).unpack("V")[0]
    wave = file.read(4)
    raise NotWavFormatError unless riff == "RIFF" and wave[0..3] == "WAVE"
  end

  def self.load_wave(file)
    until file.eof?
      chunk = load_chunk(file)
      if chunk[:type] == 'fmt '
        comp_type      = chunk[:data].unpack16(0)
        channels       = chunk[:data].unpack16(2)
        sample_rate    = chunk[:data].unpack32(4)
        sample_persec  = chunk[:data].unpack32(8)
        sample_bit     = chunk[:data].unpack16(14)
        size           = chunk.size
      elsif chunk[:type] == 'data'
        data = chunk[:data]
      end
    end

    wave = []
    if sample_bit == 8
      data.size.times { |t|
        wave << data.unpack8(t)
      }
    elsif sample_bit == 16
      (data.size/2).times { |t|
        wave << data.unpack16(t*2)
      }
    end
    
    if channels == 2
      l = [] ; r = []
      wave.each_index { |index|
        ( index%2 == 0 ? l : r ) << wave[index]
      }
      wave = l,r
    end

    return channels,sample_rate,sample_bit,wave
  end
  
  
end  

