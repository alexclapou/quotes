# frozen_string_literal: true

# https://stackoverflow.com/questions/33441172/testing-equality-for-activerecordrelation
require 'test_helper'

module Quotes
  class StatsTest < ActiveSupport::TestCase
    def setup
      @quotes = Quote.all
    end

    def test_action_required_for_stats_changes
      %w[index update create destroy filter].each do |action|
        assert Quotes::Stats.required?(action)
      end
    end

    # this should have better testing
    def test_calculate_stats
      quotes_count, average_rating = *Quotes::Stats.calculate

      assert_equal quotes_count, 4
      assert_equal average_rating, '2.3 / 5'
    end
  end
end
