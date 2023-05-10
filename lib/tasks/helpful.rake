task refactor_information_arrays: :environment do
  Guess.reorder("created_at ASC").find_each do |current_guess|
    guesses_before = Guess.where("created_at >= ? AND created_at < ?", current_guess.created_at.beginning_of_day, current_guess.created_at).order("created_at ASC")
    pp "#{guesses_before.length} guesses before"

    previous_knowledge = guesses_before.current_knowledge_info
    pp previous_knowledge
    current_guess.final_knowledge_info << []

    colors_array = current_guess.colored_results.split("")
    letter_array = current_guess.guessed_word.split("")
    letter_array.each_with_index do |letter, index|
      if colors_array[index] != "b"
        current_guess.final_knowledge_info.last << letter unless current_guess.final_knowledge_info.include?(letter)
      end
    end

    current_guess.save!
  end
end
