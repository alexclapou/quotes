# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy]

  def index
    @quote = Quote.new
    @quotes = Quote.all
  end

  def create
    Quote.create!(quote_params)

    # TODO: just append the new quote
    redirect_to quotes_path
  end

  def destroy
    @quote.destroy
  end

  def update
    @quote.update!(quote_params)

    redirect_to quote_path(@quote)
  end

private

  def load_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.expect(quote: [:content])
  end
end
