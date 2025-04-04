# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy rate]

  # root only!
  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def edit
    return if @quote

    flash.now[:alert] = 'quote does not exist anymore'
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      flash.now[:notice] = 'quote created succesfully'
    else
      render :new
    end
  end

  def update
    if @quote
      if @quote.update(quote_params)
        flash.now[:notice] = 'quote updated successfully'
      else
        render :edit
      end
    else
      flash.now[:alert] = 'something went wrong.. please refresh and try again'
    end
  end

  def destroy
    flash.now[:notice] = 'quote removed successfully'
    # simulate a delete
    return unless @quote

    @quote.destroy
  end

  def rate
    if @quote
      @quote.update(quote_params)
      flash.now[:notice] = 'quote rated successfully'
    else
      flash.now[:alert] = 'something went wrong.. please refresh and try again'
    end
  end

  def filter
    finder = Quotes::Finder.new(params)

    @quotes = finder.apply_criteria
    @content, @rating, @only_rated = *finder.applied_criteria
  end

private

  def load_quote
    @quote_id = params[:id]
    @quote = Quote.find_by(id: @quote_id)
  end

  def quote_params
    params.expect(quote: %i[content rating])
  end
end
