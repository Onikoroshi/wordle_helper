class DashboardController < ApplicationController
  def index
    @target_date = (params[:target_date].present? && params[:target_date].try(:to_date).present?) ? params[:target_date].to_date : Time.zone.now.to_date
    if @target_date.present?
      @today_guesses = Guess.for_date(@target_date)
    else
      @today_guesses = Guess.for_today
    end

    @guess = Guess.new

    @current_knowledge_info = @today_guesses.current_knowledge_info

    @current_word_list = WordList.new(filter_information: @current_knowledge_info)
    @weighted_word_list = @current_word_list.weighted(@today_guesses.count > 0)
    @display_word_list = @current_word_list.weighted_for_display(@today_guesses.count > 0)
    @ignored_words = @current_word_list.ignored_list
    @current_bridge_word = params[:bridge_word]
  end
end
