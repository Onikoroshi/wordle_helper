class WordList
  attr_reader :filter_information

  def initialize(filter_information: nil, weighted_alphabet: nil)
    @filter_information = filter_information
    @letter_weights_array = weighted_alphabet
  end

  def raw_list
    @raw_list ||= get_list(true)
  end

  def to_a
    raw_list
  end

  def get_list(filter_ignored = true)
    results = AllWords.new.to_a

    seen_words = Guess.successful.pluck(:guessed_word)
    results = results - seen_words
    results = results - ignored_list.map(&:word) if filter_ignored

    if filter_information.present?
      results = results.select{|word| self.word_included?(word)}
    end

    results
  end

  def no_repeated_letters
    raw_list.select{ |word| word.split("").length == word.split("").uniq.length }
  end

  def ignored_list
    @ignored_list ||= IgnoredWord.all.to_a
  end

  def letter_weights_array
    if @letter_weights_array.nil?
      @letter_weights_array = Alphabet.weighted(raw_list)
    end

    @letter_weights_array
  end

  def weighted_for_display(allow_repeats = false)
    @weighted_display ||= weighted_base(allow_repeats, false)
  end

  def weighted(allow_repeats = false)
    @weighted_list ||= weighted_base(allow_repeats, true)
  end

  def weighted_base(allow_repeats, filter_ignored)
    word_weights_array = []

    if filter_ignored
      initial_list = allow_repeats ? raw_list : no_repeated_letters
      initial_list = initial_list - IgnoredWord.pluck(:word)
      @letter_weights_array = Alphabet.weighted(initial_list)
    else
      initial_list = get_list(false)
      initial_list = initial_list.select{ |word| word.split("").length == word.split("").uniq.length } unless allow_repeats
    end

    initial_list.each do |word|
      letter_array = word.split("")

      weight = letter_array.inject(0) { |sum, letter| sum += letter_weights_array[letter_weights_array.index{|letter_weight| letter_weight.letter == letter}].weight }

      green_letter_count = Array.new(5, 0)
      letter_array.each_with_index do |letter, index|
        green_letter_count[index] = letter_weights_array[letter_weights_array.index{|letter_weight| letter_weight.letter == letter}].pos_weights[index] - 1
      end

      word_weights_array << WordWeight.new(word, weight, green_letter_count)
    end

    word_weights_array.sort{|a, b| b.total_weight <=> a.total_weight }
  end

  def top_choices_from_all
    answer_letter_weights = Alphabet.weighted(raw_list, green_letters)
    all_words = AllWords.new.to_a.select{ |word| word.split("").length == word.split("").uniq.length }
    best_words = []
    best_weight = 0

    all_words.each do |current_word|
      letter_array = current_word.split("")
      weights = Array.new(5, 0)

      letter_array.each_with_index do |letter, idx|
        found_letter_weight = answer_letter_weights.detect{ |lw| lw.letter == letter }
        total_weight = found_letter_weight.weight
        green_weight = found_letter_weight.pos_weights[idx]
        yellow_weight = total_weight - green_weight

        target_weight = green_weight.to_f + (yellow_weight.to_f / 2.0)

        weights[idx] = target_weight
      end

      weight = weights.sum

      # if weight > best_weight
      #   best_words = []
      #   best_weight = weight
      # end
      #
      # if weight == best_weight
      #   green_letter_count = Array.new(5, 0)
      #
      #   raw_list.each do |other_word|
      #     next if current_word == other_word
      #
      #     other_letters = other_word.split("")
      #     letter_array.each_with_index do |letter, i|
      #       green_letter_count[i] += 1 if letter == other_letters[i]
      #     end
      #   end
      #
      #   best_words << WordWeight.new(current_word, weight, green_letter_count)
      # end

      best_words << WordWeight.new(current_word, weight, weights)
    end

    best_words.sort{|a, b| b.total_weight <=> a.total_weight }.first(5)
  end

  def shared_unguessed_letters
    @shared_unguessed_letters ||= ((raw_list.map{ |word| word.split("") }.flatten.uniq - filter_information.last) + []).sort{ |a, b| letter_touches_answers(b) <=> letter_touches_answers(a) }
  end

  def letter_touches_answers(letter)
    raw_list.select{ |word| word.include?(letter) }.count
  end

  def top_using_shared_unguessed_letters
    top_score = 0
    top_words = []
    range = 0

    AllWords.new.to_a.each do |word|
      bridge_word = BridgeWord.new(word, shared_unguessed_letters, raw_list, filter_information)
      score = 0
      score += bridge_word.unique_letters_covered.count
      score += bridge_word.other_letters_covered.count
      score += bridge_word.words_covered.count
      score -= bridge_word.unused_letters.count
      bridge_word.score = score

      # next unless bridge_word.word.split("").all?{ |l| shared_unguessed_letters.include?(l) }

      # next if bridge_word.word.include?('c')
      # next unless bridge_word.unique_letters_covered.count > 2
      # next unless bridge_word.word.include?('f') && bridge_word.word.include?('g') && bridge_word.word.include?('p')
      # next if bridge_word.word.include?('i') && (!bridge_word.word.include?('f') && !bridge_word.word.include?('d'))
      # next unless bridge_word.word[0] == 'd' || bridge_word.word[3] == 'd'
      # next unless (bridge_word.word.include?('l') || bridge_word.word.include?('g')) && (bridge_word.word.include?('f') || bridge_word.word.include?('h'))
      # next unless bridge_word.word[4] == 'a'
      # next unless bridge_word.word.include?('b') && bridge_word.word.include?('k')
      # next unless bridge_word.word.include?('y')
      # next unless bridge_word.word.include?('e') || bridge_word.word.include?('i')
      # next unless bridge_word.word.include?('w') || bridge_word.word.include?('g')
      # next unless bridge_word.all_letters_covered.count == 4
      # next unless bridge_word.black_letters.empty?
      # next unless bridge_word.word.include?('y') && bridge_word.word.include?('i')

      # if bridge_word.score > 0 && ('o' == bridge_word.word[2] || 'o' == bridge_word.word[3] || 'o' == bridge_word.word[4])
      #   top_words << bridge_word
      # end

      if score < (top_score - range)
        next
      elsif score > top_score
        top_score = score
        top_words = top_words.select{ |brg_wrd| (brg_wrd.score >= (top_score - range)) && (brg_wrd.score <= (top_score + range)) } + [bridge_word]
      elsif (score >= (top_score - range)) && (score <= (top_score + range))
        top_words << bridge_word
      end
    end

    top_words.sort{ |a, b| b.words_covered <=> a.words_covered }.sort{ |a, b| b.score <=> a.score }
  end

  def word_included?(given_word)
    letter_array = given_word.split("")

    if (filter_information.last - letter_array).any?
      return false
    end

    letter_array.each_with_index do |letter, index|
      unless filter_information[index].include?(letter)
        return false
      end
    end

    true
  end

  def green_letters
    result = []

    filter_information.each_with_index do |info_array, index|
      break if 5 == index

      if 1 == info_array.length
        result << info_array.first
      end
    end

    result
  end
end
