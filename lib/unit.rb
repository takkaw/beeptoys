### unit helper ###

class Numeric
  unit = {
  # :unit_method  => :
    :hz           => :freq    ,
    :bit          => :bit     ,
    :channel      => :channel ,
    :ch           => :channel ,
  }

  unit.each { |unit,ret|
    eval %Q( def  #{unit} ; { :#{ret} => self * 1000**0} ; end )
    eval %Q( def k#{unit} ; { :#{ret} => self * 1000**1} ; end )
    eval %Q( def m#{unit} ; { :#{ret} => self * 1000**2} ; end )
  }

  def sec ; { self * 60 ** 0 ,lambda { @sample_rate } } ; end 
  def min ; { self * 60 ** 1 ,lambda { @sample_rate } } ; end 
  def hour; { self * 60 ** 2 ,lambda { @sample_rate } } ; end 

end

