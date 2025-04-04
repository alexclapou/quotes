# frozen_string_literal: true

module ApplicationHelper
  def render_flash
    turbo_stream.replace 'flash', render('layouts/flash')
  end
end
