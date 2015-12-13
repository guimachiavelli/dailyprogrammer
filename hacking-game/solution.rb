def main
    puts "Difficulty (1-5)?"
    number = difficulty_level(gets.chomp)
    wordlist = words(number);
    print_wordlist(wordlist)
    guess(wordlist, wordlist.sample(1)[0], 4)
end

def difficulty_level(number)
    number = number.to_i
    if number < 1 || number > 5
        throw "Invalid difficulty level"
    end
    number
end

def words(level)
    length = challenge_length(level)
    possible_words = File.readlines('words.txt').map {|w| w.gsub(/\s+/, '') }
    possible_words = possible_words.select do |word|
        word.nil? != true && word.size == length
    end

    return possible_words.sample(challenge_amount(level))
end

def challenge_length(level)
    level = (level * 2) + level
    max(level, 4)
end

def challenge_amount(level)
    level = (level * 2) + level + 1
    min(level, 15)
end

def max(a, b)
    a > b ? a : b
end

def min(a, b)
    a < b ? a : b
end

def print_wordlist(wordlist)
    wordlist.each do |word|
        puts word.upcase
    end
end

def guess(wordlist, answer, attempts)
    if (attempts <= 0)
        puts "You lose!"
        return
    end

    puts "Guess the correct word (#{attempts} left):"
    guess = gets.chomp

    if (guess == answer)
        puts "You win!"
        return
    end

    if (!wordlist.include? guess)
        puts "invalid guess. try again"
        guess(wordlist, answer, attempts)
        return
    end

    puts "wrong!"
    puts "#{correct_letters(guess, answer)}/#{answer.size}"

    guess(wordlist, answer, attempts - 1)

end

def correct_letters(guess, answer)
    count = 0
    guess.each_char do |char|
        count += 1 if answer.include? char
    end
    count
end

main
