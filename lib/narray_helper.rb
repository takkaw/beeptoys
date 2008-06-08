require 'rubygems'
require 'narray'

class Array
  def to_na
    NArray.to_na(self)
  end
  def flatten_
    self.flatten
  end
end

class NArray
  def to_na
    self
  end
  def reverse
    self.to_a.reverse.to_na
  end
  def reverse!
    self.to_a.replace(self.reverse).to_na
  end
  def flatten_
    self.empty? ? self : self.flatten
  end
  def compact
    self.to_a.compact
  end
  def compact!
    self.to_a.replace(self.compact).to_na
  end

end

def empty
  [].to_na
end
