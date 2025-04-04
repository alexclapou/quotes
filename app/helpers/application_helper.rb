# frozen_string_literal: true

module ApplicationHelper
  def render_flash
    turbo_stream.update 'flash', render('layouts/flash')
  end
end
