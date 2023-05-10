class CreateGuesses < ActiveRecord::Migration[6.1]
  def change
    create_table :guesses do |t|
      t.jsonb :final_knowledge_info
      t.string :guessed_word
      t.string :colored_results

      t.timestamps
    end
  end
end
