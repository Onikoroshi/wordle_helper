class IgnoredWordsController < ApplicationController
  before_action :set_ignored_word, only: %i[ show edit update destroy ]

  # GET /ignored_words or /ignored_words.json
  def index
    @ignored_words = IgnoredWord.all
  end

  # GET /ignored_words/1 or /ignored_words/1.json
  def show
  end

  # GET /ignored_words/new
  def new
    @ignored_word = IgnoredWord.new
  end

  # GET /ignored_words/1/edit
  def edit
  end

  # POST /ignored_words or /ignored_words.json
  def create
    @ignored_word = IgnoredWord.new(ignored_word_params)

    if @ignored_word.save
      # format.html { redirect_to ignored_word_url(@ignored_word), notice: "Ignored word was successfully created." }
      # format.json { render :show, status: :created, location: @ignored_word }
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ignored_words/1 or /ignored_words/1.json
  def update
    respond_to do |format|
      if @ignored_word.update(ignored_word_params)
        format.html { redirect_to ignored_word_url(@ignored_word), notice: "Ignored word was successfully updated." }
        format.json { render :show, status: :ok, location: @ignored_word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ignored_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ignored_words/1 or /ignored_words/1.json
  def destroy
    @ignored_word.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ignored_word
      @ignored_word = IgnoredWord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ignored_word_params
      # params.fetch(:ignored_word, {})
      params.require(:ignored_word).permit(:word)
    end
end
