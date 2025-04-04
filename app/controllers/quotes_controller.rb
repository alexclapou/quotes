# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :load_quote, only: %w[show update edit destroy rate]

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

  def destroy
    flash.now[:notice] = 'quote removed successfully'
    return unless @quote

    @quote.destroy
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

  def rate
    if @quote
      @quote.update(quote_params)
      flash.now[:notice] = 'quote rated successfully'
    else
      flash.now[:alert] = 'something went wrong.. please refresh and try again'
    end
  end

  def filter
    content = params[:content]
    rating = params[:rating]
    previous_rating = params[:previous_rating]
    @only_rated = params[:only_rated] == 'true'

    conditions = []
    values = []

    if content.present?
      conditions << 'content ilike ?'
      values << "%#{content}%"
      @content = content
    end

    if rating.present? && previous_rating != rating
      conditions << 'rating = ?'
      values << rating
      @rating = rating.to_i
    end

    @quotes = Quote.where(conditions.join(' AND '), *values)
    @quotes = @quotes.where.not(rating: nil) if @only_rated

    flash[:notice] = if conditions.empty? && !@only_rated
                       'filters cleared successfully'
                     else
                       'filters applied successfully'
                     end
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
