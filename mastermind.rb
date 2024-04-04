def numToColor(arr)
end

def colorToNum(arr)
end

def printBoard(turns, guessBoard, pegsArr)
    puts
    puts "   +------------------------+   "
    for i in 0..turns-1 do
        print "   |   "
        print guessBoard[i]
        print pegsArr[i]
        print "   |\n"
    end
    puts "   +------------------------+   "
    puts
end

turns = 12
code = Array.new(4) { rand(1...5) } # Populate with random values 1-4
guessBoard = Array.new(12) { Array.new(4) { 0 } }
pegsArr = Array.new(12) { Array.new(2) { 0 } }

# p code

count = 0

loopCountdown = turns

# Main game loop
while loopCountdown >= 1
    exactPegs = 0
    inexactPegs = 0
    tempCode = code.map(&:clone)    # Copy code array to not modify it
    
    puts "What would you like to guess?"
    arr = gets.chomp.split(' ').map(&:to_i) # Collect user input as array
    guessBoard[count] = arr.map(&:clone)
    
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

    pegsArr[count][0] = exactPegs
    pegsArr[count][1] = inexactPegs

    count += 1
    
    if exactPegs.eql? 4
        p 'Congratulations, you won!'
        loopCountdown = 0
    else
        printBoard(turns, guessBoard, pegsArr)
        loopCountdown = loopCountdown - 1
    end
end
