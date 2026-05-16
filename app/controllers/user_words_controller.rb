class UserWordsController < ApplicationController
  def create
    word = Word.find(params[:word_id])

    unless current_user.words.include?(word)
      current_user.user_words.create!(word: word)
      current_user.user_progress.add_study_time!(1)
    end

    render json: { learned: true, total: current_user.words.count }
  end
end
