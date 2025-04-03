# frozen_string_literal: true

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:one)
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
end
