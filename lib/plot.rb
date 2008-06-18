try_require 'gnuplot'

if defined? Gnuplot 

  def plot(ary)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
    
=begin
      plot.title  'title'
      plot.ylabel 'ylabel'
      plot.xlabel 'xlabel'
=end
      
=begin
        x = (0..50).collect { |v| v.to_f }
        y = x.collect { |v| v ** 2 }
=end
        x = Array.new(ary.length) { |t| ; t }
        y = ary.to_a
   
        plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
          ds.with = "lines"
          ds.notitle
        end
      end
    end
  end
else
  puts 'no gnuplot'
end
