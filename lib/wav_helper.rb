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
  def initialize( freq ) ; @freq = freq     ; end 
  def to_i               ; @freq            ; end
  def self.[]( freq )    ; self.new( freq ) ; end
end

class Bit
  def initialize( bit ) ; @bit = bit      ; end
  def to_i              ; @bit            ; end
  def self.[]( bit )    ; self.new( bit ) ; end
end

class Channel
  def initialize( ch )  ; @ch = ch       ; end
  def to_i              ; @ch            ; end
  def self.[]( ch )     ; self.new( ch ) ; end
end

class Numeric
  def hz      ; Freq[ self ]            ; end 
  def khz     ; Freq[ self * 1000 ]     ; end 
  def bit     ; Bit[ self ]             ; end 
  def channel ; Channel[ self ]         ; end 
  def ch      ; Channel[ self ]         ; end

  def sec     ; self * BeepConf[ :sample_rate ]       ; end
  def min     ; self * BeepConf[ :sample_rate ] * 60  ; end
end

