# frozen_string_literal: true

# https://stackoverflow.com/questions/33441172/testing-equality-for-activerecordrelation
require 'test_helper'

module Quotes
  class FinderTest < ActiveSupport::TestCase
    def setup
      @quotes = Quote.all
    end

    def test_no_filters
      options = {}

      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a, @quotes.to_a
      assert_equal finder.applied_criteria, [nil, nil, false]
    end

    def test_content_filter
      content = '2'
      options = { content: }
      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a, @quotes.where('content ilike ?', "%#{content}%").to_a
      assert_equal finder.applied_criteria, [content, nil, false]
    end

    def test_rating_filter
      rating = 2
      options = { rating: }
      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a, @quotes.where('rating = ?', rating).to_a
      assert_equal finder.applied_criteria, [nil, rating, false]
    end

    def test_only_rated_filter
      options = { only_rated: 'true' }
      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a, @quotes.where('rating is not null').to_a
      assert_equal finder.applied_criteria, [nil, nil, true]
    end

    def test_filter_combinations
      options = { only_rated: 'true', content: 'quote4' }
      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a,
                   @quotes.where('rating is not null and content ilike ?', '%quote4%').to_a
      assert_equal finder.applied_criteria, ['quote4', nil, true]

      options = { only_rated: 'false', content: 'quote', rating: 2 }
      finder = Quotes::Finder.new(options)

      assert_equal finder.apply_criteria.to_a,
                   @quotes.where('content ilike ? and rating = ?', '%quote%', 2).to_a
      assert_equal finder.applied_criteria, ['quote', 2, false]
    end
  end
end
