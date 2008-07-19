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
class Numeric
  def hz      ; { :freq => self }       ; end 
  def khz     ; { :freq => self * 1000 }; end 
  def bit     ; { :bit  => self }       ; end 
  def channel ; { :channel => self }    ; end 
  def ch      ; { :channel => self }    ; end

  def sec     ; self * BeepConfig[ :sample_rate ]       ; end
  def min     ; self * BeepConfig[ :sample_rate ] * 60  ; end
end

