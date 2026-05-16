class ReadingPassagesController < ApplicationController
  def index
    @passages_by_level = ReadingPassage::LEVELS.each_with_object({}) do |level, hash|
      passages = ReadingPassage.by_level(level)
      hash[level] = passages if passages.any?
    end
  end

  def show
    @passage = ReadingPassage.find(params[:id])
  end
end
