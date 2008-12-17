### unit helper ###

class Numeric
  unit = {
  # :unit_method  => :
    :hz           => :freq    ,
    :bit          => :bit     ,
    :channel      => :channel ,
    :ch           => :channel ,
  }

  unit.each { |unit,sym|
    eval %Q( def  #{unit} ; { :#{sym} => self * 1000**0} ; end )
    eval %Q( def k#{unit} ; { :#{sym} => self * 1000**1} ; end )
    eval %Q( def m#{unit} ; { :#{sym} => self * 1000**2} ; end )
  }

  def sec ; { :sec => self * 60 ** 0 } ; end 
  def min ; { :sec => self * 60 ** 1 } ; end 
  def hour; { :sec => self * 60 ** 2 } ; end 

end

