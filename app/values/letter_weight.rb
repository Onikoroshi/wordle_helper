class LetterWeight
  attr_reader :letter, :weight, :pos_weights

  def initialize(given_letter, given_weight, given_pos_weights = [])
    @letter = given_letter
    @weight = given_weight
    @pos_weights = given_pos_weights
  end

  def to_s
    "#{letter.upcase} - #{weight}"
  end
end
