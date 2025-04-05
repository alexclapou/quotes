# frozen_string_literal: true

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:one)
    @quote2 = quotes(:two)
    @quote3 = quotes(:three)
    @quote4 = quotes(:four)
  end

  def test_valid_quote
    assert @quote.valid?
  end

  def test_invalid_quote_without_content
    @quote.content = ''

    refute @quote.valid?
    assert_includes @quote.errors[:content], "can't be blank"
  end

  def test_invalid_quote_content_too_long
    @quote.content = '1' * 256

    refute @quote.valid?
    assert_includes @quote.errors[:content], 'is too long (maximum is 255 characters)'
  end

  def test_valid_rating
    @quote.rating = 1

    assert @quote.valid?
  end

  def test_invalid_rating
    @quote.rating = 6

    refute @quote.valid?
    assert_includes @quote.errors[:rating], 'must be between 1 and 5'
  end

  def test_default_scope
    assert_equal Quote.all.to_a, [@quote, @quote4, @quote2, @quote3]
  end

  def test_should_delete_rating
    @quote2.rating = 3
    @quote2.save

    assert_nil @quote2.rating
  end

  def test_should_not_delete_rating
    @quote2.rating = 1
    @quote2.save

    refute_nil @quote2.rating
  end
end
