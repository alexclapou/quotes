# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy]

  # root only!
  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
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
    if @quote.update(quote_params)
      flash.now[:notice] = 'quote updated successfully'
    elsif params[:rating].blank?
      render :edit
    else
      flash.now[:alert] = 'something went wrong.. please refresh and try again'
    end
  end

  def destroy
    @quote.destroy
    flash.now[:notice] = 'quote removed successfully'
  end

  def filter
    finder = Quotes::Finder.new(params)

    @quotes = finder.apply_criteria
    @content, @rating, @only_rated = *finder.applied_criteria
  end

  def render *args
    @quotes_count, @average_rating = *Quotes::Stats.calculate if Quotes::Stats.required?(action_name)
    super
  end

private

  def load_quote
    @quote = Quote.find_by(id: params[:id])
  end

  def quote_params
    params.expect(quote: %i[content rating])
  end
end
