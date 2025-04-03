# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy]

  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      flash[:notice] = 'todo succesfully created'
    else
      render :new
    end
  end

  def destroy
    @quote.destroy
  end

  def update
    if @quote.update(quote_params)
      render @quote
    else
      render :edit
    end
  end

private

  def load_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.expect(quote: [:content])
  end
end
