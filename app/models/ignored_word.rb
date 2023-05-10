class IgnoredWord < ApplicationRecord
  def self.populate_simple_plurals
    existing = self.pluck(:word).map(&:downcase)

    plurals = AllWords.new.to_a.map(&:downcase).select{ |w| BridgeWord.simple_plural?(w) }

    unignored_plurals = plurals - existing

    unignored_plurals.each do |plural|
      IgnoredWord.create!(word: plural)
    end
  end
end
