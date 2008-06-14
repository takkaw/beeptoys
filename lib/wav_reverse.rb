class Wav
  def reverse!
    if monoral?
      @wave = @wave.reverse
    elsif stereo?
      @wave = @wave[0].reverse!,@wave[1].reverse!
    end
  end

  def reverse
    if monoral?
      wave = @wave.reverse
    elsif stereo?
      wave = [@wave[0].reverse,@wave[1].reverse]
    end
    Wav.new Channel[@channels],Freq[@sample_rate],Bit[@sample_bit],wave
  end

end

