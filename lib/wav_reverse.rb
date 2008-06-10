class Wav
  def reverse!
    @wave = rev
  end

  def reverse
    Wav.new rev
  end

  :pravate
  def rev
    if monoral?
      @wave.reverse
    elsif stereo?
      [@wave[0].reverse,@wave[1].reverse]
    end
  end
end

