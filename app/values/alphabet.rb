class Alphabet
  LETTER_STRING = "abcdefghijklmnopqrstuvwxyz"

  def self.default_knowledge_info
    [
      "abcdefghijklmnopqrstuvwxyz".split(""),
      "abcdefghijklmnopqrstuvwxyz".split(""),
      "abcdefghijklmnopqrstuvwxyz".split(""),
      "abcdefghijklmnopqrstuvwxyz".split(""),
      "abcdefghijklmnopqrstuvwxyz".split(""),
      []
    ]
  end

  def self.weighted(word_list, ignore_letters = [])
    letter_array = self.to_a
    weights_array = Array.new(letter_array.length)
    (0...letter_array.length).each do |index|
      weights_array[index] = Array.new(6, 0)
    end

    word_list.each do |word|
      word.split("").each_with_index do |letter, index|
        unless ignore_letters.include?(letter)
          target_ary = weights_array[letter_array.index(letter)]
          target_ary[index] += 1
          target_ary[5] += 1
        end
      end
    end

    result = []

    letter_array.each_with_index do |letter, index|
      result << LetterWeight.new(letter, weights_array[index][5], weights_array[index][0..4])
    end

    result
  end

  def self.sorted(weighted_alphabet)
    weighted_alphabet.sort{|a, b| b.weight <=> a.weight }
  end

  def self.to_a
    str_to_a(LETTER_STRING)
  end

  def self.downcase
    str_to_a(LETTER_STRING.downcase)
  end

  def self.upcase
    str_to_a(LETTER_STRING.upcase)
  end

  def self.str_to_a(given_str)
    given_str.split("")
  end
end
