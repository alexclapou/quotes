# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy]

  def index
    @quote = Quote.new
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.create!(quote_params)
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
