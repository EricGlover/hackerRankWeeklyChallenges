#encryption algo challenge
#Eric Glover
#TM T-Swift

require 'pry'
#status : problems with input 'chillout' rows = 2, columns = 3, problems making the string grid obviously size == 6 length == 8

#not perfect but it works
def perfect_square?( z )
  return false if z == 0 #?? idk man but screw 0
  num = Math.sqrt(z)
  return true if num.truncate == num
  return false
end

#take input
string = gets.strip
#remove spaces
string = string.delete(" ")     #rewrite this later
#find L
length = string.length
#check if L is perfect sqaure
is_perfect_square = perfect_square?( length )

#set rows and columns
rows = Math.sqrt(length).truncate
columns = rows + 1
columns = rows if is_perfect_square
if rows * columns < length
  rows += 1
end

#binding.pry

#make string grid             #working
clone = string.dup.split("")
grid = Array.new(rows)
grid.size.times do |i|
  grid[i] = Array.new(columns)
  grid[i].size.times do |j|
    grid[i][j] = clone.shift
  end
end
binding.pry

#print the columns
columns.times do |i|
  rows.times do |j|
    print grid[j][i]
  end
  #puts ""
  print ' '
end


binding.pry
#grid.each do |row|              #consider rewriting this to .times
#  binding.pry
#  row = Array.new(columns)
#  row.each do |char|
#    char = clone.shift
#  end
#end
