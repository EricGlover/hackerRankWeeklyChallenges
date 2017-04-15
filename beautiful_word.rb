#beautiful word

#criteria :
  #no two consecutive chars are the same
  #no two consecutive chars are from the vowel set a e i o u y

def is_beautiful? (word)
  vowels = ['a', 'e', 'i','o', 'u', 'y']
  last_char_was_vowel = false
  last_char = nil
  word.split("").each do |char|
    return false if last_char == char
    return false if last_char_was_vowel && vowels.include?(char)
    last_char_was_vowel = vowels.include?(char)
    last_char = char
  end
  return true
end

def main
  input = gets.chomp
  input_beauty = is_beautiful?(input)
  puts input_beauty ? "Yes" : "No"
end

main()
