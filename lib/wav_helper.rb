### pack helper ###
class String
  def unpack8(skip=0)  ; self.unpack("x#{skip}c").first ; end
  def unpack16(skip=0) ; self.unpack("x#{skip}v").first ; end
  def unpack32(skip=0) ; self.unpack("x#{skip}V").first ; end
end

class Fixnum
  def pack8  ; self.pack("c") ; end
  def pack16 ; self.pack("v") ; end
  def pack32 ; self.pack("V") ; end
   
  def pack(arg) ; Array(self).pack(arg) ; end
end

class Array
  def pack8  ; self.pack("c*") ; end
  def pack16 ; self.pack("v*") ; end
  def pack32 ; self.pack("V*") ; end
end

### unit helper ###
class Freq
  def initialize( freq ) ; @freq = freq ; end 
  def to_i               ; @freq        ; end
end

class Bit
  def initialize( bit ) ; @bit = bit    ; end
  def to_i              ; @bit          ; end
end

class Channel
  def initialize( ch )  ; @ch = ch      ; end
  def to_i              ; @ch           ; end
end

class Numeric
  def hz      ; Freq.new( self )        ; end 
  def khz     ; Freq.new( self * 1000 ) ; end 
  def bit     ; Bit.new( self )         ; end 
  def channel ; Channel.new( self )     ; end 
  def ch      ; Channel.new( self )     ; end
  def sec(s)  ; s * SampleRate          ; end
  def min(m)  ; m * SampleRate * 60     ; end
end

