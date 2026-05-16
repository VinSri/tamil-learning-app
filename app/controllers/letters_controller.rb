class LettersController < ApplicationController
  def index
    @stages      = Letter.by_stage.group_by(&:stage)
    @vowels      = Letter.vowels
    @consonants  = Letter.consonants
    @learned_ids = current_user.letters.pluck(:id)
    @words_json  = Word.all.map { |w| { tamil: w.tamil, english: w.english, emoji: w.emoji } }.to_json
  end

  def combinations
    @grid        = CompoundLetters.grid
    @vowels      = CompoundLetters::VOWELS
    @consonants  = CompoundLetters::CONSONANTS
    @all_cells   = CompoundLetters.all_cells
    @cells_json  = @all_cells.map { |c| { tamil: c[:tamil], roman: c[:roman] } }.to_json
  end
end
