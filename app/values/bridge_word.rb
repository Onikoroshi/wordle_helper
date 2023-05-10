class BridgeWord
  attr_reader :word, :unique_letters_covered, :other_letters_covered, :unused_letters, :words_covered, :black_letters
  attr_accessor :score

  def self.singular?(word)
    word.singularize == word
  end

  def self.plural?(word)
    !singular?(word)
  end

  def self.simple_plural?(word)
    plural?(word) && word.ends_with?("s")
  end

  def self.complex_plural?(word)
    plural?(word) && !simple_plural?(word)
  end

  def initialize(word, target_letters, possible_answer_words, filter_info)
    @word = word

    @unique_letters_covered = []
    @other_letters_covered = []
    @unused_letters = letters_unused(word, possible_answer_words)
    @words_covered = []
    @black_letters = []

    return if word.split("").uniq.count != word.length

    full_alphabet = Alphabet::LETTER_STRING.split("")
    @black_letters = full_alphabet

    # ap "filter info"
    # ap filter_info
    filter_info[0..4].each do |arr|
      # ap "arr"
      # ap arr
      missing_letters = full_alphabet - arr
      # ap "missing"
      # ap missing_letters
      @black_letters = @black_letters & missing_letters
      # ap "black"
      # ap @black_letters
    end

    @black_letters = @black_letters & word.split("")

    letters_covered = common_letters(word, target_letters)

    @words_covered = []
    possible_answer_words.each do |answer_word|
      if (letters_covered & common_letters(answer_word, target_letters)).any?
        @words_covered << answer_word
      end
    end

    # @unique_letters_covered = @words_covered.count

    touch_scores = letters_covered.map{ |letter| [letter, letter_touches_answers(letter, possible_answer_words)] }.sort{ |a, b| b[1] <=> a[1] }
    # print touch_scores

    amount_to_add = 0
    last_amount = touch_scores.first
    touch_scores.each do |touch_score|
      # if touch_score != last_amount
      #   amount_to_add += 1
      # end
      #
      # @unique_letters_covered += amount_to_add
      if touch_score[1] == 1
        @unique_letters_covered << touch_score[0]
      elsif touch_score[1] > 0
        @other_letters_covered << touch_score[0]
      end
    end
  end

  def all_letters_covered
    @unique_letters_covered + @other_letters_covered
  end

  def letter_touches_answers(letter, answers)
    answers.select{ |word| word.include?(letter) }.count
  end

  def common_letters(word_a, list_b)
    word_a.split("").uniq & list_b
  end

  def letters_unused(word, wordlist)
    word.split("").uniq - wordlist.map{|w| w.split("")}.flatten.compact.uniq
  end
end
