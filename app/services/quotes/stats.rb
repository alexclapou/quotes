# frozen_string_literal: true

module Quotes
  class Stats
    def self.calculate
      # reorder(nil) because we have a default scope (ordered by created_at)
      all_stats = Quote.reorder(nil)
                       .select('COUNT(*) AS quotes_count, COUNT(rating) AS rated_count, SUM(rating) AS total_rating')[0]

      quotes_count = all_stats[:quotes_count]
      rated_count = all_stats[:rated_count]
      total_rating = all_stats[:total_rating]

      if rated_count.positive?
        average_rating = (total_rating / rated_count.to_f).round(1)
        average_rating = average_rating.to_i if average_rating.to_i == average_rating
        average_rating = "#{average_rating} / 5"
      else
        average_rating = 'no ratings'
      end

      [quotes_count, average_rating]
    end

    def self.required?(action_name)
      %w[index create destroy rate filter].include?(action_name)
    end
  end
end
