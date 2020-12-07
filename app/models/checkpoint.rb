class Checkpoint < ApplicationRecord
  has_many :tries
  has_many :stakes

  def scheduled?
    scheduled_date.present?
  end

  def closed?
    closed
  end

  def fancy_date
    scheduled_date.strftime("%d/%m %R")
  end

end
