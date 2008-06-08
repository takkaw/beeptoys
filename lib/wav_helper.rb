if RUBY_VERSION.to_f < 1.9
  class String
    def ord(arg=0)
      self[arg]
    end
    
    def unpack8(skip=0)
      self.unpack("x#{skip}c")[0]
    end
    def unpack16(skip=0)
      self.unpack("x#{skip}v")[0]
    end
    def unpack32(skip=0)
      self.unpack("x#{skip}V")[0]
    end
  end
end

class Fixnum
  def pack16
    self.pack("v")
  end
  def pack32
    self.pack("V")
  end
   
  def pack(arg)
    Array(self).pack(arg) 
  end
  
  def sec(s)
    s * SampleRate
  end
  def min(m)
    m * SampleRate * 60
  end
end

class Array
  def pack16
    self.pack("v*")
  end
  def pack32
    self.pack("V*")
  end
end
