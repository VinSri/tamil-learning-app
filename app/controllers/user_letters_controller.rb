class UserLettersController < ApplicationController
  def create
    @letter     = Letter.find(params[:letter_id])
    user_letter = current_user.user_letters.find_by(letter: @letter)

    if user_letter
      user_letter.destroy
      @learned = false
    else
      current_user.user_letters.create!(letter: @letter)
      current_user.user_progress.add_study_time!(1)
      @learned = true
    end

    @total       = current_user.letters.count
    @total_all   = Letter.count

    respond_to do |format|
      format.turbo_stream
      format.json { render json: { learned: @learned, total: @total } }
    end
  end
end
