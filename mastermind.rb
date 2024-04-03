def resetGame()
end

def numToColor(arr)
end

def printBoard()
end

code = Array.new(4) { rand(1...5) } # Populate with random values 1-4

p code

turns = 12

# Main game loop
while turns >= 1
    exactPegs = 0
    inexactPegs = 0
    tempCode = code.map(&:clone)

    puts "What would you like to guess?"
    arr = gets.chomp.split(' ').map(&:to_i) # Collect user input as array

    # Loop to find exact positions, ie [1, 2, 2, 1] & [2, 2, 2, 4] = 2
    # Must loop this first to remove exact matches from the set.
    for a in 0..3 do
        if tempCode[a].eql? arr[a]
            # We have to remove the matching colors from the set,
            tempCode[a] = 5
            arr[a] = 6
            # and add to the peg total.
            exactPegs += 1
        end
    end


    # Loop to find similar colors, ie [4, 5, 5, 1] & [2, 6, 6, 4] = 1
    for a in 0..3 do
        for b in 0..3 do
            if tempCode[a].eql? arr[b]
                # We have to remove the matching colors from the set,
                tempCode[a] = 5
                arr[b] = 6
                # and add to the peg total.
                inexactPegs += 1
            end
        end
    end

    turns = turns - 1
end

p 'hi'