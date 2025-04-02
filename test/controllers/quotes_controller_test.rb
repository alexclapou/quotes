# frozen_string_literal: true

require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @quote = quotes(:one)
  end

  def test_quotes_index
    get quotes_path
    assert_response :success
  end

  def test_should_create_quote
    assert_difference('Quote.count') do
      params = { quote: { content: 'Quote' } }
      post quotes_url, params:
    end

    assert_response :success
  end

  def test_should_delete_quote
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote)
    end
  end

  def test_should_update_quote
    params = { quote: { content: 'updated' } }
    new_content = params[:quote][:content]
    old_content = @quote.content

    assert_not_equal old_content, new_content
    patch quote_url(@quote), params: params
    @quote.reload
    assert_equal new_content, @quote.content
  end
end
