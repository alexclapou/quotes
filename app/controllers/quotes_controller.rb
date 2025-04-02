# frozen_string_literal: true

class QuotesController < ApplicationController
  def index; end

  def create
    Quote.create!(quote_params)
  end

  def destroy
    Quote.find(params[:id]).destroy
  end

  def update
    Quote.find(params[:id]).update!(quote_params)
  end

private

  def quote_params
    params.expect(quote: [:content])
  end
end
