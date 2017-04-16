#hackerRank code week 31
#spanning tree fraction


#I'm assuming you need to complete a minimum spanning tree for this problem
#My attempt at implementing Prim's algorithm for MST

#Algo
  #1: create mist_set[] to hold the vertexes included in the MST so far
  #2: setup the key_value[], pick the 0th element to be first
  #3: while mist_set is incomplete ..
    #A. pick vertex ( w ) not in mist_set that has 'minimum' key value
    #B. put vertex into mist_set
    #C. find adjacent vertexes (we'll use an adjacency matrix for this)
      ## for adjacent vertex p set key[p] = 'minimum' value of all edges p - w

#remember to remove all self-loops

#considerations :
  #maybe use the adjaceny matrix to store the weights (nil == no edge, [ratio, a, b] = maximum a/b edge)

require 'pry'

n,m = gets.strip.split(' ')
n = n.to_i                              #number of vertices
m = m.to_i                              #number of edges
mist_set = []         #store final a b's here???? NO KEEP A RUNNING TOTAL
##key_value = Array.new(n, [0.0, false]) #[ratio, in_mist_set?]
##couldn't I just write the code that checks key_value[i][1] to check for i in mist_set????
#####[ratio, in_mist_set?, vertex_indicating_best_edge]
key_value = Array.new(n) {[0.0, false, -1]} #I'm getting re-used objects in the above line of code
key_value[0][0] = 1001.0       ##figure out a better way to start with 0th index  ##is this necessary??
#adjacent = Array.new(n)
#adjacent.size.times do |i|                #adjacent is now an n x n size 3-d array
  #adjacent[i] = Array.new(n, [0.0, 0, 0])     #(the 3rd dimension being composed of (nil == no edge, [ratio, a, b] = maximum a/b edge))
  #adjacent[i] = Array.new(n, [-1.0, 0, 0]) #a and b are constrained to be positive so store ratio as negative to indicate nil
#  n.times do |i|
#    adjacent[i] = [-1.0, 0, 0]
#  end
#end
adjacent = Array.new(n) { Array.new(n) { [-1.0, 0, 0] } }
#adjacent = Array.new(n, Array.new(n, [0.0, 0, 0]))
total_a = 0
total_b = 0


for a0 in (0..m-1)
    u,v,a,b = gets.strip.split(' ')
    u = u.to_i
    v = v.to_i
    a = a.to_f
    b = b.to_f
    next if u == v    #ignore all self-loops

    #prescreen edges for best ratio (consider using a hash and unique indexing later)
    ratio = a/b
    if ratio > adjacent[u][v][0]
      adjacent[u][v][0] = ratio
      adjacent[u][v][1] = a.to_i
      adjacent[u][v][2] = b.to_i
      #store on both sides
      adjacent[v][u][0] = ratio
      adjacent[v][u][1] = a.to_i
      adjacent[v][u][2] = b.to_i
    else
        #if not the best edge then ignore it
    end
    #adjacent[u][v] += 1
    #adjacent[v][u] += 1

end

binding.pry

#prep work: pump this, set 0th index into mist_set, then update the key_values
mist_set << 0
key_value[0][1] = true

n.times do |i|
  if adjacent[0][i][0] != -1.0
    # for adjacent vertex p set key[p] = MAX value of all edges
    #search adjacent[i][] for max values
    max_edge = -0.9
    n.times do |j|
      if adjacent[i][j][0] != -1.0 && adjacent[i][j][0] > max_edge
        max_edge = adjacent[i][j][0]
        key_value[i][2] = j
      end
    end
    key_value[i][0] = max_edge
    #key_value[i][1] = true ###???????    #I believe this is an error
  end
end

#starts with 0th vertex included in mist_set, totals are 0, key_values for adjacent vertexes are set
while mist_set.size < n
  #pick vertex o that has maximum key value && isn't in mist_set
  binding.pry
  maximum_key = 0.0
  maximum_key_index = 0
  key_value.size.times do |i|
    if key_value[i][0] > maximum_key && key_value[i][1] == false
      maximum_key = key_value[i][0]
      maximum_key_index = i
    elsif key_value[i][0] == maximum_key && key_value[i][1] == false
      #on resolving equivalent ratios,
        #if the ratio is > 1 then use the vertex with the largest value a
        #if the ratio is < 1 then use the vertex with the smallest value b
          ##TODO FIX THE PREFILTERING EARLY WITH THIS UPDATE
      if (maximum_key > 1.0)
        next if adjacent[maximum_key_index][mist_set.size-1][1] > adjacent[i][mist_set.size-1][1]
        maximum_key = key_value[i][0]
        maximum_key_index = i
      elsif maximum_key < 1.0
        next if adjacent[maximum_key_index][mist_set.size-1][2] < adjacent[i][mist_set.size-1][2]
        maximum_key = key_value[i][0]
        maximum_key_index = i
      else
        #hope this never happens
      end
    end
  end

  #B. put vertex into mist_set
  mist_set << maximum_key_index
  ##B.1 add up the totals (the edge we just added is mist_set[end - 1] < - > maximum_key_index)
    #I used the other vertex that connects to the edge the one at mist_set[end - 2]..for some reason
      #this may be an error, this is an error
        #I'm falsely assumed that the the vertex that maximum_key_index connects to is the last vertex we added to MST
  ##key_value[maximum_key_index][2] should = the other vertex of the maximum edge
  total_a += adjacent[maximum_key_index][key_value[maximum_key_index][2]][1]
  total_b += adjacent[maximum_key_index][key_value[maximum_key_index][2]][2]

  #total_a += adjacent[maximum_key_index][mist_set.size - 2][1]
  #total_b += adjacent[maximum_key_index][mist_set.size - 2][2]

  #i don't believe it's necessary to update adjacent here to remove the edges ###?????
  key_value[maximum_key_index][1] = true


  #C. find adjacent vertexes (we'll use an adjacency matrix for this)
  #we've just add maximum_key_index to mist_set, now we need to find that vertex's adjacent vertexes
    #for each adjacent vertex we find the maximum edge for it and set it's key_value to that
  n.times do |i|
    if adjacent[maximum_key_index][i][0] != -1.0 && key_value[i][1] == false
      # for adjacent vertex p set key[p] = MAX value of all edges p - w
      max_edge = -0.9
      n.times do |j|
        if adjacent[i][j][0] != -1.0 && adjacent[i][j][0] > max_edge
          max_edge = adjacent[i][j][0]
          key_value[i][2] = j
        end
      end
      key_value[i][0] = max_edge
    end
  end

end ##end of while loop

binding.pry

if total_a % total_b == 0
  num = total_a / total_b
  total_a /= num
  total_b /= num
end

if total_b == 1
  puts total_a
else
  puts "#{total_a}/#{total_b}"
end
