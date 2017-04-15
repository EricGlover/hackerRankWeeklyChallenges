#hackerRank accurate sorting challenge
#description later
require 'pry'

q = gets.strip.to_i
for a0 in (0..q-1)
    n = gets.strip.to_i
    a = gets.strip
    a = a.split(' ').map(&:to_i)
    no_can_do = false
    #modified bubble sort
    i = 0
    while i < a.size - 1 && !no_can_do
      (i..a.size - 1).each do |j|
        if a[j] > a[j+1]
          #swap
          difference = (a[j] - a[j+1]).abs
          if difference > 1
            puts "No"
            no_can_do = true
            break
          end
          temp = a[j]
          a[j] = a[j+1]
          a[j+1] = temp
          redo
        else
          break
        end
      end
      i += 1
    end
    if !no_can_do
      puts "Yes"
    end
  end
end

def insertion_sort(n)
  a = n.dup
  #take a sorted array, on the left a[0...n] and add a[i] into the correct position in the sorted array
  #consider a[0] sorted , so start with a[1]
  (1..(a.size-1)).each do |i|

    #place a[i] into sorted array a[0...i-1]
    j = i - 1
    while j >= 0
      #swap, use j+1 to keep track of a[i] as you move it around
      if a[j+1] < a[j]
        temp = a[j]
        a[j] = a[j+1]
        a[j+1] = temp
      else
        #we're sorted now
        break
      end
      j -= 1
    end
  end
end



def sort(n)
  a = n.dup
  #modified bubble sort
  (a.size - 1).times do |i|
    (i..a.size - 1).each do |j|
      if a[j] > a[j+1]
        #swap
        difference = (a[j] - a[j+1]).abs
        puts "No" if difference > 1
        temp = a[j]
        a[j] = a[j+1]
        a[j+1] = temp
        redo
      else
        break
      end
    end
  end
  puts a
  puts "Yes"

end

def sort2 (n)
  a = n.dup
  no_can_do = false
  #modified bubble sort
  i = 0
  while i < a.size - 1 && !no_can_do
    (i..a.size - 1).each do |j|
      if a[j] > a[j+1]
        #swap
        difference = (a[j] - a[j+1]).abs
        #puts "No" if difference > 1
        if difference > 1
          puts "No"
          no_can_do = true
          break
        end
        temp = a[j]
        a[j] = a[j+1]
        a[j+1] = temp
        redo
      else
        break
      end
    end
    i += 1
  end
  if !no_can_do
    puts "Yes"
  end
end



###########
q = gets.strip.to_i
for a0 in (0..q-1)
    n = gets.strip.to_i
    a = gets.strip
    a = a.split(' ').map(&:to_i)
    no_can_sort = false
  #take a sorted array, on the left a[0...n] and add a[i] into the correct position in the sorted array
  #consider a[0] sorted , so start with a[1]
  (1..(a.size-1)).each do |i|
    no_can_sort = false
    #place a[i] into sorted array a[0...i-1]
    j = i - 1
    while j >= 0
      #  use j+1 to keep track of a[i] as you move it around
      if a[j+1] < a[j]
        #check the difference
        difference = (a[j+1] - a[j]).abs
        if difference > 1
          no_can_sort = true
          puts "No"
          break
        end
        #swap places
        temp = a[j]
        a[j] = a[j+1]
        a[j+1] = temp
      else
        #we're sorted now
        break
      end
      j -= 1
    end
    break if no_can_sort
  end
  puts "Yes" unless no_can_sort
end
