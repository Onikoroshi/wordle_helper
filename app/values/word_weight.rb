class WordWeight
  attr_reader :word, :weight, :position_weights

  def initialize(given_word, given_weight, given_pos_weights)
    @word = given_word
    @weight = given_weight
    @position_weights = given_pos_weights
  end

  def to_s
    "#{word} - #{weight}"
  end

  def without_repeats?
    word.length == word.split("").uniq.length
  end

  def ignored_word?
    IgnoredWord.where(word: word).exists?
  end

  def total_pos_weight
    position_weights.sum
  end

  def total_weight
    weight + total_pos_weight
  end
end
