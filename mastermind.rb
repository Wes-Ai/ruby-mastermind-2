def numToColor(inputArr)
end

def colorToNum(inputArr)
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

# Loop to find exact positions, ie [1, 2, 2, 1] & [2, 2, 2, 4] = 2
# Must loop this first to remove exact matches from the set.
def findExact(tempCode, inputArr)
    pegs = 0
    for a in 0..3 do
        if tempCode[a].eql? inputArr[a]
            # We have to remove the matching colors from the set;
            tempCode[a] = 5
            inputArr[a] = 6
            # and add to the peg total.
            pegs += 1
        end
    end
    return pegs
end

# Loop to find similar colors, ie [4, 5, 5, 1] & [2, 6, 6, 4] = 1
def findInexact(tempCode, inputArr)
    pegs = 0
    for a in 0..3 do
        for b in 0..3 do
            if tempCode[a].eql? inputArr[b]
                # We have to remove the matching colors from the set,
                tempCode[a] = 5
                inputArr[b] = 6
                # and add to the peg total.
                pegs += 1
            end
        end
    end
    return pegs
end

# https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind
def cpuGuess(count, pegsArr, allGuessesArr)
    exactPegs = pegsArr[count-1][0]
    inexactPegs = pegsArr[count-1][1]

    if count.eql? 0
        guess = [1122]    # Initial guess
    elsif count.eql? 1
        if exactPegs.eql? 0
            if inexactPegs.eql? 0
                # remove all combinations containing those digits
    end

    return guess[0].digits.reverse


    # if count.eql? 0
    #     # guess = Array.new(4) { rand(1...5) } # 1st guess is random
    #     return guess
    # elsif count.eql? 1
    #     if exactPegs > 0
    #         # There are some 1's
    #         for i in exactPegs..3 do
    #             guess[i] = 2
    #         end
    #     else
    #         # There are no 1's
    #     end
    # elsif count.eql? 2
    #     if exactPegs > 0
    #         # There are some 2's
    #         for i in exactPegs..3 do
    #             guess[i] = 3
    #         end
    #     else
    #         # There are no 1's
    #     end
    # end
    #
    #return guess
end

def removeDigits(allGuessesArr, guess)
    # Loop thru all entries in the guess array
    splitGuess = guess.to_s.each_char.each_slice(1).map{|x| x.join}
    for i in 0..allGuessesArr.length() do
        splitGuessArr = allGuessesArr[i].to_s.each_char.each_slice(1).map{|x| x.join}


end



turns = 12  # Adjust to lengthen or shorten game
loopCountdown = turns
count = 0
exitedLoop = true
cpuPlaying = false
allGuessesArr = (1111..4444).to_a

puts "Would you like to be the player (0) or creator (1)?"
if gets.chomp.eql? "0"    # CPU random generated code
    code = Array.new(4) { rand(1...5) } # Populate with random values 1-4
else
    puts "Enter your 4 digit code: "
    code = gets.chomp.split(' ').map(&:to_i) # Collect user input as array
    cpuPlaying = true
end


guessBoard = Array.new(turns) { Array.new(4) { 0 } }
pegsArr = Array.new(turns) { Array.new(2) { 0 } }


# Main game loop
while loopCountdown >= 1
    tempCode = code.map(&:clone)    # Copy code array to not modify it

    if cpuPlaying
        # CPU Code
        puts "The computer is guessing..."
        sleep 1
        inputArr = cpuGuess(count, pegsArr, allGuessesArr)
        p inputArr
    else
        # Human Code
        puts "What would you like to guess?"
        inputArr = gets.chomp.split(' ').map(&:to_i) # Collect user input as array
    end
    
    guessBoard[count] = inputArr.map(&:clone)
    
    exactPegs = findExact(tempCode, inputArr)
    inexactPegs = findInexact(tempCode, inputArr)

    pegsArr[count][0] = exactPegs
    pegsArr[count][1] = inexactPegs

    count += 1
    
    if exactPegs.eql? 4
        p 'Congratulations, you won!'
        loopCountdown = 0
        exitedLoop = false
    else
        printBoard(turns, guessBoard, pegsArr)
        loopCountdown = loopCountdown - 1
    end
end

if exitedLoop
    puts "Sorry, you lost! The code was: #{code}"
end
    