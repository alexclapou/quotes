# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 255 }

  default_scope { order('created_at DESC') }

  before_save :delete_rating_if_need

  private

  # remove rating if click old rating star
  # we update rating only on index > click star
  # safe to assume !changes[:content]
  def delete_rating_if_need
    self.rating = nil if self.rating == rating_was && !changes[:content]
  end

end
