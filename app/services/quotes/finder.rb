# frozen_string_literal: true

module Quotes
  class Finder
    def initialize(options)
      @content = options[:content]
      @rating = options[:rating]
      @previous_rating = options[:previous_rating]
      @only_rated = options[:only_rated] == 'true'
    end

    def apply_criteria
      conditions = []
      values = []

      conditions << 'rating is not null' if @only_rated

      if @content.present?
        conditions << 'content ilike ?'
        values << "%#{@content}%"
      end

      if @rating.present? && @previous_rating != @rating
        conditions << 'rating = ?'
        values << @rating
        @rating = @rating.to_i
      end

      Quote.where(conditions.join(' and '), *values)
    end

    def applied_criteria
      @rating = nil if @previous_rating == @rating && @rating.present?

      [@content, (@rating.present? && @rating.to_i) || nil, @only_rated]
    end
  end
end
