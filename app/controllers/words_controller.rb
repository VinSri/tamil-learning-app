class WordsController < ApplicationController
  def index
    @category     = params[:category].presence || 'basics'
    @categories   = Word::CATEGORIES
    @words        = Word.by_category(@category)
    @learned_ids  = current_user.words.pluck(:id)
  end
end
