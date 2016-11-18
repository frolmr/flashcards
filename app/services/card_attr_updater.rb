class CardAttrUpdater
  def initialize(card, answer_time)
    @card = card
    @answer_time = answer_time
  end

  def check_result(check_fail = false)
    if check_fail == true || (quality = get_quality_factor) < 3
      reset_card_attributes
    else
      e_factor = get_e_factor(quality)
      set_e_factor(e_factor)
      set_review_interval
      @card.repetition += 1
    end
    set_review_date_and_update
  end

  private

  def get_quality_factor
    case @answer_time
    when 1...20 then 5
    when 20...40 then 4
    when 40..60 then 3
    else 2
    end
  end

  def get_e_factor(quality)
    0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)
  end

  def set_e_factor(e_factor)
    (@card.e_factor += e_factor) < 1.3 ? @card.e_factor = 1.3 : nil
  end

  def set_review_interval
    @card.review_interval =
      if @card.repetition == 1
        6
      else
        (@card.review_interval * @card.e_factor).round
      end
  end

  def set_review_date_and_update
    @card.review_date = Time.now + @card.review_interval.days
    @card.save
  end

  def reset_card_attributes
    @card.repetition = 1
    @card.review_interval = 1
  end
end
