class NiganduController < ApplicationController
  CATEGORY_LABELS = {
    "celestial" => "வான் வகை",
    "deities"   => "வானவர் வகை",
    "ascetics"  => "ஐயர் வகை",
    "geography" => "அவனி வகை",
    "men"       => "ஆடவர் வகை",
    "objects"   => "அநுபோக வகை",
    "qualities" => "பண்பு வகை",
    "animals"   => "மா வகை",
    "plants"    => "மரம் வகை",
    "polysemy"  => "ஒருசொல்"
  }.freeze

  WORDS_CATEGORY_MAP = {
    "animals"  => "animals",
    "geography" => "places",
    "plants"   => "nature"
  }.freeze

  def index
    @categories    = NiganduEntry.categories.sort
    @category      = params[:category].presence
    @query         = params[:q].to_s.strip
    @category_labels = CATEGORY_LABELS

    if @query.present?
      @category = nil
      @entries = NiganduEntry
        .where("headword ILIKE :q OR synonyms::text ILIKE :q", q: "%#{@query}%")
        .ordered
        .limit(100)
    elsif @category.present?
      @entries = NiganduEntry.by_category(@category).ordered
    else
      @category = @categories.first
      @entries  = NiganduEntry.by_category(@category).ordered
    end

    @linked_words_category = WORDS_CATEGORY_MAP[@category]
  end

  def show
    @entry           = NiganduEntry.find(params[:id])
    @category_labels = CATEGORY_LABELS
    @related         = NiganduEntry.by_category(@entry.category)
                                   .ordered
                                   .where.not(id: @entry.id)
                                   .limit(8)
    @linked_words_category = WORDS_CATEGORY_MAP[@entry.category]
  end

  def update
    return head :forbidden unless current_user.admin?
    entry = NiganduEntry.find(params[:id])
    entry.update!(english: params[:english].to_s.strip.presence)
    render json: { english: entry.english }
  end
end
