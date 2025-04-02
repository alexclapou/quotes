# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 255 }
end
