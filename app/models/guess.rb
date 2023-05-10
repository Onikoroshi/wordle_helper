class Guess < ApplicationRecord
  before_save :calculate_final_knowledge_info

  scope :for_date, ->(given_date) { where("created_at >= ? AND created_at <= ?", given_date.beginning_of_day, given_date.end_of_day).order("created_at ASC") }
  scope :for_today, -> { where("created_at >= ? AND created_at <= ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).order("created_at ASC") }

  scope :successful, -> { where(colored_results: "ggggg") }

  def self.current_knowledge_info
    self.last.try(:final_knowledge_info) || Alphabet.default_knowledge_info
  end

  def self.add_word_to_empty_day(word, date_string)
    given_date = date_string.to_date
    raise "#{date_string} is not a valid date" unless given_date.present?

    existing = self.for_date(given_date).successful.first
    raise "already have '#{existing.guessed_word}' for #{given_date}" if existing.present?

    Guess.create!(guessed_word: word, colored_results: "ggggg", created_at: Time.zone.parse("#{date_string} 09:00:00"))
  end

  def calculate_final_knowledge_info
    result = Guess.for_today.where.not(id: self.id).current_knowledge_info

    guessed_letters = guessed_word.split("")
    colored_results_array = colored_results.split("")

    guessed_letters.each_with_index do |letter, index|
      case colored_results_array[index]
      when "y" # for yellow
        result[index].delete(letter)
        result.last << letter unless result.last.include?(letter)
      when "g" # for green
        result[index] = [letter]
        result.last << letter unless result.last.include?(letter)
      else # for black
        skip = false

        guessed_letters.each_with_index do |lett, i|
          color = colored_results_array[i]
          if (lett == letter) && (color != "b")
            skip = true
          end
        end

        unless skip
          result.first(5).each do |alphabet_array|
            alphabet_array.delete(letter) unless alphabet_array.length == 1
          end
        else
          result[index].delete(letter)
        end
      end
    end

    self.final_knowledge_info = result
  end
end
