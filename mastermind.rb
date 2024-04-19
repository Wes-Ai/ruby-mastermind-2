def numToColor(guess)
end

def colorToNum(guess)
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
def findExact(tempCode, guess)
    pegs = 0
    for a in 0..3 do
        if tempCode[a].eql? guess[a]
            # We have to remove the matching colors from the set;
            tempCode[a] = 5
            guess[a] = 6
            # and add to the peg total.
            pegs += 1
        end
    end
    return pegs
end

# Loop to find similar colors, ie [4, 5, 5, 1] & [2, 6, 6, 4] = 1
def findInexact(tempCode, guess)
    pegs = 0
    for a in 0..3 do
        for b in 0..3 do
            if tempCode[a].eql? guess[b]
                # We have to remove the matching colors from the set,
                tempCode[a] = 5
                guess[b] = 6
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

    # if count.eql? 0
    #     guess = [1122]    # Initial guess
    # else
    #     if exactPegs.eql? 0
    #         if inexactPegs.eql? 0
    #             # remove all combinations containing those digits
    # end

    return guess[0].digits.reverse
end

def removeDigits(allGuessesArr, guess)
    # Loop thru all entries in the guess array
    # splitGuess = guess.to_s.each_char.each_slice(1).map{|x| x.join}
    # for i in 0..allGuessesArr.length() do
    #     splitGuessArr = allGuessesArr[i].to_s.each_char.each_slice(1).map{|x| x.join}


end

def cullPossibleAnswer(allGuessesArr, tempCode, pegsArr)
    exact2 = pegsArr[0]
    inexact2 = pegsArr[1]

    for i in 0..allGuessesArr.length() do
        splitGuess = allGuessesArr[i].to_s.each_char.map(&:to_i)
        exact1 = findExact(tempCode, splitGuess)
        inexact1 = findInexact(tempCode, splitGuess)

        if (exact1.eql? exact2) && (inexact1.eql? inexact2)
            # Code matches, keep
        else
            # Code mismatches, throw away
            allGuessesArr.delete_at(i)
        end
    end
end




turns = 12  # Adjust to lengthen or shorten game
loopCountdown = turns
count = 0
exitedLoop = true
cpuPlaying = false
allGuessesArr = (1111..4444).to_a

puts "Would you like to be the player (0) or creator (1)?"
if gets.chomp.eql? "0"    # CPU random generated code
    secretCode = Array.new(4) { rand(1...5) } # Populate with random values 1-4
else
    puts "Enter your 4 digit code: "
    secretCode = gets.chomp.split(' ').map(&:to_i) # Collect user input as array
    cpuPlaying = true
end


guessBoard = Array.new(turns) { Array.new(4) { 0 } }
pegsArr = Array.new(turns) { Array.new(2) { 0 } }


# Main game loop
while loopCountdown >= 1
    tempCode = secretCode.map(&:clone)    # Copy code array to not modify it

    if cpuPlaying
        # CPU Code
        puts "The computer is guessing..."
        sleep 1
        # Trim down the possible answers from all answers
        if count.eql? 0
            guess = [1, 1, 2, 2]
        else
            cullPossibleAnswer(allGuessesArr, tempCode, pegsArr[count-1])
            # Guess is first number in array after culling
            guess = allGuessesArr[0].to_s.each_char.map(&:to_i)
        end
        p guess # Print CPU guess to screen
    else
        # Human Code
        puts "What would you like to guess?"
        guess = gets.chomp.split(' ').map(&:to_i) # Collect user input as array
    end
    
    guessBoard[count] = guess.map(&:clone)   # Add guess to display
    
    # Parsing the guess against the secret code
    pegsArr[count][0] = findExact(tempCode, guess)
    pegsArr[count][1] = findInexact(tempCode, guess)
    
    exactPegs = pegsArr[count][0]
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
    puts "Sorry, you lost! The code was: #{secretCode}"
end
    