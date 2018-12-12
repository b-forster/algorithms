# A very hungry rabbit is placed in the center of of a garden, 
# represented by a rectangular N x M 2D matrix.

# The values of the matrix will represent numbers of carrots 
# available to the rabbit in each square of the garden. 
# If the garden does not have an exact center, the rabbit should start in 
# the square closest to the center with the highest carrot count.

# On a given turn, the rabbit will eat the carrots available on the square that it is on, 
# and then move up, down, left, or right, choosing the the square that has the most carrots. 
# If there are no carrots left on any of the adjacent squares, the rabbit will go to sleep. 
# You may assume that the rabbit will never have to choose between two squares with the same 
# number of carrots.

# Write a function which takes a garden matrix and returns the number of carrots the rabbit eats. 
# You may assume the matrix is rectangular with at least 1 row and 1 column, 
# and that it is populated with non-negative integers. For example,

# [[5, 7, 8, 6, 3],
#  [0, 0, 7, 0, 4],
#  [4, 6, 3, 4, 9],
#  [3, 1, 0, 5, 8]]
# Should return

# 27


############# CODE ##################

class RabbitPath
  attr_accessor :garden, :total, :current_coords

  def initialize(garden)
    @garden = garden
    @total = 0

    @current_coords = find_max_coords(find_possible_centers)
  end


  def move_through_garden
    if @current_coords == []
      puts "There's nowhere left to go! The rabbit has eaten #{total} carrots."
      return @total
    end


    current_value = @garden[current_coords[0]][current_coords[1]]

    @total += current_value
    @garden[@current_coords[0]][@current_coords[1]] = 0

    ######

    puts "The rabbit ate #{current_value} carrots at #{@current_coords}. The new total is #{total}."

    puts "Here is the current state of the garden:"

    @garden.each { |row| p row }

    #####

    possible_next_coords = []

    #up
    possible_next_coords << [@current_coords[0] - 1, @current_coords[1]] if @current_coords[0] > 0

    #down
    possible_next_coords << [@current_coords[0] + 1, @current_coords[1]] if @current_coords[0] < garden.length - 1

    #left
    possible_next_coords << [@current_coords[0], @current_coords[1] - 1] if @current_coords[1] > 0

    #right
    possible_next_coords << [@current_coords[0], @current_coords[1] + 1] if @current_coords[1] < garden[0].length - 1


    @current_coords = find_max_coords(possible_next_coords)

    move_through_garden
  end

  def find_possible_centers
    possible_coords = []

    if @garden.length.odd?
      v_centers = [@garden.length / 2]
    else
      v_centers = [(@garden.length / 2), (@garden.length / 2) - 1]
    end

    if @garden[0].length.odd?
      h_centers = [@garden[0].length / 2]
    else
      h_centers = [@garden[0].length / 2, (@garden[0].length / 2) - 1]
    end

    v_centers.each do |v|
      h_centers.each do |h|
        possible_coords << [v, h]
      end
    end
    
    # return v_centers.product(h_centers)

    # [1] X [2,3] = [[1,2],[1,3]]

    possible_coords
  end

  def find_max_coords(possible_coords)
    max = 0
    max_coords = []

    possible_coords.each do |coords|
      value = @garden[coords[0]][coords[1]]

      if value > max
        max = value
        max_coords = coords
      end
    end

    max_coords
  end

end

############# TESTS ###############

even_odd = [
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9, 10, 11, 12]
]

odd_even = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [10, 11, 12]
]

even_even = [
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9, 10, 11, 12],
  [13, 14, 15, 16]
]

odd_odd = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

# rabbit = RabbitPath.new(even_odd)
# rabbit = RabbitPath.new(even_even)
rabbit = RabbitPath.new(odd_odd)
# rabbit = RabbitPath.new(odd_even)

p rabbit.move_through_garden








